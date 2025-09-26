<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Employee - Employee Management System</title>
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/departments">
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
        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/">Home</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/employees">Employees</a></li>
                <li class="breadcrumb-item active">${employee.firstName} ${employee.lastName}</li>
            </ol>
        </nav>

        <!-- Page Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1>
                <i class="fas fa-user"></i> ${employee.firstName} ${employee.lastName}
            </h1>
            <div>
                <a href="${pageContext.request.contextPath}/employees/${employee.id}/edit" class="btn btn-primary">
                    <i class="fas fa-edit"></i> Edit Employee
                </a>
                <a href="${pageContext.request.contextPath}/employees" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back to List
                </a>
            </div>
        </div>

        <!-- Employee Details -->
        <div class="row">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title mb-0">
                            <i class="fas fa-user-circle"></i> Employee Information
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <table class="table table-borderless">
                                    <tr>
                                        <td><strong>Employee ID:</strong></td>
                                        <td>${employee.id}</td>
                                    </tr>
                                    <tr>
                                        <td><strong>First Name:</strong></td>
                                        <td>${employee.firstName}</td>
                                    </tr>
                                    <tr>
                                        <td><strong>Last Name:</strong></td>
                                        <td>${employee.lastName}</td>
                                    </tr>
                                    <tr>
                                        <td><strong>Email:</strong></td>
                                        <td>
                                            <a href="mailto:${employee.email}">${employee.email}</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><strong>Phone:</strong></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty employee.phone}">
                                                    <a href="tel:${employee.phone}">${employee.phone}</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">Not provided</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div class="col-md-6">
                                <table class="table table-borderless">
                                    <tr>
                                        <td><strong>Hire Date:</strong></td>
                                        <td>
                                            <fmt:formatDate value="${employee.hireDate}" pattern="MMMM dd, yyyy" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><strong>Salary:</strong></td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty employee.salary}">
                                                    <fmt:formatNumber value="${employee.salary}" type="currency" />
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">Not specified</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><strong>Department:</strong></td>
                                        <td>
                                            <span class="badge bg-info fs-6">
                                                <i class="fas fa-building"></i> ${employee.department.name}
                                            </span>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td><strong>Roles:</strong></td>
                                        <td>
                                            <c:forEach var="role" items="${employee.roles}" varStatus="status">
                                                <span class="badge bg-secondary fs-6">
                                                    <i class="fas fa-tag"></i> ${role.name}
                                                </span>
                                                <c:if test="${!status.last}"><br class="mb-1"></c:if>
                                            </c:forEach>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <!-- Department Details -->
                <div class="card mb-3">
                    <div class="card-header">
                        <h6 class="card-title mb-0">
                            <i class="fas fa-building"></i> Department Details
                        </h6>
                    </div>
                    <div class="card-body">
                        <h6>${employee.department.name}</h6>
                        <c:if test="${not empty employee.department.description}">
                            <p class="text-muted mb-0">${employee.department.description}</p>
                        </c:if>
                        <a href="${pageContext.request.contextPath}/departments/${employee.department.id}" 
                           class="btn btn-sm btn-outline-info mt-2">
                            <i class="fas fa-eye"></i> View Department
                        </a>
                    </div>
                </div>

                <!-- Role Details -->
                <div class="card">
                    <div class="card-header">
                        <h6 class="card-title mb-0">
                            <i class="fas fa-tags"></i> Role Details
                        </h6>
                    </div>
                    <div class="card-body">
                        <c:forEach var="role" items="${employee.roles}" varStatus="status">
                            <div class="mb-3 ${!status.last ? 'border-bottom pb-3' : ''}">
                                <h6 class="mb-1">${role.name}</h6>
                                <c:if test="${not empty role.description}">
                                    <p class="text-muted small mb-1">${role.description}</p>
                                </c:if>
                                <a href="${pageContext.request.contextPath}/roles/${role.id}" 
                                   class="btn btn-sm btn-outline-secondary">
                                    <i class="fas fa-eye"></i> View Role
                                </a>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>

        <!-- Action Buttons -->
        <div class="row mt-4">
            <div class="col-12">
                <div class="card">
                    <div class="card-body">
                        <h6 class="card-title">Actions</h6>
                        <div class="d-flex gap-2 flex-wrap">
                            <a href="${pageContext.request.contextPath}/employees/${employee.id}/edit" 
                               class="btn btn-primary">
                                <i class="fas fa-edit"></i> Edit Employee
                            </a>
                            <form action="${pageContext.request.contextPath}/employees/${employee.id}/delete" 
                                  method="post" class="d-inline"
                                  onsubmit="return confirmDelete('${employee.firstName} ${employee.lastName}')">
                                <button type="submit" class="btn btn-danger">
                                    <i class="fas fa-trash"></i> Delete Employee
                                </button>
                            </form>
                            <a href="${pageContext.request.contextPath}/employees" class="btn btn-secondary">
                                <i class="fas fa-list"></i> All Employees
                            </a>
                            <a href="${pageContext.request.contextPath}/employees/new" class="btn btn-success">
                                <i class="fas fa-plus"></i> Add New Employee
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmDelete(itemName) {
            return confirm('Are you sure you want to delete employee "' + itemName + '"? This action cannot be undone.');
        }
    </script>
</body>
</html>