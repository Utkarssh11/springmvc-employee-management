# Employee Management System

A comprehensive Employee Management System built with Java Spring MVC, Hibernate, and MySQL. This application provides full CRUD operations for managing employees, departments, and roles with a modern web interface.

## Features

- **Employee Management**: Add, edit, view, and delete employees
- **Department Management**: Organize employees into departments
- **Role Management**: Assign multiple roles to employees (many-to-many relationship)
- **Search Functionality**: Search employees, departments, and roles
- **Data Validation**: Comprehensive validation with error messages
- **Responsive UI**: Modern Bootstrap-based user interface
- **Relationship Management**: 
  - Department-Employee: Many-to-One relationship
  - Role-Employee: Many-to-Many relationship

## Technology Stack

- **Framework**: Spring MVC 5.3.21
- **ORM**: Hibernate 5.6.9
- **Database**: MySQL 8.0
- **Frontend**: JSP, Bootstrap 5, Font Awesome
- **Build Tool**: Maven
- **Java Version**: 17

## Project Structure

```
src/
├── main/
│   ├── java/com/employee/
│   │   ├── config/         # Spring configuration classes
│   │   ├── controller/     # MVC controllers
│   │   ├── dao/           # Data Access Objects
│   │   │   └── impl/      # DAO implementations
│   │   ├── model/         # Entity classes
│   │   └── service/       # Service layer
│   │       └── impl/      # Service implementations
│   ├── resources/
│   │   ├── database.properties    # Database configuration
│   │   └── sample_data.sql       # Sample data script
│   └── webapp/
│       ├── WEB-INF/
│       │   ├── views/             # JSP pages
│       │   │   ├── employees/     # Employee views
│       │   │   ├── departments/   # Department views
│       │   │   └── roles/         # Role views
│       │   └── web.xml           # Web configuration
│       └── css/                  # Stylesheets
└── test/java/                    # Test classes
```

## Prerequisites

- Java 17 or higher
- Maven 3.6 or higher
- MySQL 8.0 or higher
- Apache Tomcat 9.0 or higher (for deployment)

## Setup Instructions

### 1. Database Setup

1. Install MySQL and create a database:
```sql
CREATE DATABASE employee_management;
```

2. Update database configuration in `src/main/resources/database.properties`:
```properties
db.url=jdbc:mysql://localhost:3306/employee_management?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
db.username=your_username
db.password=your_password
```

### 2. Build and Run

1. Clone the repository:
```bash
git clone <repository-url>
cd springmvc-employee-management
```

2. Build the project:
```bash
mvn clean compile
```

3. Package the WAR file:
```bash
mvn clean package
```

4. Deploy the generated WAR file (`target/employee-management.war`) to your Tomcat server.

### 3. Access the Application

Open your browser and navigate to:
```
http://localhost:8080/employee-management/
```

## Usage

### Managing Departments
1. Go to "Departments" section
2. Add new departments that will be used to organize employees
3. Each department can have a name and description

### Managing Roles
1. Go to "Roles" section  
2. Create roles that can be assigned to employees
3. Examples: Developer, Manager, Analyst, etc.
4. Each employee can have multiple roles

### Managing Employees
1. Go to "Employees" section
2. Add new employees with:
   - Personal information (name, email, phone)
   - Department assignment (required)
   - Role assignments (at least one required)
   - Hire date and salary
3. Search and filter employees
4. View detailed employee information
5. Edit or delete employees as needed

## Key Features

### Validation
- Email uniqueness validation
- Required field validation
- Phone number format validation
- Salary positive value validation

### Relationships
- **Department-Employee**: Each employee belongs to one department
- **Employee-Role**: Each employee can have multiple roles (many-to-many)

### Search Functionality
- Search employees by first name or last name
- Search departments by name
- Search roles by name

### User Interface
- Responsive Bootstrap-based design
- Intuitive navigation
- Flash messages for user feedback
- Confirmation dialogs for delete operations

## Database Schema

The application uses Hibernate with automatic schema generation. The main tables are:

- `employees`: Employee information
- `departments`: Department information  
- `roles`: Role information
- `employee_roles`: Junction table for employee-role many-to-many relationship

## Development

### Adding New Features
1. Create/modify entity classes in `model` package
2. Add DAO interfaces and implementations
3. Create service interfaces and implementations
4. Add controller methods for handling requests
5. Create corresponding JSP views

### Testing
The application includes sample data script (`sample_data.sql`) for testing purposes.

## Troubleshooting

### Common Issues
1. **Database Connection Error**: Check database.properties configuration
2. **Build Errors**: Ensure Java 17 and Maven are properly installed
3. **Deployment Issues**: Verify Tomcat configuration and WAR deployment

### Error Pages
The application includes custom error pages for:
- 404 Not Found
- 500 Internal Server Error

## License

This project is open source and available under the MIT License.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## Contact

For questions or support, please create an issue in the repository.