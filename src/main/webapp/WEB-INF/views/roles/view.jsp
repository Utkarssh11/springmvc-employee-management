<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Role - Employee Management System</title>
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
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/roles">Roles</a></li>
                <li class="breadcrumb-item active">${role.name}</li>
            </ol>
        </nav>

        <!-- Page Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1>
                <i class="fas fa-tag"></i> ${role.name}
            </h1>
            <div>
                <a href="${pageContext.request.contextPath}/roles/${role.id}/edit" class="btn btn-primary">
                    <i class="fas fa-edit"></i> Edit Role
                </a>
                <a href="${pageContext.request.contextPath}/roles" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back to List
                </a>
            </div>
        </div>

        <div class="row">
            <!-- Role Information -->
            <div class="col-md-4">
                <div class="card mb-4">
                    <div class="card-header bg-secondary text-white">
                        <h5 class="card-title mb-0">
                            <i class="fas fa-info-circle"></i> Role Details
                        </h5>
                    </div>
                    <div class="card-body">
                        <table class="table table-borderless">
                            <tr>
                                <td><strong>ID:</strong></td>
                                <td>${role.id}</td>
                            </tr>
                            <tr>
                                <td><strong>Name:</strong></td>
                                <td>${role.name}</td>
                            </tr>
                            <tr>
                                <td><strong>Description:</strong></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty role.description}">
                                            ${role.description}
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted">No description provided</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            <tr>
                                <td><strong>Assigned to:</strong></td>
                                <td>
                                    <span class="badge bg-primary fs-6">
                                        <i class="fas fa-users"></i> ${role.employees.size()} employees
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
                            <a href="${pageContext.request.contextPath}/roles/${role.id}/edit" 
                               class="btn btn-primary">
                                <i class="fas fa-edit"></i> Edit Role
                            </a>
                            <c:choose>
                                <c:when test="${role.employees.size() > 0}">
                                    <button class="btn btn-danger" disabled title="Cannot delete role with employees">
                                        <i class="fas fa-trash"></i> Delete Role
                                    </button>
                                    <small class="text-muted">Cannot delete role assigned to employees</small>
                                </c:when>
                                <c:otherwise>
                                    <form action="${pageContext.request.contextPath}/roles/${role.id}/delete" 
                                          method="post" onsubmit="return confirmDelete('${role.name}')">
                                        <button type="submit" class="btn btn-danger w-100">
                                            <i class="fas fa-trash"></i> Delete Role
                                        </button>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                            <a href="${pageContext.request.contextPath}/roles" class="btn btn-secondary">
                                <i class="fas fa-list"></i> All Roles
                            </a>
                            <a href="${pageContext.request.contextPath}/roles/new" class="btn btn-success">
                                <i class="fas fa-plus"></i> Add New Role
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
                            <i class="fas fa-users"></i> Employees with this Role 
                            <span class="badge bg-secondary">${role.employees.size()}</span>
                        </h5>
                    </div>
                    <div class="card-body p-0">
                        <c:choose>
                            <c:when test="${empty role.employees}">
                                <div class="text-center p-5">
                                    <i class="fas fa-user-plus fa-3x text-muted mb-3"></i>
                                    <h6 class="text-muted">No employees assigned to this role</h6>
                                    <p class="text-muted">Assign this role to employees to see them here.</p>
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
                                                <th>Department</th>
                                                <th>Other Roles</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="employee" items="${role.employees}">
                                                <tr>
                                                    <td>
                                                        <strong>${employee.firstName} ${employee.lastName}</strong>
                                                    </td>
                                                    <td>${employee.email}</td>
                                                    <td>
                                                        <span class="badge bg-info">${employee.department.name}</span>
                                                    </td>
                                                    <td>
                                                        <c:forEach var="empRole" items="${employee.roles}" varStatus="status">
                                                            <c:if test="${empRole.id != role.id}">
                                                                <span class="badge bg-secondary">${empRole.name}</span>
                                                                <c:if test="${!status.last}"> </c:if>
                                                            </c:if>
                                                        </c:forEach>
                                                        <c:set var="hasOtherRoles" value="false" />
                                                        <c:forEach var="empRole" items="${employee.roles}">
                                                            <c:if test="${empRole.id != role.id}">
                                                                <c:set var="hasOtherRoles" value="true" />
                                                            </c:if>
                                                        </c:forEach>
                                                        <c:if test="${!hasOtherRoles}">
                                                            <span class="text-muted">None</span>
                                                        </c:if>
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
            return confirm('Are you sure you want to delete role "' + itemName + '"? This action cannot be undone.');
        }
    </script>
</body>
</html>