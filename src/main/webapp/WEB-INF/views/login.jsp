<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Login - HR Management System</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f5f5; min-height: 100vh; display: flex; justify-content: center; align-items: center; }
        .login-container { background: white; padding: 40px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); width: 100%; max-width: 400px; }
        .header { text-align: center; margin-bottom: 35px; }
        h1 { color: #2c3e50; margin-bottom: 8px; font-size: 28px; font-weight: 600; }
        .subtitle { color: #888; text-align: center; font-size: 13px; }
        .form-group { margin-bottom: 18px; }
        label { display: block; margin-bottom: 6px; color: #555; font-weight: 500; font-size: 13px; }
        input { width: 100%; padding: 10px 12px; border: 1px solid #ddd; border-radius: 4px; font-size: 14px; transition: border-color 0.3s; }
        input:focus { outline: none; border-color: #3498db; box-shadow: 0 0 5px rgba(52,152,219,0.2); }
        button { width: 100%; padding: 10px; background: #3498db; color: white; border: none; border-radius: 4px; font-size: 14px; cursor: pointer; font-weight: 600; transition: background 0.3s; }
        button:hover { background: #2980b9; }
        .error { color: #c62828; background: #fadbd8; padding: 10px 12px; border-radius: 4px; margin-bottom: 15px; border-left: 4px solid #c62828; font-weight: 500; font-size: 13px; }
        .success { color: #27ae60; background: #d5f4e6; padding: 10px 12px; border-radius: 4px; margin-bottom: 15px; border-left: 4px solid #27ae60; font-weight: 500; font-size: 13px; }
        .register-link { text-align: center; margin-top: 20px; padding-top: 20px; border-top: 1px solid #ecf0f1; font-size: 13px; }
        .register-link a { color: #3498db; text-decoration: none; font-weight: 600; transition: color 0.3s; }
        .register-link a:hover { color: #2980b9; }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="header">
            <h1>User Login</h1>
            <p class="subtitle">Sign in to your account</p>
        </div>

        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>

        <c:if test="${not empty message}">
            <div class="success">${message}</div>
        </c:if>

        <form action="/perform-login" method="post">
            <div class="form-group">
                <label>Email Address</label>
                <input type="email" name="email" required placeholder="user@example.com" />
            </div>

            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" required placeholder="••••••••" />
            </div>

            <button type="submit">Sign In</button>
        </form>

        <div class="register-link">
            New here? <a href="/register">Create an account</a>
        </div>
    </div>
</body>
</html>
