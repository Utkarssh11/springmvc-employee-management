<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Departments - Employee Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/">
                <i class="fas fa-users"></i> Employee Management System
            </a>
            
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/employees">
                            <i class="fas fa-user"></i> Employees
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/departments">
                            <i class="fas fa-building"></i> Departments
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/roles">
                            <i class="fas fa-tags"></i> Roles
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <!-- Flash Messages -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle"></i> ${successMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-circle"></i> ${errorMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Page Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1><i class="fas fa-building"></i> Departments</h1>
            <a href="${pageContext.request.contextPath}/departments/new" class="btn btn-primary">
                <i class="fas fa-plus"></i> Add New Department
            </a>
        </div>

        <!-- Search Form -->
        <div class="card mb-4">
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/departments/search" method="get" class="row g-3">
                    <div class="col-md-8">
                        <input type="text" class="form-control" name="name" 
                               value="${searchName}" placeholder="Search departments by name...">
                    </div>
                    <div class="col-md-4">
                        <div class="d-grid gap-2 d-md-flex">
                            <button type="submit" class="btn btn-outline-primary">
                                <i class="fas fa-search"></i> Search
                            </button>
                            <a href="${pageContext.request.contextPath}/departments" class="btn btn-outline-secondary">
                                <i class="fas fa-times"></i> Clear
                            </a>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- Departments Grid -->
        <c:choose>
            <c:when test="${empty departments}">
                <div class="text-center p-5">
                    <i class="fas fa-building fa-3x text-muted mb-3"></i>
                    <h5 class="text-muted">No departments found</h5>
                    <p class="text-muted">Create your first department to organize employees.</p>
                    <a href="${pageContext.request.contextPath}/departments/new" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Add Department
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="row">
                    <c:forEach var="department" items="${departments}">
                        <div class="col-md-6 col-lg-4 mb-4">
                            <div class="card h-100">
                                <div class="card-header bg-info text-white">
                                    <h5 class="card-title mb-0">
                                        <i class="fas fa-building"></i> ${department.name}
                                    </h5>
                                </div>
                                <div class="card-body d-flex flex-column">
                                    <p class="card-text flex-grow-1">
                                        <c:choose>
                                            <c:when test="${not empty department.description}">
                                                ${department.description}
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">No description provided</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                    <div class="mt-auto">
                                        <div class="d-flex justify-content-between align-items-center mb-3">
                                            <span class="badge bg-secondary">
                                                <i class="fas fa-users"></i> ${department.employees.size()} employees
                                            </span>
                                        </div>
                                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                            <a href="${pageContext.request.contextPath}/departments/${department.id}" 
                                               class="btn btn-sm btn-outline-info">
                                                <i class="fas fa-eye"></i> View
                                            </a>
                                            <a href="${pageContext.request.contextPath}/departments/${department.id}/edit" 
                                               class="btn btn-sm btn-outline-primary">
                                                <i class="fas fa-edit"></i> Edit
                                            </a>
                                            <c:choose>
                                                <c:when test="${department.employees.size() > 0}">
                                                    <button class="btn btn-sm btn-outline-danger" disabled title="Cannot delete department with employees">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    <form action="${pageContext.request.contextPath}/departments/${department.id}/delete" 
                                                          method="post" class="d-inline"
                                                          onsubmit="return confirmDelete('${department.name}')">
                                                        <button type="submit" class="btn btn-sm btn-outline-danger">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </form>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Summary -->
                <div class="card mt-4">
                    <div class="card-body">
                        <h6 class="card-title">
                            <i class="fas fa-chart-bar"></i> Summary
                        </h6>
                        <div class="row text-center">
                            <div class="col-md-4">
                                <div class="border-end">
                                    <h4 class="text-primary">${departments.size()}</h4>
                                    <p class="text-muted mb-0">Total Departments</p>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="border-end">
                                    <h4 class="text-success">
                                        <c:set var="totalEmployees" value="0" />
                                        <c:forEach var="dept" items="${departments}">
                                            <c:set var="totalEmployees" value="${totalEmployees + dept.employees.size()}" />
                                        </c:forEach>
                                        ${totalEmployees}
                                    </h4>
                                    <p class="text-muted mb-0">Total Employees</p>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <h4 class="text-warning">
                                    <c:set var="emptyDepartments" value="0" />
                                    <c:forEach var="dept" items="${departments}">
                                        <c:if test="${dept.employees.size() == 0}">
                                            <c:set var="emptyDepartments" value="${emptyDepartments + 1}" />
                                        </c:if>
                                    </c:forEach>
                                    ${emptyDepartments}
                                </h4>
                                <p class="text-muted mb-0">Empty Departments</p>
                            </div>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmDelete(itemName) {
            return confirm('Are you sure you want to delete department "' + itemName + '"? This action cannot be undone.');
        }
        
        // Auto-dismiss alerts after 5 seconds
        setTimeout(function() {
            var alerts = document.querySelectorAll('.alert');
            alerts.forEach(function(alert) {
                var bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);
    </script>
</body>
</html>