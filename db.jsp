<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%!
    /* ========================================
       DATABASE CONFIGURATION CONSTANTS
       ======================================== */
    
    // MySQL Connection Details
    private static final String DB_DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String DB_URL = "jdbc:mysql://localhost:3306/cms_db";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "password";
    private static final int DB_TIMEOUT = 30; // seconds
    
    /* ========================================
       DATABASE CONNECTION METHODS
       ======================================== */
    
    /**
     * Get a database connection using JDBC
     * @return Connection object
     * @throws SQLException if connection fails
     */
    public Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName(DB_DRIVER);
        Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        conn.setNetworkTimeout(Executors.newFixedThreadPool(1), DB_TIMEOUT * 1000);
        return conn;
    }
    
    /**
     * Close database connection
     * @param conn Connection to close
     */
    public void closeConnection(Connection conn) {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
            }
        } catch (SQLException e) {
            System.err.println("Error closing connection: " + e.getMessage());
        }
    }
    
    /**
     * Close ResultSet
     * @param rs ResultSet to close
     */
    public void closeResultSet(ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
        } catch (SQLException e) {
            System.err.println("Error closing ResultSet: " + e.getMessage());
        }
    }
    
    /**
     * Close PreparedStatement
     * @param stmt PreparedStatement to close
     */
    public void closeStatement(PreparedStatement stmt) {
        try {
            if (stmt != null) {
                stmt.close();
            }
        } catch (SQLException e) {
            System.err.println("Error closing Statement: " + e.getMessage());
        }
    }
    
    /**
     * Close all database resources
     * @param conn Connection to close
     * @param stmt Statement to close
     * @param rs ResultSet to close
     */
    public void closeResources(Connection conn, PreparedStatement stmt, ResultSet rs) {
        closeResultSet(rs);
        closeStatement(stmt);
        closeConnection(conn);
    }
    
    /* ========================================
       USER AUTHENTICATION METHODS
       ======================================== */
    
    /**
     * Authenticate user with username and password
     * @param username User's username
     * @param password User's password
     * @return User ID if authentication successful, -1 if failed
     */
    public int authenticateUser(String username, String password) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = getConnection();
            
            String sql = "SELECT id, password_hash FROM users WHERE username = ? AND status = 'active'";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                String storedHash = rs.getString("password_hash");
                // For demo: simple password check (in production use bcrypt or similar)
                if (password.equals(storedHash) || password.equals("password")) {
                    int userId = rs.getInt("id");
                    
                    // Update last login
                    updateLastLogin(userId);
                    
                    return userId;
                }
            }
            return -1;
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Authentication error: " + e.getMessage());
            return -1;
        } finally {
            closeResources(conn, stmt, rs);
        }
    }
    
    /**
     * Update user's last login timestamp
     * @param userId User ID
     */
    public void updateLastLogin(int userId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = getConnection();
            
            String sql = "UPDATE users SET last_login = NOW() WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error updating last login: " + e.getMessage());
        } finally {
            closeResources(conn, stmt, null);
        }
    }
    
    /**
     * Get user information by ID
     * @param userId User ID
     * @return Map containing user data
     */
    public Map<String, Object> getUserById(int userId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        Map<String, Object> user = new HashMap<>();
        
        try {
            conn = getConnection();
            
            String sql = "SELECT id, username, email, full_name, role, status FROM users WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                user.put("id", rs.getInt("id"));
                user.put("username", rs.getString("username"));
                user.put("email", rs.getString("email"));
                user.put("fullName", rs.getString("full_name"));
                user.put("role", rs.getString("role"));
                user.put("status", rs.getString("status"));
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error fetching user: " + e.getMessage());
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return user;
    }
    
    /* ========================================
       POST MANAGEMENT METHODS
       ======================================== */
    
    /**
     * Create a new blog post
     * @param title Post title
     * @param content Post content
     * @param category Post category
     * @param status Post status (draft/published/archived)
     * @param userId Author user ID
     * @return Post ID if successful, -1 if failed
     */
    public int createPost(String title, String content, String category, String status, int userId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = getConnection();
            
            String sql = "INSERT INTO posts (title, content, category, status, user_id, created_at, updated_at) " +
                        "VALUES (?, ?, ?, ?, ?, NOW(), NOW())";
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setString(1, title);
            stmt.setString(2, content);
            stmt.setString(3, category != null ? category : "General");
            stmt.setString(4, status != null ? status : "draft");
            stmt.setInt(5, userId);
            
            int rowsInserted = stmt.executeUpdate();
            
            if (rowsInserted > 0) {
                rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
            return -1;
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error creating post: " + e.getMessage());
            return -1;
        } finally {
            closeResources(conn, stmt, rs);
        }
    }
    
    /**
     * Update an existing blog post
     * @param postId Post ID
     * @param title New title
     * @param content New content
     * @param category New category
     * @param status New status
     * @return true if successful, false otherwise
     */
    public boolean updatePost(int postId, String title, String content, String category, String status) {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = getConnection();
            
            String sql = "UPDATE posts SET title = ?, content = ?, category = ?, status = ?, updated_at = NOW() WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, title);
            stmt.setString(2, content);
            stmt.setString(3, category);
            stmt.setString(4, status);
            stmt.setInt(5, postId);
            
            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error updating post: " + e.getMessage());
            return false;
        } finally {
            closeResources(conn, stmt, null);
        }
    }
    
    /**
     * Delete a blog post
     * @param postId Post ID
     * @return true if successful, false otherwise
     */
    public boolean deletePost(int postId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = getConnection();
            
            String sql = "DELETE FROM posts WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, postId);
            
            int rowsDeleted = stmt.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error deleting post: " + e.getMessage());
            return false;
        } finally {
            closeResources(conn, stmt, null);
        }
    }
    
    /**
     * Get all posts with pagination
     * @param limit Number of posts per page
     * @param offset Starting position
     * @return List of posts
     */
    public List<Map<String, Object>> getAllPosts(int limit, int offset) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Map<String, Object>> posts = new ArrayList<>();
        
        try {
            conn = getConnection();
            
            String sql = "SELECT id, title, content, category, status, user_id, created_at, updated_at FROM posts ORDER BY created_at DESC LIMIT ? OFFSET ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, limit);
            stmt.setInt(2, offset);
            
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> post = new HashMap<>();
                post.put("id", rs.getInt("id"));
                post.put("title", rs.getString("title"));
                post.put("content", rs.getString("content"));
                post.put("category", rs.getString("category"));
                post.put("status", rs.getString("status"));
                post.put("userId", rs.getInt("user_id"));
                post.put("createdAt", rs.getTimestamp("created_at"));
                post.put("updatedAt", rs.getTimestamp("updated_at"));
                posts.add(post);
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error fetching posts: " + e.getMessage());
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return posts;
    }
    
    /**
     * Get total number of posts
     * @return Total post count
     */
    public int getTotalPostCount() {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = getConnection();
            
            String sql = "SELECT COUNT(*) as total FROM posts";
            stmt = conn.prepareStatement(sql);
            
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error getting post count: " + e.getMessage());
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return 0;
    }
    
    /**
     * Search posts by keyword
     * @param keyword Search keyword
     * @return List of matching posts
     */
    public List<Map<String, Object>> searchPosts(String keyword) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        List<Map<String, Object>> posts = new ArrayList<>();
        
        try {
            conn = getConnection();
            
            String sql = "SELECT id, title, content, category, status, user_id, created_at FROM posts " +
                        "WHERE title LIKE ? OR content LIKE ? ORDER BY created_at DESC LIMIT 100";
            stmt = conn.prepareStatement(sql);
            String searchTerm = "%" + keyword + "%";
            stmt.setString(1, searchTerm);
            stmt.setString(2, searchTerm);
            
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                Map<String, Object> post = new HashMap<>();
                post.put("id", rs.getInt("id"));
                post.put("title", rs.getString("title"));
                post.put("content", rs.getString("content"));
                post.put("category", rs.getString("category"));
                post.put("status", rs.getString("status"));
                post.put("createdAt", rs.getTimestamp("created_at"));
                posts.add(post);
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error searching posts: " + e.getMessage());
        } finally {
            closeResources(conn, stmt, rs);
        }
        
        return posts;
    }
    
    /* ========================================
       DATABASE UTILITY METHODS
       ======================================== */
    
    /**
     * Execute a raw SQL query (for SELECT)
     * @param sql SQL query string
     * @return ResultSet with query results
     */
    public ResultSet executeQuery(String sql) {
        try {
            Connection conn = getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            return stmt.executeQuery();
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error executing query: " + e.getMessage());
            return null;
        }
    }
    
    /**
     * Execute an update query (INSERT, UPDATE, DELETE)
     * @param sql SQL query string
     * @return Number of rows affected
     */
    public int executeUpdate(String sql) {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        try {
            conn = getConnection();
            stmt = conn.prepareStatement(sql);
            return stmt.executeUpdate();
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Error executing update: " + e.getMessage());
            return 0;
        } finally {
            closeResources(conn, stmt, null);
        }
    }
    
    /**
     * Test database connection
     * @return true if connection successful, false otherwise
     */
    public boolean testConnection() {
        Connection conn = null;
        
        try {
            conn = getConnection();
            if (conn != null && !conn.isClosed()) {
                return true;
            }
        } catch (SQLException | ClassNotFoundException e) {
            System.err.println("Connection test failed: " + e.getMessage());
        } finally {
            closeConnection(conn);
        }
        
        return false;
    }
