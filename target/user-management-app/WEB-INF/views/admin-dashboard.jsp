<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Admin Dashboard - User Management</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f5f5; }
        .navbar { background: #2c3e50; color: white; padding: 20px 40px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .navbar h2 { font-size: 24px; }
        .navbar a { color: white; text-decoration: none; margin-left: 30px; font-weight: 500; transition: color 0.3s; }
        .navbar a:hover { color: #3498db; }
        .container { padding: 40px; max-width: 1200px; margin: 0 auto; }
        h1 { color: #2c3e50; margin-bottom: 30px; }
        .message { color: #27ae60; background: #d5f4e6; padding: 15px; border-radius: 5px; margin-bottom: 20px; }
        .error { color: #e74c3c; background: #fadbd8; padding: 15px; border-radius: 5px; margin-bottom: 20px; }
        table { width: 100%; border-collapse: collapse; background: white; box-shadow: 0 2px 5px rgba(0,0,0,0.1); border-radius: 5px; overflow: hidden; }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #ecf0f1; }
        th { background: #3498db; color: white; font-weight: 600; }
        tr:hover { background: #f9f9f9; }
        .actions { display: flex; gap: 10px; }
        .btn { padding: 8px 15px; border: none; border-radius: 5px; cursor: pointer; font-weight: 500; text-decoration: none; transition: background 0.3s; display: inline-block; }
        .btn-edit { background: #3498db; color: white; }
        .btn-edit:hover { background: #2980b9; }
        .btn-delete { background: #e74c3c; color: white; }
        .btn-delete:hover { background: #c0392b; }
        .btn-admin { background: #27ae60; color: white; }
        .btn-admin:hover { background: #229954; }
        .btn-logout { background: #e67e22; color: white; margin-left: auto; }
        .btn-logout:hover { background: #d35400; }
    </style>
</head>
<body>
    <div class="navbar">
        <h2>Admin Dashboard</h2>
        <div>
            <span>Welcome, ${currentUser.name} (${currentUser.role})</span>
            <a href="/logout" class="btn-logout">Logout</a>
        </div>
    </div>

    <div class="container">
        <h1>Manage Users</h1>

        <c:if test="${not empty message}">
            <div class="message">${message}</div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>

        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Created At</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td>${user.id}</td>
                        <td>${user.name}</td>
                        <td>${user.email}</td>
                        <td>${user.role}</td>
                        <td>${user.createdAt}</td>
                        <td class="actions">
                            <c:if test="${user.role == 'USER'}">
                                <a href="/admin/make-admin/${user.id}" class="btn btn-admin">Make Admin</a>
                            </c:if>
                            <a href="/admin/delete-user/${user.id}" class="btn btn-delete" onclick="return confirm('Delete this user?')">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
