<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>3-Tier User Management</title>
    <style>
        body { font-family: Arial; margin: 40px; background: #f9f9f9; }
        h1 { color: #333; }
        table { width: 100%; border-collapse: collapse; margin: 20px 0; }
        th, td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        th { background-color: #4CAF50; color: white; }
        tr:nth-child(even) { background-color: #f2f2f2; }
        input, button { padding: 10px; margin: 5px; }
        button { background: #4CAF50; color: white; border: none; cursor: pointer; }
        a { color: red; text-decoration: none; }
        a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <h1>User Management - 3 Tier App</h1>

    <form action="/add" method="post">
        <input type="text" name="name" placeholder="Enter name" required />
        <input type="email" name="email" placeholder="Enter email" required />
        <button type="submit">Add User</button>
    </form>

    <h2>All Users (${users.size()})</h2>
    <c:choose>
        <c:when test="${empty users}">
            <p>No users added yet.</p>
        </c:when>
        <c:otherwise>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Action</th>
                </tr>
                <c:forEach var="user" items="${users}">
                    <tr>
                        <td>${user.id}</td>
                        <td>${user.name}</td>
                        <td>${user.email}</td>
                        <td><a href="/delete/${user.id}" onclick="return confirm('Delete this user?')">Delete</a></td>
                    </tr>
                </c:forEach>
            </table>
        </c:otherwise>
    </c:choose>
</body>
</html>
