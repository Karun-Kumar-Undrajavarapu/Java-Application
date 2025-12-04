# 🔐 LOGIN CREDENTIALS

## Default Test Accounts (Auto-created on first run)

### Admin Account
```
Email:    admin@localhost.com
Password: admin123
Role:     ADMIN
Access:   Admin Dashboard - Manage all users
```

### Regular User Account
```
Email:    user@localhost.com
Password: user123
Role:     USER
Access:   User Dashboard - Edit own profile
```

---

## 🌐 Access Points

**Home Page**: http://localhost:8084/
**Login**: http://localhost:8084/login
**Register**: http://localhost:8084/register

---

## 👨‍💼 Admin Dashboard Features (admin@localhost.com)

After logging in with admin credentials:

1. **View All Users** - See list of all registered users
2. **Delete User** - Remove any user account
3. **Promote User** - Make a regular user an admin
4. **View User Details** - See creation date, email, role

**Access URL**: http://localhost:8084/admin/dashboard

---

## 👤 User Dashboard Features (user@localhost.com)

After logging in with user credentials:

1. **View Profile** - See your account details
2. **Edit Name** - Update your name
3. **Edit Email** - Change your email address
4. **View Account Created** - See when account was created
5. **View Role** - Confirm your account type

**Access URL**: http://localhost:8084/user/dashboard

---

## 📝 Create Additional Accounts

1. Go to http://localhost:8084/register
2. Enter **Name**, **Email**, **Password** (min 6 characters)
3. Click **Register**
4. New users are created as **USER** role by default
5. Admin can promote them via admin dashboard

---

## 🔒 Security Notes

- ✅ Passwords are hashed with BCrypt (cannot be reversed)
- ✅ Minimum 6 characters required
- ✅ Email must be unique
- ✅ Sessions expire on logout
- ✅ All data stored in H2 database

---

## 🧪 Quick Test Commands

**Login as Admin:**
```bash
curl -c /tmp/cookies.txt -X POST http://localhost:8084/perform-login \
  -d "email=admin@localhost.com&password=admin123"
curl -b /tmp/cookies.txt http://localhost:8084/admin/dashboard
```

**Login as User:**
```bash
curl -c /tmp/cookies.txt -X POST http://localhost:8084/perform-login \
  -d "email=user@localhost.com&password=user123"
curl -b /tmp/cookies.txt http://localhost:8084/user/dashboard
```

**Register New User:**
```bash
curl -X POST http://localhost:8084/register \
  -d "name=Jane+Doe&email=jane@example.com&password=pass123"
```

---

**Last Updated**: December 4, 2025
**Application**: User Management System v2.0
**Status**: ✅ Ready to Use
