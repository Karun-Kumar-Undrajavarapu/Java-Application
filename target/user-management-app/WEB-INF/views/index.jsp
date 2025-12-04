<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>User Management System</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; display: flex; justify-content: center; align-items: center; }
        .home-container { background: white; padding: 60px 40px; border-radius: 10px; box-shadow: 0 10px 25px rgba(0,0,0,0.2); text-align: center; max-width: 500px; }
        h1 { color: #333; font-size: 36px; margin-bottom: 20px; }
        p { color: #666; font-size: 18px; margin-bottom: 30px; line-height: 1.6; }
        .features { text-align: left; margin: 30px 0; padding: 20px; background: #f9f9f9; border-radius: 5px; }
        .features li { list-style: none; padding: 8px 0; color: #555; }
        .features li:before { content: "✓ "; color: #27ae60; font-weight: bold; margin-right: 10px; }
        .buttons { display: flex; gap: 15px; margin-top: 40px; }
        a { flex: 1; padding: 15px; text-decoration: none; border-radius: 5px; font-weight: 600; font-size: 16px; transition: background 0.3s; border: none; cursor: pointer; }
        .btn-login { background: #667eea; color: white; }
        .btn-login:hover { background: #5568d3; }
        .btn-register { background: #27ae60; color: white; }
        .btn-register:hover { background: #229954; }
    </style>
</head>
<body>
    <div class="home-container">
        <h1>User Management System</h1>
        <p>Welcome to our secure and efficient user management platform</p>

        <div class="features">
            <ul>
                <li>Admin and User role-based access</li>
                <li>Secure password authentication</li>
                <li>Persistent data storage</li>
                <li>User profile management</li>
                <li>Admin user management dashboard</li>
            </ul>
        </div>

        <div class="buttons">
            <a href="/login" class="btn-login">Login</a>
            <a href="/register" class="btn-register">Register</a>
        </div>
    </div>
</body>
</html>
