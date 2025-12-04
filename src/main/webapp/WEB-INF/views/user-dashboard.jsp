<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>User Dashboard - User Management</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f5f5; }
        .navbar { background: #2c3e50; color: white; padding: 20px 40px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .navbar h2 { font-size: 24px; }
        .navbar a { color: white; text-decoration: none; margin-left: 30px; font-weight: 500; transition: color 0.3s; }
        .navbar a:hover { color: #3498db; }
        .container { padding: 40px; max-width: 800px; margin: 0 auto; }
        h1 { color: #2c3e50; margin-bottom: 30px; }
        .profile-card { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; color: #555; font-weight: 500; }
        input { width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 5px; font-size: 14px; }
        input:focus { outline: none; border-color: #3498db; box-shadow: 0 0 5px rgba(52,152,219,0.3); }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        button { padding: 12px 30px; background: #3498db; color: white; border: none; border-radius: 5px; font-size: 16px; cursor: pointer; font-weight: 600; transition: background 0.3s; }
        button:hover { background: #2980b9; }
        .message { color: #27ae60; background: #d5f4e6; padding: 15px; border-radius: 5px; margin-bottom: 20px; }
        .error { color: #e74c3c; background: #fadbd8; padding: 15px; border-radius: 5px; margin-bottom: 20px; }
        .info-row { display: flex; justify-content: space-between; padding: 10px 0; border-bottom: 1px solid #ecf0f1; }
        .info-row span:first-child { font-weight: 600; color: #555; }
        .info-row span:last-child { color: #333; }
        .btn-logout { background: #e67e22; color: white; margin-left: auto; padding: 8px 20px; }
        .btn-logout:hover { background: #d35400; }
    </style>
</head>
<body>
    <div class="navbar">
        <h2>User Dashboard</h2>
        <div>
            <span>Welcome, ${currentUser.name}</span>
            <a href="/logout" class="btn-logout">Logout</a>
        </div>
    </div>

    <div class="container">
        <h1>My Profile</h1>

        <c:if test="${not empty message}">
            <div class="message">${message}</div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>

        <div class="profile-card">
            <h2 style="margin-bottom: 20px; color: #2c3e50;">Profile Information</h2>

            <form action="/user/update-profile" method="post">
                <div class="form-row">
                    <div class="form-group">
                        <label>Full Name:</label>
                        <input type="text" name="name" value="${currentUser.name}" required />
                    </div>

                    <div class="form-group">
                        <label>Email:</label>
                        <input type="email" name="email" value="${currentUser.email}" required />
                    </div>
                </div>

                <button type="submit">Update Profile</button>
            </form>

            <h3 style="margin-top: 40px; margin-bottom: 20px; color: #2c3e50;">Account Details</h3>
            <div class="info-row">
                <span>Account Created:</span>
                <span>${currentUser.createdAt}</span>
            </div>
            <div class="info-row">
                <span>Role:</span>
                <span>${currentUser.role}</span>
            </div>
            <div class="info-row">
                <span>Status:</span>
                <span style="color: #27ae60; font-weight: 600;">Active</span>
            </div>
        </div>
    </div>
</body>
</html>
