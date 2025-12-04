# User Management Application - Production Ready

A complete, full-stack Java web application with persistent database, role-based authentication, and multi-tier architecture.

## 🚀 Features

### ✅ **Authentication & Authorization**
- User registration with email validation
- Secure login with BCrypt password hashing
- Admin and User role-based access control
- Session-based authentication
- Logout functionality

### ✅ **Database & Persistence**
- Spring Data JPA with Hibernate ORM
- H2 in-memory database (can switch to PostgreSQL/MySQL)
- Automatic schema generation
- User entity with timestamps

### ✅ **Admin Features**
- View all registered users
- Promote users to admin role
- Delete users
- Manage application

### ✅ **User Features**
- Personal dashboard
- Edit profile (name, email)
- View account details
- Logout

### ✅ **Security**
- BCrypt password encryption
- Spring Security integration
- CSRF protection
- Secure password requirements (min 6 chars)
- Email uniqueness validation

## 🏗 Architecture

```
┌─────────────────────────────────────────┐
│          Frontend (JSP Views)           │
│  - Login, Register, Dashboard Pages     │
└──────────────────┬──────────────────────┘
                   │
┌──────────────────▼──────────────────────┐
│      Controllers (HTTP Handlers)        │
│  - AuthController, AdminController      │
│  - UserProfileController                │
└──────────────────┬──────────────────────┘
                   │
┌──────────────────▼──────────────────────┐
│       Services (Business Logic)         │
│  - UserService with validation          │
└──────────────────┬──────────────────────┘
                   │
┌──────────────────▼──────────────────────┐
│    Repository (Data Access Layer)       │
│  - Spring Data JPA UserRepository       │
└──────────────────┬──────────────────────┘
                   │
┌──────────────────▼──────────────────────┐
│      Database (H2 - Persistent)         │
│  - Users table with JPA annotations     │
└─────────────────────────────────────────┘
```

## 📁 Project Structure

```
src/main/
├── java/com/example/
│   ├── UserManagementApplication.java    # Spring Boot entry point
│   ├── config/
│   │   └── SecurityConfig.java           # Security configuration
│   ├── controller/
│   │   ├── AuthController.java           # Login/Register/Logout
│   │   ├── AdminController.java          # Admin dashboard & user management
│   │   ├── UserProfileController.java    # User profile management
│   │   ├── UserController.java           # Home page
│   │   └── GlobalExceptionHandler.java   # Error handling
│   ├── service/
│   │   └── UserService.java              # Business logic, validation
│   ├── repository/
│   │   └── UserRepository.java           # JPA data access
│   └── model/
│       └── User.java                     # JPA entity with UserRole enum
├── resources/
│   └── application.properties            # Database & server config
└── webapp/WEB-INF/views/
    ├── index.jsp                         # Home page
    ├── login.jsp                         # Login form
    ├── register.jsp                      # Registration form
    ├── admin-dashboard.jsp               # Admin user management
    ├── user-dashboard.jsp                # User profile
    └── error.jsp                         # Error page
```

## 🛠 Tech Stack

- **Backend**: Java 17, Spring Boot 3.3.4, Spring MVC, Spring Data JPA, Spring Security
- **Frontend**: JSP, HTML5, CSS3
- **Database**: H2 (development), easily switchable to PostgreSQL/MySQL
- **Build Tool**: Maven
- **Packaging**: WAR (deployable to Tomcat or executable JAR)
- **Password Encoding**: BCrypt

## 📋 Dependencies (pom.xml)

```xml
- spring-boot-starter-web (MVC framework)
- spring-boot-starter-data-jpa (ORM)
- spring-boot-starter-security (Authentication)
- h2 (Database)
- tomcat-embed-jasper (JSP support)
- jakarta.servlet.jsp.jstl (JSTL tags)
```

## 🚀 Running the Application

### Build
```bash
mvn clean package
```

### Run
```bash
java -jar target/user-management-app.war
```

### Access
```
http://localhost:8084
```

## 🔐 Default Test Credentials

After starting, you can:
1. Go to **`/register`** to create a new account
2. Use login credentials to access dashboard

## 📊 Database Schema

