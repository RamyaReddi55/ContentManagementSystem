<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="CMS Admin Dashboard - Manage your content efficiently">
    <title>Admin Dashboard - Content Management System</title>
    <link rel="stylesheet" href="style.css">
    <style>
        /* Dashboard-specific styles */
        .dashboard-wrapper {
            min-height: 100vh;
            display: grid;
            grid-template-columns: 250px 1fr;
            background-color: var(--light-bg);
        }

        /* Sidebar */
        .sidebar {
            background-color: var(--white);
            border-right: 1px solid var(--border-color);
            position: fixed;
            left: 0;
            top: 0;
            height: 100vh;
            width: 250px;
            overflow-y: auto;
            padding: 1.5rem 0;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
            z-index: 100;
        }

        .sidebar-brand {
            padding: 1rem 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 1rem;
            border-bottom: 1px solid var(--border-color);
        }

        .sidebar-brand-icon {
            font-size: 1.75rem;
        }

        .sidebar-brand-text h3 {
            margin: 0;
            font-size: 1.1rem;
            color: var(--primary-color);
        }

        .sidebar-brand-text p {
            margin: 0;
            font-size: 0.75rem;
            color: var(--gray-text);
        }

        .sidebar-menu {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .sidebar-menu-section {
            padding: 1rem 0;
        }

        .sidebar-menu-label {
            display: block;
            padding: 0.5rem 1.5rem;
            font-size: 0.75rem;
            text-transform: uppercase;
            font-weight: 700;
            color: var(--gray-text);
            letter-spacing: 0.5px;
        }

        .sidebar-menu li {
            margin: 0;
        }

        .sidebar-menu a {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.75rem 1.5rem;
            color: var(--gray-text);
            transition: all 0.3s ease;
            border-left: 3px solid transparent;
        }

        .sidebar-menu a:hover,
        .sidebar-menu a.active {
            background-color: rgba(37, 99, 235, 0.05);
            color: var(--primary-color);
            border-left-color: var(--primary-color);
        }

        .sidebar-menu-icon {
            font-size: 1.25rem;
            min-width: 1.25rem;
        }

        .sidebar-menu-text {
            flex: 1;
            font-size: 0.95rem;
            font-weight: 500;
        }

        .sidebar-menu-badge {
            background-color: var(--danger-color);
            color: var(--white);
            border-radius: 50%;
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.75rem;
            font-weight: 700;
        }

        .sidebar-footer {
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            padding: 1rem 1.5rem;
            border-top: 1px solid var(--border-color);
            background-color: var(--white);
        }

        .sidebar-footer a {
            display: block;
            padding: 0.75rem;
            text-align: center;
            background-color: var(--danger-color);
            color: var(--white);
            border-radius: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .sidebar-footer a:hover {
            background-color: #dc2626;
            text-decoration: none;
        }

        /* Main Content */
        .dashboard-main {
            margin-left: 250px;
            padding: 0;
        }

        /* Top Header */
        .dashboard-header {
            background-color: var(--white);
            border-bottom: 1px solid var(--border-color);
            padding: 1.25rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            position: sticky;
            top: 0;
            z-index: 50;
        }

        .dashboard-header-left {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }

        .dashboard-title {
            margin: 0;
            font-size: 1.5rem;
            color: var(--dark-text);
            font-weight: 700;
        }

        .dashboard-header-right {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }

        .search-bar {
            position: relative;
            display: none;
        }

        .search-bar input {
            padding: 0.5rem 1rem 0.5rem 2.5rem;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            width: 250px;
            font-size: 0.9rem;
        }

        .search-bar input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        .search-bar::before {
            content: "🔍";
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
        }

        .user-profile {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 0.5rem;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .user-profile:hover {
            background-color: var(--light-bg);
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--white);
            font-size: 1.25rem;
            font-weight: 700;
        }

        .user-info {
            display: flex;
            flex-direction: column;
        }

        .user-name {
            font-weight: 600;
            color: var(--dark-text);
            font-size: 0.9rem;
        }

        .user-role {
            font-size: 0.75rem;
            color: var(--gray-text);
        }

        .notification-icon {
            font-size: 1.25rem;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
        }

        .notification-icon:hover {
            transform: scale(1.1);
        }

        .notification-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background-color: var(--danger-color);
            color: var(--white);
            border-radius: 50%;
            width: 18px;
            height: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.7rem;
            font-weight: 700;
        }

        /* Dashboard Content */
        .dashboard-content {
            padding: 2rem;
        }

        .breadcrumb {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 2rem;
            font-size: 0.9rem;
            color: var(--gray-text);
        }

        .breadcrumb a {
            color: var(--primary-color);
        }

        .breadcrumb a:hover {
            text-decoration: underline;
        }

        /* Stats Grid */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background-color: var(--white);
            border-radius: 8px;
            padding: 1.5rem;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            border: 1px solid var(--border-color);
        }

        .stat-card:hover {
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            transform: translateY(-2px);
        }

        .stat-card-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 1rem;
        }

        .stat-card-title {
            font-size: 0.95rem;
            color: var(--gray-text);
            font-weight: 600;
            margin: 0;
        }

        .stat-card-icon {
            font-size: 1.75rem;
        }

        .stat-card-value {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 0.5rem;
        }

        .stat-card-change {
            font-size: 0.85rem;
            display: flex;
            align-items: center;
            gap: 0.25rem;
        }

        .stat-card-change.positive {
            color: var(--success-color);
        }

        .stat-card-change.negative {
            color: var(--danger-color);
        }

        /* Content Table */
        .content-section {
            background-color: var(--white);
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            border: 1px solid var(--border-color);
            overflow: hidden;
        }

        .section-header {
            padding: 1.5rem;
            border-bottom: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .section-title {
            margin: 0;
            font-size: 1.25rem;
            color: var(--dark-text);
            font-weight: 700;
        }

        .section-controls {
            display: flex;
            gap: 1rem;
        }

        .btn-sm {
            padding: 0.5rem 1rem;
            font-size: 0.9rem;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        table th {
            background-color: var(--light-bg);
            padding: 1rem;
            text-align: left;
            font-weight: 600;
            color: var(--dark-text);
            border-bottom: 2px solid var(--border-color);
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        table td {
            padding: 1rem;
            border-bottom: 1px solid var(--border-color);
            font-size: 0.95rem;
        }

        table tbody tr:hover {
            background-color: rgba(37, 99, 235, 0.03);
        }

        table tbody tr:last-child td {
            border-bottom: none;
        }

        .action-buttons {
            display: flex;
            gap: 0.5rem;
        }

        .action-btn {
            padding: 0.4rem 0.8rem;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.85rem;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
        }

        .action-btn-edit {
            background-color: rgba(37, 99, 235, 0.1);
            color: var(--primary-color);
        }

        .action-btn-edit:hover {
            background-color: var(--primary-color);
            color: var(--white);
        }

        .action-btn-delete {
            background-color: rgba(239, 68, 68, 0.1);
            color: var(--danger-color);
        }

        .action-btn-delete:hover {
            background-color: var(--danger-color);
            color: var(--white);
        }

        .action-btn-view {
            background-color: rgba(139, 92, 246, 0.1);
            color: var(--secondary-color);
        }

        .action-btn-view:hover {
            background-color: var(--secondary-color);
            color: var(--white);
        }

        /* Status Badges */
        .badge {
            display: inline-block;
            padding: 0.35rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .badge-published {
            background-color: rgba(16, 185, 129, 0.15);
            color: var(--success-color);
        }

        .badge-draft {
            background-color: rgba(245, 158, 11, 0.15);
            color: var(--warning-color);
        }

        .badge-archived {
            background-color: rgba(100, 116, 139, 0.15);
            color: #64748b;
        }

        /* Mobile Toggle */
        .mobile-menu-toggle {
            display: none;
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            color: var(--dark-text);
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .dashboard-wrapper {
                grid-template-columns: 1fr;
            }

            .sidebar {
                position: fixed;
                left: -250px;
                transition: left 0.3s ease;
                width: 250px;
                height: 100vh;
            }

            .sidebar.active {
                left: 0;
            }

            .dashboard-main {
                margin-left: 0;
            }

            .dashboard-header {
                padding: 1rem;
            }

            .dashboard-header-left {
                gap: 1rem;
            }

            .dashboard-title {
                font-size: 1.25rem;
            }

            .mobile-menu-toggle {
                display: block;
            }

            .dashboard-header-right {
                gap: 1rem;
            }

            .search-bar {
                display: none !important;
            }

            .user-profile {
                padding: 0.25rem;
            }

            .user-info {
                display: none;
            }

            .dashboard-content {
                padding: 1rem;
            }

            .stats-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
            }

            .section-header {
                flex-direction: column;
                gap: 1rem;
                align-items: flex-start;
            }

            table {
                font-size: 0.85rem;
            }

            table th,
            table td {
                padding: 0.75rem 0.5rem;
            }

            .action-buttons {
                flex-direction: column;
                gap: 0.25rem;
            }

            .action-btn {
                width: 100%;
                justify-content: center;
            }
        }

        @media (max-width: 480px) {
            .dashboard-header {
                padding: 0.75rem;
            }

            .dashboard-title {
                font-size: 1rem;
            }

            .breadcrumb {
                display: none;
            }

            .section-title {
                font-size: 1.1rem;
            }

            table {
                font-size: 0.75rem;
            }

            table th,
            table td {
                padding: 0.5rem 0.25rem;
            }

            .stat-card-value {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="dashboard-wrapper">
        <!-- Sidebar Navigation -->
        <aside class="sidebar" id="sidebar">
            <!-- Brand -->
            <div class="sidebar-brand">
                <div class="sidebar-brand-icon">📋</div>
                <div class="sidebar-brand-text">
                    <h3>CMS</h3>
                    <p>Content Manager</p>
                </div>
            </div>

            <!-- Navigation Menu -->
            <ul class="sidebar-menu">
                <!-- Main Section -->
                <li class="sidebar-menu-section">
                    <span class="sidebar-menu-label">Main</span>
                    <li>
                        <a href="#dashboard" class="nav-link active" data-section="dashboard">
                            <span class="sidebar-menu-icon">📊</span>
                            <span class="sidebar-menu-text">Dashboard</span>
                        </a>
                    </li>
                </li>

                <!-- Content Section -->
                <li class="sidebar-menu-section">
                    <span class="sidebar-menu-label">Content</span>
                    <li>
                        <a href="#posts" class="nav-link" data-section="posts">
                            <span class="sidebar-menu-icon">📝</span>
                            <span class="sidebar-menu-text">Posts</span>
                            <span class="sidebar-menu-badge">5</span>
                        </a>
                    </li>
                    <li>
                        <a href="#pages" class="nav-link" data-section="pages">
                            <span class="sidebar-menu-icon">📄</span>
                            <span class="sidebar-menu-text">Pages</span>
                        </a>
                    </li>
                    <li>
                        <a href="#media" class="nav-link" data-section="media">
                            <span class="sidebar-menu-icon">🖼️</span>
                            <span class="sidebar-menu-text">Media</span>
                        </a>
                    </li>
                    <li>
                        <a href="#categories" class="nav-link" data-section="categories">
                            <span class="sidebar-menu-icon">🏷️</span>
                            <span class="sidebar-menu-text">Categories</span>
                        </a>
                    </li>
                </li>

                <!-- Management Section -->
                <li class="sidebar-menu-section">
                    <span class="sidebar-menu-label">Management</span>
                    <li>
                        <a href="#users" class="nav-link" data-section="users">
                            <span class="sidebar-menu-icon">👥</span>
                            <span class="sidebar-menu-text">Users</span>
                        </a>
                    </li>
                    <li>
                        <a href="#comments" class="nav-link" data-section="comments">
                            <span class="sidebar-menu-icon">💬</span>
                            <span class="sidebar-menu-text">Comments</span>
                            <span class="sidebar-menu-badge">3</span>
                        </a>
                    </li>
                    <li>
                        <a href="#settings" class="nav-link" data-section="settings">
                            <span class="sidebar-menu-icon">⚙️</span>
                            <span class="sidebar-menu-text">Settings</span>
                        </a>
                    </li>
                </li>
            </ul>

            <!-- Sidebar Footer -->
            <div class="sidebar-footer">
                <a href="index.jsp">🚪 Logout</a>
            </div>
        </aside>

        <!-- Main Content -->
        <div class="dashboard-main">
            <!-- Header -->
            <header class="dashboard-header">
                <div class="dashboard-header-left">
                    <button class="mobile-menu-toggle" id="mobileMenuToggle">☰</button>
                    <h1 class="dashboard-title">Dashboard</h1>
                </div>
                <div class="dashboard-header-right">
                    <div class="notification-icon" title="Notifications">
                        🔔
                        <span class="notification-badge">2</span>
                    </div>
                    <div class="user-profile">
                        <div class="user-avatar">A</div>
                        <div class="user-info">
                            <div class="user-name">Admin User</div>
                            <div class="user-role">Administrator</div>
                        </div>
                    </div>
                </div>
            </header>

            <!-- Content Area -->
            <main class="dashboard-content">
                <!-- Breadcrumb -->
                <div class="breadcrumb">
                    <a href="#dashboard">Home</a>
                    <span>/</span>
                    <span>Dashboard</span>
                </div>

                <!-- Statistics Cards -->
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-card-header">
                            <h3 class="stat-card-title">Total Posts</h3>
                            <span class="stat-card-icon">📝</span>
                        </div>
                        <div class="stat-card-value">142</div>
                        <div class="stat-card-change positive">
                            ↑ 12 this month
                        </div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-card-header">
                            <h3 class="stat-card-title">Total Pages</h3>
                            <span class="stat-card-icon">📄</span>
                        </div>
                        <div class="stat-card-value">28</div>
                        <div class="stat-card-change positive">
                            ↑ 3 this month
                        </div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-card-header">
                            <h3 class="stat-card-title">Total Users</h3>
                            <span class="stat-card-icon">👥</span>
                        </div>
                        <div class="stat-card-value">856</div>
                        <div class="stat-card-change positive">
                            ↑ 124 this month
                        </div>
                    </div>

                    <div class="stat-card">
                        <div class="stat-card-header">
                            <h3 class="stat-card-title">Pending Comments</h3>
                            <span class="stat-card-icon">💬</span>
                        </div>
                        <div class="stat-card-value">23</div>
                        <div class="stat-card-change negative">
                            ↓ 5 awaiting review
                        </div>
                    </div>
                </div>

                <!-- Recent Posts Section -->
                <div class="content-section">
                    <div class="section-header">
                        <h2 class="section-title">Recent Posts</h2>
                        <div class="section-controls">
                            <button class="btn btn-sm btn-primary">+ New Post</button>
                        </div>
                    </div>
                    <table>
                        <thead>
                            <tr>
                                <th>Title</th>
                                <th>Author</th>
                                <th>Status</th>
                                <th>Date</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Getting Started with CMS</td>
                                <td>Admin User</td>
                                <td><span class="badge badge-published">Published</span></td>
                                <td>May 15, 2026</td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="action-btn action-btn-view">View</button>
                                        <button class="action-btn action-btn-edit">Edit</button>
                                        <button class="action-btn action-btn-delete">Delete</button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>Content Management Best Practices</td>
                                <td>Admin User</td>
                                <td><span class="badge badge-published">Published</span></td>
                                <td>May 10, 2026</td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="action-btn action-btn-view">View</button>
                                        <button class="action-btn action-btn-edit">Edit</button>
                                        <button class="action-btn action-btn-delete">Delete</button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>Advanced Features Tutorial</td>
                                <td>Admin User</td>
                                <td><span class="badge badge-draft">Draft</span></td>
                                <td>May 12, 2026</td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="action-btn action-btn-view">View</button>
                                        <button class="action-btn action-btn-edit">Edit</button>
                                        <button class="action-btn action-btn-delete">Delete</button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>Security Guidelines</td>
                                <td>Admin User</td>
                                <td><span class="badge badge-published">Published</span></td>
                                <td>May 8, 2026</td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="action-btn action-btn-view">View</button>
                                        <button class="action-btn action-btn-edit">Edit</button>
                                        <button class="action-btn action-btn-delete">Delete</button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td>User Management System</td>
                                <td>Admin User</td>
                                <td><span class="badge badge-archived">Archived</span></td>
                                <td>May 5, 2026</td>
                                <td>
                                    <div class="action-buttons">
                                        <button class="action-btn action-btn-view">View</button>
                                        <button class="action-btn action-btn-edit">Edit</button>
                                        <button class="action-btn action-btn-delete">Delete</button>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </main>
        </div>
    </div>

    <script>
        // Mobile menu toggle
        const mobileMenuToggle = document.getElementById('mobileMenuToggle');
        const sidebar = document.getElementById('sidebar');

        mobileMenuToggle.addEventListener('click', function() {
            sidebar.classList.toggle('active');
        });

        // Close sidebar when a link is clicked on mobile
        document.querySelectorAll('.nav-link').forEach(link => {
            link.addEventListener('click', function() {
                if (window.innerWidth <= 768) {
                    sidebar.classList.remove('active');
                }
                
                // Remove active class from all links
                document.querySelectorAll('.nav-link').forEach(l => l.classList.remove('active'));
                // Add active class to clicked link
                this.classList.add('active');
            });
        });

        // Close sidebar when clicking outside on mobile
        document.addEventListener('click', function(event) {
            if (window.innerWidth <= 768) {
                if (!sidebar.contains(event.target) && !mobileMenuToggle.contains(event.target)) {
                    sidebar.classList.remove('active');
                }
            }
        });

        // Smooth scroll for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function(e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({ behavior: 'smooth' });
                }
            });
        });

        // Action buttons event listeners
        document.querySelectorAll('.action-btn-edit').forEach(btn => {
            btn.addEventListener('click', function() {
                alert('Edit functionality would be implemented here');
            });
        });

        document.querySelectorAll('.action-btn-delete').forEach(btn => {
            btn.addEventListener('click', function() {
                if (confirm('Are you sure you want to delete this item?')) {
                    alert('Delete functionality would be implemented here');
                }
            });
        });

        document.querySelectorAll('.action-btn-view').forEach(btn => {
            btn.addEventListener('click', function() {
                alert('View functionality would be implemented here');
            });
        });

        // New Post button
        document.querySelector('.btn-primary').addEventListener('click', function() {
            alert('New Post form would be displayed here');
        });
    </script>
</body>
</html>
