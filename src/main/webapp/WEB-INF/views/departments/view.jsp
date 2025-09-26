<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Department - Employee Management System</title>
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
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/departments">Departments</a></li>
                <li class="breadcrumb-item active">${department.name}</li>
            </ol>
        </nav>

        <!-- Page Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1>
                <i class="fas fa-building"></i> ${department.name}
            </h1>
            <div>
                <a href="${pageContext.request.contextPath}/departments/${department.id}/edit" class="btn btn-primary">
                    <i class="fas fa-edit"></i> Edit Department
                </a>
                <a href="${pageContext.request.contextPath}/departments" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back to List
                </a>
            </div>
        </div>

        <div class="row">
            <!-- Department Information -->
            <div class="col-md-4">
                <div class="card mb-4">
                    <div class="card-header bg-info text-white">
                        <h5 class="card-title mb-0">
                            <i class="fas fa-info-circle"></i> Department Details
                        </h5>
                    </div>
                    <div class="card-body">
                        <table class="table table-borderless">
                            <tr>
                                <td><strong>ID:</strong></td>
                                <td>${department.id}</td>
                            </tr>
                            <tr>
                                <td><strong>Name:</strong></td>
                                <td>${department.name}</td>
                            </tr>
                            <tr>
                                <td><strong>Description:</strong></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty department.description}">
                                            ${department.description}
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">No description provided</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr>
                                <td><strong>Employees:</strong></td>
                                <td>
                                    <span class="badge bg-secondary fs-6">
                                        <i class="fas fa-users"></i> ${department.employees.size()}
                                    </span>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>

                <!-- Actions -->
                <div class="card">
                    <div class="card-header">
                        <h6 class="card-title mb-0">
                            <i class="fas fa-cogs"></i> Actions
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="d-grid gap-2">
                            <a href="${pageContext.request.contextPath}/departments/${department.id}/edit" 
                               class="btn btn-primary">
                                <i class="fas fa-edit"></i> Edit Department
                            </a>
                            <c:choose>
                                <c:when test="${department.employees.size() > 0}">
                                    <button class="btn btn-danger" disabled title="Cannot delete department with employees">
                                        <i class="fas fa-trash"></i> Delete Department
                                    </button>
                                    <small class="text-muted">Cannot delete department with assigned employees</small>
                                </c:when>
                                <c:otherwise>
                                    <form action="${pageContext.request.contextPath}/departments/${department.id}/delete" 
                                          method="post" onsubmit="return confirmDelete('${department.name}')">
                                        <button type="submit" class="btn btn-danger w-100">
                                            <i class="fas fa-trash"></i> Delete Department
                                        </button>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                            <a href="${pageContext.request.contextPath}/departments" class="btn btn-secondary">
                                <i class="fas fa-list"></i> All Departments
                            </a>
                            <a href="${pageContext.request.contextPath}/departments/new" class="btn btn-success">
                                <i class="fas fa-plus"></i> Add New Department
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Employees List -->
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title mb-0">
                            <i class="fas fa-users"></i> Department Employees 
                            <span class="badge bg-secondary">${department.employees.size()}</span>
                        </h5>
                    </div>
                    <div class="card-body p-0">
                        <c:choose>
                            <c:when test="${empty department.employees}">
                                <div class="text-center p-5">
                                    <i class="fas fa-user-plus fa-3x text-muted mb-3"></i>
                                    <h6 class="text-muted">No employees in this department</h6>
                                    <p class="text-muted">Assign employees to this department to see them here.</p>
                                    <a href="${pageContext.request.contextPath}/employees/new" class="btn btn-primary">
                                        <i class="fas fa-plus"></i> Add Employee
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover mb-0">
                                        <thead class="table-dark">
                                            <tr>
                                                <th>Name</th>
                                                <th>Email</th>
                                                <th>Phone</th>
                                                <th>Roles</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="employee" items="${department.employees}">
                                                <tr>
                                                    <td>
                                                        <strong>${employee.firstName} ${employee.lastName}</strong>
                                                    </td>
                                                    <td>${employee.email}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty employee.phone}">
                                                                ${employee.phone}
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">-</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:forEach var="role" items="${employee.roles}" varStatus="status">
                                                            <span class="badge bg-secondary">${role.name}</span>
                                                            <c:if test="${!status.last}"> </c:if>
                                                        </c:forEach>
                                                    </td>
                                                    <td>
                                                        <div class="btn-group" role="group">
                                                            <a href="${pageContext.request.contextPath}/employees/${employee.id}" 
                                                               class="btn btn-sm btn-outline-info" title="View Employee">
                                                                <i class="fas fa-eye"></i>
                                                            </a>
                                                            <a href="${pageContext.request.contextPath}/employees/${employee.id}/edit" 
                                                               class="btn btn-sm btn-outline-primary" title="Edit Employee">
                                                                <i class="fas fa-edit"></i>
                                                            </a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmDelete(itemName) {
            return confirm('Are you sure you want to delete department "' + itemName + '"? This action cannot be undone.');
        }
    </script>
</body>
</html>