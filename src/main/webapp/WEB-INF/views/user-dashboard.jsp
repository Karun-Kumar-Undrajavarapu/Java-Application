<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>User Dashboard - HR Management</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f5f5; min-height: 100vh; }
        .navbar { background: #2c3e50; color: white; padding: 20px 40px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .navbar h2 { font-size: 24px; font-weight: 600; }
        .nav-info { display: flex; align-items: center; gap: 20px; }
        .user-badge { font-size: 14px; font-weight: 500; }
        .navbar a { color: white; text-decoration: none; font-weight: 500; background: #e67e22; padding: 8px 16px; border-radius: 4px; transition: background 0.3s; }
        .navbar a:hover { background: #d35400; }
        .container { padding: 40px; max-width: 1200px; margin: 0 auto; }
        h1 { color: #2c3e50; margin-bottom: 30px; font-size: 28px; font-weight: 600; }
        .cards-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 25px; margin-bottom: 40px; }
        @media (max-width: 768px) { .cards-grid { grid-template-columns: 1fr; } }
        .card { background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); }
        .card h3 { color: #2c3e50; font-size: 18px; font-weight: 600; margin-bottom: 20px; border-bottom: 2px solid #3498db; padding-bottom: 12px; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 6px; color: #555; font-weight: 500; font-size: 13px; }
        input, select { width: 100%; padding: 10px 12px; border: 1px solid #ddd; border-radius: 4px; font-size: 14px; transition: border-color 0.3s; }
        input:focus, select:focus { outline: none; border-color: #3498db; box-shadow: 0 0 5px rgba(52,152,219,0.2); }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; }
        .form-row.full { grid-template-columns: 1fr; }
        button { padding: 10px 24px; background: #3498db; color: white; border: none; border-radius: 4px; font-size: 14px; font-weight: 600; cursor: pointer; transition: background 0.3s; }
        button:hover { background: #2980b9; }
        .btn-secondary { background: #95a5a6; color: white; margin-left: 8px; }
        .btn-secondary:hover { background: #7f8c8d; }
        .message { color: #27ae60; background: #d5f4e6; padding: 12px 15px; border-radius: 4px; margin-bottom: 20px; border-left: 4px solid #27ae60; font-weight: 500; font-size: 14px; }
        .error { color: #c62828; background: #fadbd8; padding: 12px 15px; border-radius: 4px; margin-bottom: 20px; border-left: 4px solid #c62828; font-weight: 500; font-size: 14px; }
        .info-section { margin-top: 20px; padding-top: 20px; border-top: 1px solid #ecf0f1; }
        .info-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 15px; }
        .info-item { padding: 12px; background: #f9f9f9; border-radius: 4px; }
        .info-label { font-weight: 600; color: #3498db; font-size: 11px; text-transform: uppercase; margin-bottom: 4px; }
        .info-value { color: #333; font-size: 14px; }
        .employees-section { margin-top: 40px; }
        .employees-section h2 { color: #2c3e50; font-size: 20px; font-weight: 600; margin-bottom: 20px; }
        .table-wrapper { background: white; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); overflow: hidden; }
        table { width: 100%; border-collapse: collapse; }
        th { background: #34495e; color: white; padding: 12px 15px; font-weight: 600; text-align: left; font-size: 13px; }
        td { padding: 12px 15px; border-bottom: 1px solid #ecf0f1; color: #555; font-size: 13px; }
        tr:hover { background: #f9f9f9; }
        tr:last-child td { border-bottom: none; }
        .badge { display: inline-block; padding: 4px 10px; border-radius: 12px; font-size: 11px; font-weight: 600; }
        .badge-active { background: #d4edda; color: #155724; }
        .toggle-btn { background: #3498db; color: white; border: none; padding: 8px 16px; border-radius: 4px; cursor: pointer; font-weight: 600; font-size: 13px; transition: background 0.3s; }
        .toggle-btn:hover { background: #2980b9; }
        .edit-section { display: none; margin-top: 20px; padding: 20px; background: #f9f9f9; border-radius: 4px; border: 1px solid #ecf0f1; }
        .edit-section.show { display: block; }
    </style>
</head>
<body>
    <div class="navbar">
        <h2>HR Dashboard</h2>
        <div class="nav-info">
            <div class="user-badge">Welcome, ${currentUser.name}</div>
            <a href="/logout">Logout</a>
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

        <div class="cards-grid">
            <div class="card">
                <h3>Basic Information</h3>
                <div class="form-row">
                    <div class="form-group">
                        <label>Full Name</label>
                        <input type="text" value="${currentUser.name}" readonly style="background: #f5f5f5; color: #555;" />
                    </div>
                    <div class="form-group">
                        <label>Email</label>
                        <input type="text" value="${currentUser.email}" readonly style="background: #f5f5f5; color: #555;" />
                    </div>
                </div>
                <div class="info-section">
                    <div class="info-grid">
                        <div class="info-item">
                            <div class="info-label">Account Created</div>
                            <div class="info-value">${currentUser.createdAt}</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Role</div>
                            <div class="info-value" style="color: #3498db; font-weight: 600;">${currentUser.role}</div>
                        </div>
                        <div class="info-item">
                            <div class="info-label">Status</div>
                            <span class="badge badge-active">${currentUser.status}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card">
                <h3>HR Information</h3>
                <div class="info-grid">
                    <div class="info-item">
                        <div class="info-label">Designation</div>
                        <div class="info-value">${currentUser.designation != null ? currentUser.designation : 'Not set'}</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Department</div>
                        <div class="info-value">${currentUser.department != null ? currentUser.department : 'Not set'}</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Work Location</div>
                        <div class="info-value">${currentUser.workLocation != null ? currentUser.workLocation : 'Not set'}</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Domain</div>
                        <div class="info-value">${currentUser.domain != null ? currentUser.domain : 'Not set'}</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Joining Date</div>
                        <div class="info-value">${currentUser.joiningDate != null ? currentUser.joiningDate : 'Not set'}</div>
                    </div>
                    <div class="info-item">
                        <div class="info-label">Manager</div>
                        <div class="info-value">${currentUser.managerName != null ? currentUser.managerName : 'Not set'}</div>
                    </div>
                </div>
                <button class="toggle-btn" onclick="document.getElementById('editHRForm').classList.toggle('show');" style="width: 100%; margin-top: 15px;">Edit HR Details</button>
            </div>
        </div>

        <div id="editHRForm" class="edit-section">
            <h3 style="color: #2c3e50; margin-bottom: 20px;">Edit HR Information</h3>
            <form action="/user/update-profile" method="post">
                <div class="form-row">
                    <div class="form-group">
                        <label>Designation</label>
                        <input type="text" name="designation" value="${currentUser.designation}" placeholder="e.g., Senior Developer" />
                    </div>
                    <div class="form-group">
                        <label>Department</label>
                        <input type="text" name="department" value="${currentUser.department}" placeholder="e.g., Engineering" />
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Work Location</label>
                        <input type="text" name="workLocation" value="${currentUser.workLocation}" placeholder="e.g., New York" />
                    </div>
                    <div class="form-group">
                        <label>Domain</label>
                        <input type="text" name="domain" value="${currentUser.domain}" placeholder="e.g., IT" />
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label>Joining Date</label>
                        <input type="date" name="joiningDate" value="${currentUser.joiningDate}" />
                    </div>
                    <div class="form-group">
                        <label>Manager Name</label>
                        <input type="text" name="managerName" value="${currentUser.managerName}" placeholder="e.g., John Smith" />
                    </div>
                </div>

                <div style="margin-top: 20px;">
                    <button type="submit">Save Changes</button>
                    <button type="button" class="btn-secondary" onclick="document.getElementById('editHRForm').classList.remove('show');">Cancel</button>
                </div>
            </form>
        </div>

        <div class="employees-section">
            <h2>Company Directory</h2>
            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Designation</th>
                            <th>Department</th>
                            <th>Joining Date</th>
                            <th>Location</th>
                            <th>Manager</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="u" items="${employees}">
                            <tr>
                                <td>#${u.id}</td>
                                <td style="font-weight: 600; color: #2c3e50;">${u.name}</td>
                                <td>${u.designation != null ? u.designation : '—'}</td>
                                <td>${u.department != null ? u.department : '—'}</td>
                                <td>${u.joiningDate != null ? u.joiningDate : '—'}</td>
                                <td>${u.workLocation != null ? u.workLocation : '—'}</td>
                                <td>${u.managerName != null ? u.managerName : '—'}</td>
                                <td><span class="badge badge-active">${u.status}</span></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
