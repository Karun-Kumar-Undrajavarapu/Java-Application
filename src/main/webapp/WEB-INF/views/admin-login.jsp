<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Admin Login - HR Management System</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f5f5; display: flex; align-items: center; justify-content: center; height: 100vh; }
        .card { background: white; padding: 40px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); width: 100%; max-width: 400px; }
        .header { text-align: center; margin-bottom: 35px; }
        h2 { text-align: center; margin-bottom: 8px; font-size: 28px; font-weight: 600; color: #2c3e50; }
        .subtitle { color: #888; text-align: center; font-size: 13px; }
        .form-group { margin-bottom: 18px; }
        label { display: block; margin-bottom: 6px; color: #555; font-weight: 500; font-size: 13px; }
        input { width: 100%; padding: 10px 12px; margin: 0; border: 1px solid #ddd; border-radius: 4px; font-size: 14px; transition: border-color 0.3s; }
        input:focus { outline: none; border-color: #0f9d58; box-shadow: 0 0 5px rgba(15,157,88,0.2); }
        button { width: 100%; padding: 10px; background: #0f9d58; color: white; border: none; border-radius: 4px; font-weight: 600; cursor: pointer; transition: background 0.3s; margin-top: 8px; }
        button:hover { background: #0d7d47; }
        .error { color: #c62828; background: #fadbd8; padding: 10px 12px; border-radius: 4px; margin-bottom: 15px; border-left: 4px solid #c62828; font-weight: 500; font-size: 13px; }
    </style>
</head>
<body>
    <div class="card">
        <div class="header">
            <h2>Admin Login</h2>
            <p class="subtitle">Administrative Access Only</p>
        </div>
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>
        <form action="/admin/perform-login" method="post">
            <div class="form-group">
                <label>Email Address</label>
                <input type="email" name="email" placeholder="admin@example.com" required />
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" placeholder="••••••••" required />
            </div>
            <button type="submit">Sign In</button>
        </form>
    </div>
</body>
</html>
