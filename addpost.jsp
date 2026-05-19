<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>

<%
    // Database configuration
    String dbDriver = "com.mysql.cj.jdbc.Driver";
    String dbUrl = "jdbc:mysql://localhost:3306/cms_db";
    String dbUser = "root";
    String dbPassword = "password";
    
    String message = "";
    String messageType = ""; // success or error
    boolean postAdded = false;

    // Handle form submission
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String category = request.getParameter("category");
        String status = request.getParameter("status");
        String author = request.getParameter("author");
        
        // Validation
        if (title == null || title.trim().isEmpty()) {
            message = "Title is required";
            messageType = "error";
        } else if (content == null || content.trim().isEmpty()) {
            message = "Content is required";
            messageType = "error";
        } else if (title.length() < 5) {
            message = "Title must be at least 5 characters";
            messageType = "error";
        } else if (content.length() < 20) {
            message = "Content must be at least 20 characters";
            messageType = "error";
        } else {
            // Insert into database
            Connection conn = null;
            PreparedStatement stmt = null;
            try {
                Class.forName(dbDriver);
                conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
                
                String insertSQL = "INSERT INTO posts (title, content, category, status, author, created_at, updated_at) VALUES (?, ?, ?, ?, ?, NOW(), NOW())";
                stmt = conn.prepareStatement(insertSQL);
                stmt.setString(1, title);
                stmt.setString(2, content);
                stmt.setString(3, category != null ? category : "General");
                stmt.setString(4, status != null ? status : "draft");
                stmt.setString(5, author != null ? author : "Admin");
                
                int rowsInserted = stmt.executeUpdate();
                
                if (rowsInserted > 0) {
                    message = "Post added successfully! Redirecting to dashboard...";
                    messageType = "success";
                    postAdded = true;
                } else {
                    message = "Error adding post. Please try again.";
                    messageType = "error";
                }
            } catch (ClassNotFoundException e) {
                message = "Database driver not found: " + e.getMessage();
                messageType = "error";
            } catch (SQLException e) {
                message = "Database error: " + e.getMessage();
                messageType = "error";
            } finally {
                try {
                    if (stmt != null) stmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Add New Blog Post - Content Management System">
    <title>Add New Post - Content Management System</title>
    <link rel="stylesheet" href="style.css">
    <style>
        /* Add Post Page Styles */
        .addpost-container {
            min-height: 100vh;
            background-color: var(--light-bg);
        }

        .addpost-header {
            background-color: var(--white);
            border-bottom: 1px solid var(--border-color);
            padding: 1.5rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            position: sticky;
            top: 0;
            z-index: 50;
        }

        .addpost-header h1 {
            margin: 0;
            font-size: 1.75rem;
            color: var(--dark-text);
        }

        .header-actions {
            display: flex;
            gap: 1rem;
        }

        .breadcrumb {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.9rem;
            color: var(--gray-text);
            margin-bottom: 1.5rem;
        }

        .breadcrumb a {
            color: var(--primary-color);
        }

        .breadcrumb a:hover {
            text-decoration: underline;
        }

        .content-wrapper {
            max-width: 1000px;
            margin: 0 auto;
            padding: 2rem;
        }

        /* Messages */
        .alert {
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            border-left: 4px solid;
            display: none;
        }

        .alert.show {
            display: block;
            animation: slideIn 0.3s ease-out;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .alert-success {
            background-color: rgba(16, 185, 129, 0.1);
            color: var(--success-color);
            border-left-color: var(--success-color);
        }

        .alert-error {
            background-color: rgba(239, 68, 68, 0.1);
            color: var(--danger-color);
            border-left-color: var(--danger-color);
        }

        .alert-info {
            background-color: rgba(37, 99, 235, 0.1);
            color: var(--primary-color);
            border-left-color: var(--primary-color);
        }

        /* Form Container */
        .form-container {
            background-color: var(--white);
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            border: 1px solid var(--border-color);
            padding: 2rem;
        }

        .form-section {
            margin-bottom: 2rem;
        }

        .form-section:last-child {
            margin-bottom: 0;
        }

        .form-section-title {
            font-size: 1.1rem;
            font-weight: 700;
            color: var(--dark-text);
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid var(--border-color);
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .form-row.full {
            grid-template-columns: 1fr;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group:last-child {
            margin-bottom: 0;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: var(--dark-text);
            font-size: 0.95rem;
        }

        .form-group label .required {
            color: var(--danger-color);
        }

        .form-group input,
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-size: 1rem;
            font-family: inherit;
            transition: all 0.3s ease;
            background-color: var(--white);
        }

        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        .form-group textarea {
            resize: vertical;
            min-height: 350px;
            font-family: 'Monaco', 'Courier New', monospace;
        }

        .form-help {
            font-size: 0.85rem;
            color: var(--gray-text);
            margin-top: 0.5rem;
        }

        /* Character Count */
        .char-count {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 0.5rem;
            font-size: 0.85rem;
            color: var(--gray-text);
        }

        .char-count-bar {
            height: 4px;
            background-color: var(--border-color);
            border-radius: 2px;
            overflow: hidden;
            margin-top: 0.25rem;
        }

        .char-count-fill {
            height: 100%;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            transition: width 0.3s ease;
        }

        /* Form Actions */
        .form-actions {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 1px solid var(--border-color);
        }

        .form-actions .btn {
            padding: 0.8rem 1.5rem;
            font-size: 1rem;
        }

        .btn-save {
            background-color: var(--success-color);
            color: var(--white);
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-save:hover {
            background-color: #059669;
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .btn-save:active {
            transform: translateY(0);
        }

        .btn-cancel {
            background-color: transparent;
            color: var(--gray-text);
            border: 2px solid var(--border-color);
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-cancel:hover {
            border-color: var(--gray-text);
            color: var(--dark-text);
        }

        .btn-save.loading {
            opacity: 0.7;
            cursor: not-allowed;
        }

        .btn-save.loading::after {
            content: " ...";
            animation: dots 1.5s steps(4, end) infinite;
        }

        @keyframes dots {
            0%, 20% { content: " ..."; }
            40% { content: " ...."; }
            60% { content: " ....."; }
            80%, 100% { content: " ..."; }
        }

        /* Editor Toolbar (optional) */
        .editor-toolbar {
            display: flex;
            gap: 0.5rem;
            padding: 0.75rem;
            background-color: var(--light-bg);
            border: 1px solid var(--border-color);
            border-bottom: none;
            border-radius: 8px 8px 0 0;
            flex-wrap: wrap;
        }

        .editor-toolbar button {
            padding: 0.4rem 0.8rem;
            background-color: var(--white);
            border: 1px solid var(--border-color);
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.85rem;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.25rem;
        }

        .editor-toolbar button:hover {
            background-color: var(--primary-color);
            color: var(--white);
            border-color: var(--primary-color);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .addpost-header {
                flex-direction: column;
                gap: 1rem;
                align-items: flex-start;
                padding: 1rem;
            }

            .addpost-header h1 {
                font-size: 1.5rem;
            }

            .content-wrapper {
                padding: 1rem;
            }

            .form-container {
                padding: 1.5rem;
            }

            .form-row {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .form-actions {
                flex-direction: column-reverse;
            }

            .form-actions .btn {
                width: 100%;
            }
        }

        @media (max-width: 480px) {
            .addpost-header h1 {
                font-size: 1.25rem;
            }

            .content-wrapper {
                padding: 0.75rem;
            }

            .form-container {
                padding: 1rem;
            }

            .form-group textarea {
                min-height: 250px;
            }

            .editor-toolbar {
                display: none;
            }

            .form-section-title {
                font-size: 1rem;
            }
        }
    </style>
</head>
<body class="addpost-container">
    <!-- Header -->
    <header class="addpost-header">
        <h1>➕ Add New Post</h1>
        <div class="header-actions">
            <a href="dashboard.jsp" class="btn btn-outline btn-sm">← Back to Dashboard</a>
        </div>
    </header>

    <!-- Main Content -->
    <div class="content-wrapper">
        <!-- Breadcrumb -->
        <div class="breadcrumb">
            <a href="dashboard.jsp">Dashboard</a>
            <span>/</span>
            <a href="dashboard.jsp?section=posts">Posts</a>
            <span>/</span>
            <span>Add New</span>
        </div>

        <!-- Alert Messages -->
        <% if (!message.isEmpty()) { %>
            <div class="alert alert-<%= messageType %> show" id="alert">
                <%= message %>
            </div>
            <% if (postAdded) { %>
                <script>
                    setTimeout(function() {
                        window.location.href = 'dashboard.jsp';
                    }, 2000);
                </script>
            <% } %>
        <% } %>

        <!-- Form Container -->
        <div class="form-container">
            <form id="addPostForm" method="POST" onsubmit="return validateForm()">
                <!-- Basic Information Section -->
                <div class="form-section">
                    <h2 class="form-section-title">📝 Basic Information</h2>
                    
                    <div class="form-group">
                        <label for="title">
                            Post Title <span class="required">*</span>
                        </label>
                        <input 
                            type="text" 
                            id="title" 
                            name="title" 
                            placeholder="Enter post title..." 
                            required
                            minlength="5"
                            maxlength="200"
                        >
                        <div class="char-count">
                            <span>Character count:</span>
                            <span id="titleCount">0/200</span>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="category">
                                Category <span class="required">*</span>
                            </label>
                            <select id="category" name="category" required>
                                <option value="">Select a category</option>
                                <option value="General">General</option>
                                <option value="Technology">Technology</option>
                                <option value="Business">Business</option>
                                <option value="Lifestyle">Lifestyle</option>
                                <option value="Tutorial">Tutorial</option>
                                <option value="News">News</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="status">
                                Status <span class="required">*</span>
                            </label>
                            <select id="status" name="status" required>
                                <option value="draft">Draft</option>
                                <option value="published">Published</option>
                                <option value="archived">Archived</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="author">Author</label>
                        <input 
                            type="text" 
                            id="author" 
                            name="author" 
                            placeholder="Author name (default: Admin)" 
                            maxlength="100"
                        >
                        <p class="form-help">Leave empty to use current admin user</p>
                    </div>
                </div>

                <!-- Content Section -->
                <div class="form-section">
                    <h2 class="form-section-title">📄 Post Content</h2>
                    
                    <div class="form-group">
                        <label for="content">
                            Post Content <span class="required">*</span>
                        </label>
                        <div class="editor-toolbar">
                            <button type="button" onclick="insertMarkdown('**', '**', 'Bold')">
                                <strong>B</strong>
                            </button>
                            <button type="button" onclick="insertMarkdown('*', '*', 'Italic')">
                                <em>I</em>
                            </button>
                            <button type="button" onclick="insertMarkdown('[', '](url)', 'Link')">
                                🔗
                            </button>
                            <button type="button" onclick="insertMarkdown('- ', '', 'List')">
                                📋
                            </button>
                            <button type="button" onclick="insertMarkdown('`', '`', 'Code')">
                                &lt;/&gt;
                            </button>
                        </div>
                        <textarea 
                            id="content" 
                            name="content" 
                            placeholder="Write your post content here... (Minimum 20 characters)" 
                            required
                            minlength="20"
                        ></textarea>
                        <div class="char-count">
                            <span>Character count:</span>
                            <span id="contentCount">0</span>
                        </div>
                        <div class="char-count-bar">
                            <div class="char-count-fill" id="contentProgress"></div>
                        </div>
                        <p class="form-help">Minimum 20 characters required. Markdown formatting is supported.</p>
                    </div>
                </div>

                <!-- Form Actions -->
                <div class="form-actions">
                    <a href="dashboard.jsp" class="btn btn-cancel">Cancel</a>
                    <button type="submit" class="btn btn-save" id="submitBtn">💾 Save & Publish</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Character counter for title
        document.getElementById('title').addEventListener('input', function() {
            const count = this.value.length;
            document.getElementById('titleCount').textContent = count + '/200';
        });

        // Character counter and progress for content
        document.getElementById('content').addEventListener('input', function() {
            const count = this.value.length;
            document.getElementById('contentCount').textContent = count + ' characters';
            
            // Calculate progress (max 2000 characters for visual reference)
            const progress = Math.min((count / 2000) * 100, 100);
            document.getElementById('contentProgress').style.width = progress + '%';
        });

        // Form validation
        function validateForm() {
            const title = document.getElementById('title').value.trim();
            const content = document.getElementById('content').value.trim();
            const category = document.getElementById('category').value;

            if (!title) {
                showAlert('Title is required', 'error');
                return false;
            }

            if (title.length < 5) {
                showAlert('Title must be at least 5 characters', 'error');
                return false;
            }

            if (!content) {
                showAlert('Content is required', 'error');
                return false;
            }

            if (content.length < 20) {
                showAlert('Content must be at least 20 characters', 'error');
                return false;
            }

            if (!category) {
                showAlert('Please select a category', 'error');
                return false;
            }

            // Show loading state
            const submitBtn = document.getElementById('submitBtn');
            submitBtn.classList.add('loading');
            submitBtn.disabled = true;

            return true;
        }

        // Show alert message
        function showAlert(message, type) {
            const alert = document.createElement('div');
            alert.className = 'alert alert-' + type + ' show';
            alert.textContent = message;
            
            const wrapper = document.querySelector('.content-wrapper');
            wrapper.insertBefore(alert, wrapper.firstChild);
            
            setTimeout(function() {
                alert.remove();
            }, 4000);
        }

        // Insert markdown formatting
        function insertMarkdown(before, after, placeholder) {
            const textarea = document.getElementById('content');
            const start = textarea.selectionStart;
            const end = textarea.selectionEnd;
            const selectedText = textarea.value.substring(start, end) || placeholder;
            const newText = textarea.value.substring(0, start) + before + selectedText + after + textarea.value.substring(end);
            
            textarea.value = newText;
            textarea.focus();
            textarea.selectionStart = start + before.length;
            textarea.selectionEnd = start + before.length + selectedText.length;
            
            // Trigger input event for counter update
            textarea.dispatchEvent(new Event('input'));
        }

        // Auto-save draft (optional - stores in localStorage)
        setInterval(function() {
            const formData = {
                title: document.getElementById('title').value,
                content: document.getElementById('content').value,
                category: document.getElementById('category').value,
                status: document.getElementById('status').value,
                author: document.getElementById('author').value
            };
            localStorage.setItem('postDraft', JSON.stringify(formData));
        }, 10000); // Auto-save every 10 seconds

        // Restore draft on page load
        window.addEventListener('load', function() {
            const draft = localStorage.getItem('postDraft');
            if (draft) {
                const formData = JSON.parse(draft);
                document.getElementById('title').value = formData.title;
                document.getElementById('content').value = formData.content;
                document.getElementById('category').value = formData.category;
                document.getElementById('status').value = formData.status;
                document.getElementById('author').value = formData.author;
                
                // Trigger input events for counters
                document.getElementById('title').dispatchEvent(new Event('input'));
                document.getElementById('content').dispatchEvent(new Event('input'));
            }
        });

        // Clear draft on successful submit
        document.getElementById('addPostForm').addEventListener('submit', function(e) {
            if (validateForm()) {
                localStorage.removeItem('postDraft');
            }
        });

        // Prevent accidental navigation if form has unsaved changes
        window.addEventListener('beforeunload', function(e) {
            const title = document.getElementById('title').value;
            const content = document.getElementById('content').value;
            
            if (title || content) {
                e.preventDefault();
                e.returnValue = '';
            }
        });

        // Remove unsaved changes warning on successful submit
        document.getElementById('addPostForm').addEventListener('submit', function() {
            window.onbeforeunload = null;
        });
    </script>
</body>
</html>
