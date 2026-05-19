<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="CMS Admin Login - Secure access to your Content Management System">
    <title>Admin Login - Content Management System</title>
    <link rel="stylesheet" href="style.css">
    <style>
        /* Login-specific styles */
        .login-page {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .login-header {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            text-align: center;
            padding: 2rem 1rem;
        }

        .login-header h1 {
            color: white;
            margin: 0;
            font-size: 2rem;
        }

        .login-header p {
            color: rgba(255, 255, 255, 0.9);
            margin: 0.5rem 0 0 0;
        }

        .login-wrapper {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem 1rem;
            background: linear-gradient(135deg, rgba(37, 99, 235, 0.05) 0%, rgba(139, 92, 246, 0.05) 100%);
        }

        .login-card {
            background-color: var(--white);
            border-radius: 12px;
            box-shadow: var(--shadow-lg);
            padding: 2.5rem;
            width: 100%;
            max-width: 420px;
        }

        .login-card-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .login-card-header .icon {
            font-size: 3rem;
            display: block;
            margin-bottom: 1rem;
        }

        .login-card-header h2 {
            color: var(--primary-color);
            font-size: 1.75rem;
            margin: 0;
        }

        .login-card-header p {
            color: var(--gray-text);
            margin: 0.5rem 0 0 0;
        }

        .form-group-wrapper {
            margin-bottom: 1.25rem;
        }

        .form-group-wrapper label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: var(--dark-text);
            font-size: 0.95rem;
        }

        .form-group-wrapper input {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-size: 1rem;
            font-family: inherit;
            transition: all 0.3s ease;
            background-color: var(--white);
        }

        .form-group-wrapper input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.1);
        }

        .input-icon {
            position: relative;
        }

        .input-icon::before {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            font-size: 1.1rem;
            pointer-events: none;
        }

        .input-with-icon {
            padding-left: 2.5rem;
        }

        .checkbox-group {
            display: flex;
            align-items: center;
            margin-bottom: 1.5rem;
            gap: 0.5rem;
        }

        .checkbox-group input[type="checkbox"] {
            width: auto;
            margin: 0;
            cursor: pointer;
        }

        .checkbox-group label {
            margin: 0;
            font-weight: 500;
            font-size: 0.9rem;
            cursor: pointer;
            color: var(--gray-text);
        }

        .form-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
        }

        .form-footer a {
            color: var(--primary-color);
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .form-footer a:hover {
            color: var(--primary-dark);
            text-decoration: none;
        }

        .login-btn {
            width: 100%;
            padding: 0.85rem;
            background-color: var(--primary-color);
            color: var(--white);
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .login-btn:hover {
            background-color: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .login-btn:active {
            transform: translateY(0);
        }

        .login-btn.loading {
            opacity: 0.7;
            cursor: not-allowed;
        }

        .error-message {
            background-color: rgba(239, 68, 68, 0.1);
            color: var(--danger-color);
            padding: 0.75rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            border-left: 4px solid var(--danger-color);
            display: none;
        }

        .error-message.show {
            display: block;
        }

        .success-message {
            background-color: rgba(16, 185, 129, 0.1);
            color: var(--success-color);
            padding: 0.75rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            border-left: 4px solid var(--success-color);
            display: none;
        }

        .success-message.show {
            display: block;
        }

        .login-footer {
            text-align: center;
            margin-top: 1.5rem;
            color: var(--gray-text);
            font-size: 0.9rem;
        }

        .login-footer a {
            color: var(--primary-color);
            font-weight: 600;
        }

        .back-to-home {
            text-align: center;
            margin-top: 1.5rem;
        }

        .back-to-home a {
            color: var(--primary-color);
            font-weight: 600;
            font-size: 0.9rem;
        }

        .login-features {
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 1px solid var(--border-color);
        }

        .features-list-compact {
            list-style: none;
            font-size: 0.85rem;
            color: var(--gray-text);
        }

        .features-list-compact li {
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .features-list-compact li::before {
            content: "✓";
            color: var(--success-color);
            font-weight: bold;
        }

        @media (max-width: 768px) {
            .login-header {
                padding: 1.5rem 1rem;
            }

            .login-header h1 {
                font-size: 1.5rem;
            }

            .login-wrapper {
                padding: 1rem;
            }

            .login-card {
                padding: 1.75rem;
            }

            .login-card-header .icon {
                font-size: 2.5rem;
            }

            .login-card-header h2 {
                font-size: 1.5rem;
            }
        }

        @media (max-width: 480px) {
            .login-card {
                padding: 1.5rem;
                border-radius: 10px;
            }

            .login-card-header .icon {
                font-size: 2rem;
                margin-bottom: 0.75rem;
            }

            .login-card-header h2 {
                font-size: 1.35rem;
            }

            .login-card-header p {
                font-size: 0.85rem;
            }

            .form-group-wrapper label {
                font-size: 0.9rem;
            }

            .checkbox-group {
                font-size: 0.85rem;
            }

            .login-features {
                display: none;
            }
        }
    </style>
</head>
<body class="login-page">
    <!-- Header -->
    <div class="login-header">
        <h1>Content Management System</h1>
        <p>Admin Login Portal</p>
    </div>

    <!-- Login Wrapper -->
    <div class="login-wrapper">
        <!-- Login Card -->
        <div class="login-card">
            <!-- Card Header -->
            <div class="login-card-header">
                <span class="icon">🔐</span>
                <h2>Admin Login</h2>
                <p>Enter your credentials to access the dashboard</p>
            </div>

            <!-- Alert Messages -->
            <div class="error-message" id="errorMessage"></div>
            <div class="success-message" id="successMessage"></div>

            <!-- Login Form -->
            <form id="loginForm" method="POST" action="db.jsp">
                <!-- Username Field -->
                <div class="form-group-wrapper">
                    <label for="username">Username</label>
                    <div class="input-icon">
                        <input 
                            type="text" 
                            id="username" 
                            name="username" 
                            class="input-with-icon"
                            placeholder="Enter your username" 
                            required 
                            autocomplete="username"
                        >
                    </div>
                    <span style="font-size: 0.85rem; color: var(--primary-color); position: absolute; left: 0; top: 35px;">👤</span>
                </div>

                <!-- Password Field -->
                <div class="form-group-wrapper">
                    <label for="password">Password</label>
                    <div class="input-icon">
                        <input 
                            type="password" 
                            id="password" 
                            name="password" 
                            class="input-with-icon"
                            placeholder="Enter your password" 
                            required 
                            autocomplete="current-password"
                        >
                    </div>
                    <span style="font-size: 0.85rem; color: var(--primary-color); position: absolute; left: 0; top: 35px;">🔑</span>
                </div>

                <!-- Remember Me & Forgot Password -->
                <div class="form-footer">
                    <div class="checkbox-group">
                        <input 
                            type="checkbox" 
                            id="rememberMe" 
                            name="rememberMe"
                        >
                        <label for="rememberMe">Remember me</label>
                    </div>
                    <a href="#forgotPassword">Forgot password?</a>
                </div>

                <!-- Login Button -->
                <button type="submit" class="login-btn" id="loginBtn">
                    <span>Login</span>
                </button>
            </form>

            <!-- Features -->
            <div class="login-features">
                <h4 style="margin: 0 0 0.75rem 0; font-size: 0.95rem; color: var(--dark-text);">Why CMS?</h4>
                <ul class="features-list-compact">
                    <li>Secure & encrypted login</li>
                    <li>Real-time content management</li>
                    <li>Multi-user collaboration</li>
                    <li>24/7 system availability</li>
                </ul>
            </div>

            <!-- Back to Home -->
            <div class="back-to-home">
                <a href="index.jsp">← Back to Home</a>
            </div>
        </div>
    </div>

    <script>
        // Form submission handling
        const loginForm = document.getElementById('loginForm');
        const loginBtn = document.getElementById('loginBtn');
        const errorMessage = document.getElementById('errorMessage');
        const successMessage = document.getElementById('successMessage');

        loginForm.addEventListener('submit', function(e) {
            e.preventDefault();

            // Get form values
            const username = document.getElementById('username').value.trim();
            const password = document.getElementById('password').value;
            const rememberMe = document.getElementById('rememberMe').checked;

            // Clear previous messages
            errorMessage.classList.remove('show');
            successMessage.classList.remove('show');

            // Basic validation
            if (!username || !password) {
                showError('Please fill in all required fields');
                return;
            }

            if (username.length < 3) {
                showError('Username must be at least 3 characters long');
                return;
            }

            if (password.length < 6) {
                showError('Password must be at least 6 characters long');
                return;
            }

            // Show loading state
            loginBtn.classList.add('loading');
            loginBtn.innerHTML = '<span>Logging in...</span>';
            loginBtn.disabled = true;

            // Simulate authentication delay (in real app, this would be server-side)
            setTimeout(function() {
                // For demo purposes - in production this would be handled by server
                // Replace with actual backend authentication
                if (username === 'admin' && password === 'password') {
                    showSuccess('Login successful! Redirecting...');
                    
                    // Store remember me preference
                    if (rememberMe) {
                        localStorage.setItem('rememberUsername', username);
                    } else {
                        localStorage.removeItem('rememberUsername');
                    }

                    // Redirect to dashboard after 1.5 seconds
                    setTimeout(function() {
                        window.location.href = 'dashboard.jsp';
                    }, 1500);
                } else {
                    showError('Invalid username or password. Please try again.');
                    loginBtn.classList.remove('loading');
                    loginBtn.innerHTML = '<span>Login</span>';
                    loginBtn.disabled = false;
                }
            }, 800);
        });

        function showError(message) {
            errorMessage.textContent = message;
            errorMessage.classList.add('show');
            errorMessage.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
        }

        function showSuccess(message) {
            successMessage.textContent = message;
            successMessage.classList.add('show');
            successMessage.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
        }

        // Load remembered username if available
        window.addEventListener('load', function() {
            const rememberedUsername = localStorage.getItem('rememberUsername');
            if (rememberedUsername) {
                document.getElementById('username').value = rememberedUsername;
                document.getElementById('rememberMe').checked = true;
            }
        });

        // Handle Enter key in password field
        document.getElementById('password').addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                loginForm.dispatchEvent(new Event('submit'));
            }
        });

        // Real-time validation
        document.getElementById('username').addEventListener('input', function() {
            errorMessage.classList.remove('show');
        });

        document.getElementById('password').addEventListener('input', function() {
            errorMessage.classList.remove('show');
        });
    </script>
</body>
</html>