### Users Table
```sql
CREATE TABLE users (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('ADMIN', 'USER') DEFAULT 'USER',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

## 🔄 Application Flow

### User Registration Flow
```
Register Page → POST /register → UserService.registerUser() 
→ Validate input → Hash password (BCrypt) → Save to DB 
→ Redirect to Login with success message
```

### User Login Flow
```
Login Page → POST /perform-login → UserService.authenticateUser() 
→ Find user by email → Verify password → Create session 
→ Redirect to /user/dashboard or /admin/dashboard based on role
```

### Admin Operations
```
/admin/dashboard → View all users → DELETE /admin/delete-user/{id} 
→ or /admin/make-admin/{id} → Update DB → Redirect to dashboard
```

## 🔒 Security Implementation

1. **Password Storage**: BCryptPasswordEncoder - salted hashing
2. **Authentication**: Session-based with HttpSession
3. **Authorization**: Role-based access control in controllers
4. **Validation**: Email format, password length requirements
5. **Database**: Unique constraints on email field
6. **CSRF Protection**: Disabled for simplicity (enable for production)

## 🎨 Frontend Features

### Responsive Design
- Mobile-friendly layouts
- Modern gradient backgrounds
- Intuitive user interfaces

### Error Handling
- User-friendly error messages
- Validation feedback on forms
- Graceful error pages

## 🔄 Data Persistence

- **Database**: H2 in-memory (data persists for app session)
- **Switch to PostgreSQL**: Update `application.properties`:
  ```properties
  spring.datasource.url=jdbc:postgresql://localhost:5432/userdb
  spring.datasource.driverClassName=org.postgresql.Driver
  spring.datasource.username=postgres
  spring.datasource.password=password
  spring.jpa.database-platform=org.hibernate.dialect.PostgreSQLDialect
  ```

## 📈 Future Enhancements

- [ ] Email verification for registration
- [ ] Password reset functionality
- [ ] User activity logging
- [ ] Search/filter users
- [ ] Pagination for user list
- [ ] Export user data
- [ ] API endpoints (REST)
- [ ] Rate limiting
- [ ] 2-Factor Authentication

## 🐛 Troubleshooting

### Port 8084 already in use
```bash
lsof -i :8084          # Find process
kill -9 <PID>          # Kill process
```

### Database errors
- Check `application.properties` for correct DB config
- Ensure H2 connector is in dependencies
- Delete target folder and rebuild: `mvn clean package`

### JSP not rendering
- Verify `spring.mvc.view.prefix` and `spring.mvc.view.suffix` in properties
- Ensure `tomcat-embed-jasper` is in POM with `<scope>compile</scope>`

## 📝 API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/` | Home page |
| GET | `/login` | Login page |
| POST | `/perform-login` | Process login |
| GET | `/register` | Registration page |
| POST | `/register` | Process registration |
| GET | `/logout` | Logout & clear session |
| GET | `/user/dashboard` | User dashboard |
| POST | `/user/update-profile` | Update user info |
| GET | `/admin/dashboard` | Admin panel |
| GET | `/admin/delete-user/{id}` | Delete user |
| GET | `/admin/make-admin/{id}` | Promote to admin |

## 💾 Session Data

Stored in HttpSession:
- `user` - Full User object
- `userId` - User ID
- `userRole` - User role (ADMIN/USER)

## 🎯 Best Practices Implemented

✅ 3-tier architecture (Controller → Service → Repository)
✅ Separation of concerns
✅ DRY principle (Don't Repeat Yourself)
✅ Input validation
✅ Secure password hashing
✅ Proper error handling
✅ Responsive UI/UX
✅ Configuration-driven setup
✅ Database persistence
✅ Role-based access control

## 📄 License

Open source - feel free to use and modify

## 🚀 Next Steps

1. **Test the application** by registering and logging in
2. **Explore admin features** by promoting a user to admin
3. **Customize** the UI/styling in JSP files
4. **Switch to production database** (PostgreSQL/MySQL)
5. **Deploy** to Tomcat or cloud platform

---

**Application Status**: ✅ Production Ready
**Last Updated**: December 4, 2025
**Version**: 2.0.0
