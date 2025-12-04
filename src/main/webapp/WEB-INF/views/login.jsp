<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Login - User Management</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; display: flex; justify-content: center; align-items: center; }
        .login-container { background: white; padding: 40px; border-radius: 10px; box-shadow: 0 10px 25px rgba(0,0,0,0.2); width: 100%; max-width: 400px; }
        h1 { color: #333; margin-bottom: 30px; text-align: center; font-size: 28px; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; color: #555; font-weight: 500; }
        input { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 5px; font-size: 14px; }
        input:focus { outline: none; border-color: #667eea; box-shadow: 0 0 5px rgba(102,126,234,0.3); }
        button { width: 100%; padding: 12px; background: #667eea; color: white; border: none; border-radius: 5px; font-size: 16px; cursor: pointer; font-weight: 600; transition: background 0.3s; }
        button:hover { background: #764ba2; }
        .error { color: #e74c3c; background: #fadbd8; padding: 12px; border-radius: 5px; margin-bottom: 20px; }
        .success { color: #27ae60; background: #d5f4e6; padding: 12px; border-radius: 5px; margin-bottom: 20px; }
        .register-link { text-align: center; margin-top: 20px; }
        .register-link a { color: #667eea; text-decoration: none; font-weight: 500; }
        .register-link a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="login-container">
        <h1>Login</h1>

        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>

        <c:if test="${not empty message}">
            <div class="success">${message}</div>
        </c:if>

        <form action="/perform-login" method="post">
            <div class="form-group">
                <label>Email:</label>
                <input type="email" name="email" required placeholder="Enter your email" />
            </div>

            <div class="form-group">
                <label>Password:</label>
                <input type="password" name="password" required placeholder="Enter your password" />
            </div>

            <button type="submit">Login</button>
        </form>

        <div class="register-link">
            Don't have an account? <a href="/register">Register here</a>
        </div>
    </div>
</body>
</html>
