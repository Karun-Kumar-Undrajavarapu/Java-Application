<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Edit User - Admin</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background:#f5f7fa; padding:30px }
        .card { background:#fff; padding:20px; border-radius:8px; box-shadow: 0 6px 18px rgba(15,23,42,0.06); max-width:900px; margin:0 auto }
        .row { display:flex; gap:20px }
        .col { flex:1 }
        label { display:block; margin-bottom:6px; font-weight:600 }
        input, select { width:100%; padding:10px; border-radius:6px; border:1px solid #e6edf3 }
        button { padding:10px 18px; background:#3498db; color:#fff; border:none; border-radius:6px; cursor:pointer }
    </style>
</head>
<body>
    <div class="card">
        <h2>Edit User</h2>
        <c:if test="${not empty error}">
            <div style="color:#c62828">${error}</div>
        </c:if>
        <form method="post" action="/admin/edit-user/${target.id}">
            <div class="row">
                <div class="col">
                    <label>Full Name</label>
                    <input type="text" name="name" value="${target.name}" />
                </div>
                <div class="col">
                    <label>Email</label>
                    <input type="email" name="email" value="${target.email}" />
                </div>
            </div>

            <div class="row" style="margin-top:12px">
                <div class="col">
                    <label>Joining Date</label>
                    <input type="date" name="joiningDate" value="${target.joiningDate}" />
                </div>
                <div class="col">
                    <label>Work Location</label>
                    <input type="text" name="workLocation" value="${target.workLocation}" />
                </div>
            </div>

            <div class="row" style="margin-top:12px">
                <div class="col">
                    <label>Domain</label>
                    <input type="text" name="domain" value="${target.domain}" />
                </div>
                <div class="col">
                    <label>Department</label>
                    <input type="text" name="department" value="${target.department}" />
                </div>
            </div>

            <div class="row" style="margin-top:12px">
                <div class="col">
                    <label>Designation</label>
                    <input type="text" name="designation" value="${target.designation}" />
                </div>
                <div class="col">
                    <label>Phone</label>
                    <input type="text" name="phone" value="${target.phone}" />
                </div>
            </div>

            <div class="row" style="margin-top:12px">
                <div class="col">
                    <label>Manager</label>
                    <input type="text" name="managerName" value="${target.managerName}" />
                </div>
                <div class="col">
                    <label>Status</label>
                    <select name="status">
                        <option value="ACTIVE" ${target.status == 'ACTIVE' ? 'selected' : ''}>ACTIVE</option>
                        <option value="INACTIVE" ${target.status == 'INACTIVE' ? 'selected' : ''}>INACTIVE</option>
                        <option value="TERMINATED" ${target.status == 'TERMINATED' ? 'selected' : ''}>TERMINATED</option>
                    </select>
                </div>
            </div>

            <div style="margin-top:16px">
                <button type="submit">Save</button>
                <a href="/admin/dashboard" style="margin-left:12px">Cancel</a>
            </div>
        </form>
    </div>
</body>
</html>
