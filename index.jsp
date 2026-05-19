<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Content Management System - Create, manage and publish your content efficiently">
    <title>CMS - Content Management System</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar">
        <div class="navbar-container container flex-between">
            <div class="navbar-brand">
                <span class="brand-icon">📋</span>
                <span>CMS</span>
            </div>
            
            <ul class="nav-menu">
                <li><a href="#home" class="nav-link">Home</a></li>
                <li><a href="#features" class="nav-link">Features</a></li>
                <li><a href="#about" class="nav-link">About</a></li>
                <li><a href="#contact" class="nav-link">Contact</a></li>
            </ul>
            
            <div class="nav-buttons">
                <a href="login.jsp" class="btn btn-outline">Login</a>
                <a href="#signup" class="btn btn-primary">Get Started</a>
            </div>
            
            <!-- Mobile Menu Toggle -->
            <div class="hamburger" id="hamburger">
                <span></span>
                <span></span>
                <span></span>
            </div>
        </div>
    </nav>

    <!-- Welcome Section (Hero) -->
    <section id="home" class="hero">
        <div class="hero-content">
            <h1 class="fade-in">Welcome to CMS</h1>
            <p class="fade-in">Streamline your content management with our powerful, intuitive platform</p>
            <div class="hero-buttons">
                <a href="login.jsp" class="btn btn-primary btn-lg">Login to Dashboard</a>
                <a href="#features" class="btn btn-outline btn-lg">Explore Features</a>
            </div>
        </div>
        <div class="hero-image">
            <div class="hero-shape"></div>
        </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="features">
        <div class="container">
            <h2 class="text-center mb-4">Why Choose Our CMS?</h2>
            
            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">📝</div>
                    <h3>Easy to Use</h3>
                    <p>Intuitive interface designed for content creators and administrators. No coding knowledge required.</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">🔒</div>
                    <h3>Secure</h3>
                    <p>Enterprise-grade security features to protect your content and user data with encryption.</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">⚡</div>
                    <h3>Fast Performance</h3>
                    <p>Optimized for speed with minimal load times and efficient resource management.</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">📱</div>
                    <h3>Responsive Design</h3>
                    <p>Works seamlessly across all devices - desktop, tablet, and mobile phones.</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">👥</div>
                    <h3>Multi-User Support</h3>
                    <p>Collaborate with team members with different roles and permissions.</p>
                </div>
                
                <div class="feature-card">
                    <div class="feature-icon">📊</div>
                    <h3>Analytics</h3>
                    <p>Track content performance with detailed analytics and insights dashboard.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- About Section -->
    <section id="about" class="about">
        <div class="container">
            <div class="about-content">
                <div class="about-text">
                    <h2>About Our Platform</h2>
                    <p>Our Content Management System is built with modern web technologies to provide you with a reliable, scalable solution for managing all your digital content.</p>
                    <p>Whether you're a small business or a large enterprise, our CMS adapts to your needs with flexible features and robust functionality.</p>
                    <ul class="features-list">
                        <li>✓ Create and publish content in minutes</li>
                        <li>✓ Manage multiple users and roles</li>
                        <li>✓ Schedule content publication</li>
                        <li>✓ Real-time collaboration tools</li>
                        <li>✓ Advanced search and filtering</li>
                        <li>✓ Backup and restore capabilities</li>
                    </ul>
                </div>
                <div class="about-image">
                    <div class="image-placeholder">
                        <span>Dashboard Preview</span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Call to Action Section -->
    <section class="cta-section">
        <div class="container text-center">
            <h2>Ready to Get Started?</h2>
            <p>Join thousands of users managing their content with ease</p>
            <div class="cta-buttons">
                <a href="login.jsp" class="btn btn-primary btn-lg">Login Now</a>
                <a href="#contact" class="btn btn-outline btn-lg">Contact Us</a>
            </div>
        </div>
    </section>

    <!-- Contact Section -->
    <section id="contact" class="contact">
        <div class="container">
            <h2 class="text-center mb-4">Get in Touch</h2>
            <div class="contact-grid">
                <div class="contact-info">
                    <h3>Contact Information</h3>
                    <div class="contact-item">
                        <span class="icon">📍</span>
                        <div>
                            <p class="label">Address</p>
                            <p>123 Tech Street, Digital City, DC 12345</p>
                        </div>
                    </div>
                    <div class="contact-item">
                        <span class="icon">📧</span>
                        <div>
                            <p class="label">Email</p>
                            <p><a href="mailto:support@cms.com">support@cms.com</a></p>
                        </div>
                    </div>
                    <div class="contact-item">
                        <span class="icon">📞</span>
                        <div>
                            <p class="label">Phone</p>
                            <p>+1 (555) 123-4567</p>
                        </div>
                    </div>
                </div>
                
                <form class="contact-form">
                    <div class="form-group">
                        <label for="name">Full Name</label>
                        <input type="text" id="name" name="name" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Email Address</label>
                        <input type="email" id="email" name="email" required>
                    </div>
                    <div class="form-group">
                        <label for="subject">Subject</label>
                        <input type="text" id="subject" name="subject" required>
                    </div>
                    <div class="form-group">
                        <label for="message">Message</label>
                        <textarea id="message" name="message" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary btn-block">Send Message</button>
                </form>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="footer-content">
                <div class="footer-section">
                    <h4>CMS Platform</h4>
                    <ul>
                        <li><a href="#home">Home</a></li>
                        <li><a href="#features">Features</a></li>
                        <li><a href="#about">About</a></li>
                    </ul>
                </div>
                <div class="footer-section">
                    <h4>Resources</h4>
                    <ul>
                        <li><a href="#">Documentation</a></li>
                        <li><a href="#">Blog</a></li>
                        <li><a href="#">Support</a></li>
                    </ul>
                </div>
                <div class="footer-section">
                    <h4>Legal</h4>
                    <ul>
                        <li><a href="#">Privacy Policy</a></li>
                        <li><a href="#">Terms of Service</a></li>
                        <li><a href="#">Cookie Policy</a></li>
                    </ul>
                </div>
                <div class="footer-section">
                    <h4>Follow Us</h4>
                    <ul>
                        <li><a href="#">Twitter</a></li>
                        <li><a href="#">LinkedIn</a></li>
                        <li><a href="#">GitHub</a></li>
                    </ul>
                </div>
            </div>
            <div class="footer-bottom">
                <p>&copy; 2026 Content Management System. All rights reserved.</p>
            </div>
        </div>
    </footer>

    <script>
        // Mobile Menu Toggle
        const hamburger = document.getElementById('hamburger');
        const navMenu = document.querySelector('.nav-menu');
        
        hamburger.addEventListener('click', function() {
            navMenu.classList.toggle('active');
            hamburger.classList.toggle('active');
        });

        // Close menu when a link is clicked
        document.querySelectorAll('.nav-link').forEach(link => {
            link.addEventListener('click', function() {
                navMenu.classList.remove('active');
                hamburger.classList.remove('active');
            });
        });

        // Smooth scroll behavior
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function(e) {
                e.preventDefault();
                const target = document.querySelector(this.getAttribute('href'));
                if (target) {
                    target.scrollIntoView({ behavior: 'smooth' });
                }
            });
        });
    </script>
</body>
</html>
