<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Admin Dashboard - HR Management</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f5f5; min-height: 100vh; }
        .navbar { background: #2c3e50; color: white; padding: 20px 40px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .navbar h2 { font-size: 24px; font-weight: 600; }
        .nav-info { display: flex; align-items: center; gap: 20px; }
        .user-badge { font-size: 14px; font-weight: 500; }
        .navbar a { color: white; text-decoration: none; font-weight: 500; background: #e67e22; padding: 8px 16px; border-radius: 4px; transition: background 0.3s; }
        .navbar a:hover { background: #d35400; }
        .container { padding: 40px; max-width: 1400px; margin: 0 auto; }
        h1 { color: #2c3e50; margin-bottom: 30px; font-size: 28px; font-weight: 600; }
        .message { color: #27ae60; background: #d5f4e6; padding: 12px 15px; border-radius: 4px; margin-bottom: 20px; border-left: 4px solid #27ae60; font-weight: 500; font-size: 14px; }
        .error { color: #c62828; background: #fadbd8; padding: 12px 15px; border-radius: 4px; margin-bottom: 20px; border-left: 4px solid #c62828; font-weight: 500; font-size: 14px; }
        .table-wrapper { background: white; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); overflow: hidden; }
        table { width: 100%; border-collapse: collapse; }
        th { background: #34495e; color: white; padding: 12px 15px; font-weight: 600; text-align: left; font-size: 13px; }
        td { padding: 12px 15px; border-bottom: 1px solid #ecf0f1; color: #555; font-size: 13px; }
        tr:hover { background: #f9f9f9; }
        tr:last-child td { border-bottom: none; }
        .badge { display: inline-block; padding: 4px 10px; border-radius: 12px; font-size: 11px; font-weight: 600; }
        .badge-admin { background: #ffeae0; color: #c62828; }
        .badge-user { background: #e3f2fd; color: #1565c0; }
        .badge-active { background: #d4edda; color: #155724; }
        .actions { display: flex; gap: 6px; flex-wrap: wrap; }
        .btn { padding: 6px 12px; border: none; border-radius: 4px; cursor: pointer; font-weight: 500; font-size: 12px; text-decoration: none; transition: background 0.3s; display: inline-block; text-align: center; }
        .btn-edit { background: #3498db; color: white; }
        .btn-edit:hover { background: #2980b9; }
        .btn-delete { background: #e74c3c; color: white; }
        .btn-delete:hover { background: #c0392b; }
        .btn-admin { background: #27ae60; color: white; }
        .btn-admin:hover { background: #229954; }
        .badge-inactive { background: #f5f5f5; color: #666; }
    </style>
</head>
<body>
    <div class="navbar">
        <h2>Admin Dashboard</h2>
        <div class="nav-info">
            <div class="user-badge">${currentUser.name} (${currentUser.role})</div>
            <a href="/logout">Logout</a>
        </div>
    </div>

    <div class="container">
        <h1>Manage Employees</h1>

        <c:if test="${not empty message}">
            <div class="message">${message}</div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>

        <div class="table-wrapper">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Designation</th>
                        <th>Department</th>
                        <th>Location</th>
                        <th>Joining Date</th>
                        <th>Manager</th>
                        <th>Role</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${users}">
                        <tr>
                            <td>#${user.id}</td>
                            <td style="font-weight: 600; color: #202d42;">${user.name}</td>
                            <td>${user.email}</td>
                            <td>${user.designation != null ? user.designation : '—'}</td>
                            <td>${user.department != null ? user.department : '—'}</td>
                            <td>${user.workLocation != null ? user.workLocation : '—'}</td>
                            <td>${user.joiningDate != null ? user.joiningDate : '—'}</td>
                            <td>${user.managerName != null ? user.managerName : '—'}</td>
                            <td>
                                <span class="badge ${user.role == 'ADMIN' ? 'badge-admin' : 'badge-user'}">
                                    ${user.role}
                                </span>
                            </td>
                            <td>
                                <span class="badge ${user.status == 'ACTIVE' ? 'badge-active' : 'badge-inactive'}">
                                    ${user.status}
                                </span>
                            </td>
                            <td class="actions">
                                <a href="/admin/edit-user/${user.id}" class="btn btn-edit"> Edit</a>
                                <c:if test="${user.role == 'USER'}">
                                    <a href="/admin/make-admin/${user.id}" class="btn btn-admin" onclick="return confirm('Make ${user.name} an admin?')">Admin</a>
                                </c:if>
                                <a href="/admin/delete-user/${user.id}" class="btn btn-delete" onclick="return confirm('Delete ${user.name}? This cannot be undone!')">Delete</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