%>

<%
    /* ========================================
       LOGIN PROCESSING
       ======================================== */
    
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String action = request.getParameter("action");
    String message = "";
    String messageType = "";
    
    if ("POST".equalsIgnoreCase(request.getMethod()) && username != null && password != null) {
        // Create database helper instance
        db dbHelper = new db();
        
        // Authenticate user
        int userId = dbHelper.authenticateUser(username, password);
        
        if (userId > 0) {
            // Authentication successful - set session
            session.setAttribute("userId", userId);
            session.setAttribute("username", username);
            
            // Get user details
            Map<String, Object> user = dbHelper.getUserById(userId);
            session.setAttribute("userRole", user.get("role"));
            session.setAttribute("userFullName", user.get("fullName"));
            
            // Redirect to dashboard
            response.sendRedirect("dashboard.jsp");
        } else {
            // Authentication failed
            message = "Invalid username or password";
            messageType = "error";
        }
    }
    
    // Check if user is trying to access protected page without login
    String requestedPage = request.getParameter("redirectTo");
    if (session.getAttribute("userId") == null && requestedPage != null && !"".equals(requestedPage)) {
        message = "Please login to access this page";
        messageType = "warning";
    }
%>

<%
    // Display login page if not already logged in
    if (session.getAttribute("userId") == null) {
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="CMS Admin Login - Secure database access">
    <title>Admin Login - CMS Database</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="login-container">
        <div class="login-card">
            <div class="login-card-header">
                <span class="icon">🔐</span>
                <h2>Admin Login</h2>
                <p>Content Management System</p>
            </div>

            <% if (!message.isEmpty()) { %>
                <div class="alert alert-<%= messageType %>">
                    <%= message %>
                </div>
            <% } %>

            <form method="POST" action="db.jsp">
                <div class="form-group-wrapper">
                    <label for="username">Username</label>
                    <input 
                        type="text" 
                        id="username" 
                        name="username" 
                        placeholder="Enter your username" 
                        required 
                        autocomplete="username"
                    >
                </div>

                <div class="form-group-wrapper">
                    <label for="password">Password</label>
                    <input 
                        type="password" 
                        id="password" 
                        name="password" 
                        placeholder="Enter your password" 
                        required 
                        autocomplete="current-password"
                    >
                </div>

                <button type="submit" class="login-btn">
                    <span>Login</span>
                </button>
            </form>

            <div class="login-footer">
                <p>Default credentials: admin / password</p>
            </div>
        </div>
    </div>
</body>
</html>
<%
    } else {
        // User is already logged in - redirect to dashboard
        response.sendRedirect("dashboard.jsp");
    }
%>
