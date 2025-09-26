<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        <c:choose>
            <c:when test="${employee.id != null}">Edit Employee</c:when>
            <c:otherwise>Add Employee</c:otherwise>
        </c:choose> - Employee Management System
    </title>
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
                <li class="breadcrumb-item active">
                    <c:choose>
                        <c:when test="${employee.id != null}">Edit Employee</c:when>
                        <c:otherwise>Add Employee</c:otherwise>
                    </c:choose>
                </li>
            </ol>
        </nav>

        <!-- Page Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1>
                <i class="fas fa-user-edit"></i>
                <c:choose>
                    <c:when test="${employee.id != null}">Edit Employee</c:when>
                    <c:otherwise>Add New Employee</c:otherwise>
                </c:choose>
            </h1>
            <a href="${pageContext.request.contextPath}/employees" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Back to List
            </a>
        </div>

        <!-- Employee Form -->
        <div class="row">
            <div class="col-md-8 mx-auto">
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title mb-0">Employee Information</h5>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${employee.id != null}">
                                <c:set var="formAction" value="${pageContext.request.contextPath}/employees/${employee.id}" />
                            </c:when>
                            <c:otherwise>
                                <c:set var="formAction" value="${pageContext.request.contextPath}/employees" />
                            </c:otherwise>
                        </c:choose>

                        <form action="${formAction}" method="post">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="firstName" class="form-label">
                                            First Name <span class="text-danger">*</span>
                                        </label>
                                        <input type="text" class="form-control ${not empty bindingResult && bindingResult.hasFieldErrors('firstName') ? 'is-invalid' : ''}" 
                                               id="firstName" name="firstName" value="${employee.firstName}" required>
                                        <c:if test="${not empty bindingResult && bindingResult.hasFieldErrors('firstName')}">
                                            <div class="invalid-feedback">
                                                ${bindingResult.getFieldError('firstName').defaultMessage}
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="lastName" class="form-label">
                                            Last Name <span class="text-danger">*</span>
                                        </label>
                                        <input type="text" class="form-control ${not empty bindingResult && bindingResult.hasFieldErrors('lastName') ? 'is-invalid' : ''}" 
                                               id="lastName" name="lastName" value="${employee.lastName}" required>
                                        <c:if test="${not empty bindingResult && bindingResult.hasFieldErrors('lastName')}">
                                            <div class="invalid-feedback">
                                                ${bindingResult.getFieldError('lastName').defaultMessage}
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="email" class="form-label">
                                            Email <span class="text-danger">*</span>
                                        </label>
                                        <input type="email" class="form-control ${not empty bindingResult && bindingResult.hasFieldErrors('email') ? 'is-invalid' : ''}" 
                                               id="email" name="email" value="${employee.email}" required>
                                        <c:if test="${not empty bindingResult && bindingResult.hasFieldErrors('email')}">
                                            <div class="invalid-feedback">
                                                ${bindingResult.getFieldError('email').defaultMessage}
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="phone" class="form-label">Phone</label>
                                        <input type="text" class="form-control ${not empty bindingResult && bindingResult.hasFieldErrors('phone') ? 'is-invalid' : ''}" 
                                               id="phone" name="phone" value="${employee.phone}" pattern="[0-9]{10}" 
                                               placeholder="1234567890">
                                        <c:if test="${not empty bindingResult && bindingResult.hasFieldErrors('phone')}">
                                            <div class="invalid-feedback">
                                                ${bindingResult.getFieldError('phone').defaultMessage}
                                            </div>
                                        </c:if>
                                        <div class="form-text">Enter 10-digit phone number</div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="hireDate" class="form-label">
                                            Hire Date <span class="text-danger">*</span>
                                        </label>
                                        <input type="date" class="form-control ${not empty bindingResult && bindingResult.hasFieldErrors('hireDate') ? 'is-invalid' : ''}" 
                                               id="hireDate" name="hireDate" 
                                               value="<fmt:formatDate value='${employee.hireDate}' pattern='yyyy-MM-dd' />" required>
                                        <c:if test="${not empty bindingResult && bindingResult.hasFieldErrors('hireDate')}">
                                            <div class="invalid-feedback">
                                                ${bindingResult.getFieldError('hireDate').defaultMessage}
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="salary" class="form-label">Salary</label>
                                        <input type="number" class="form-control ${not empty bindingResult && bindingResult.hasFieldErrors('salary') ? 'is-invalid' : ''}" 
                                               id="salary" name="salary" value="${employee.salary}" step="0.01" min="0" 
                                               placeholder="50000.00">
                                        <c:if test="${not empty bindingResult && bindingResult.hasFieldErrors('salary')}">
                                            <div class="invalid-feedback">
                                                ${bindingResult.getFieldError('salary').defaultMessage}
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="department" class="form-label">
                                            Department <span class="text-danger">*</span>
                                        </label>
                                        <select class="form-select ${not empty bindingResult && bindingResult.hasFieldErrors('department') ? 'is-invalid' : ''}" 
                                                id="department" name="department.id" required>
                                            <option value="">Select Department</option>
                                            <c:forEach var="dept" items="${departments}">
                                                <option value="${dept.id}" 
                                                        ${employee.department != null && employee.department.id == dept.id ? 'selected' : ''}>
                                                    ${dept.name}
                                                </option>
                                            </c:forEach>
                                        </select>
                                        <c:if test="${not empty bindingResult && bindingResult.hasFieldErrors('department')}">
                                            <div class="invalid-feedback">
                                                ${bindingResult.getFieldError('department').defaultMessage}
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">
                                            Roles <span class="text-danger">*</span>
                                        </label>
                                        <div class="border p-3 rounded" style="max-height: 200px; overflow-y: auto;">
                                            <c:forEach var="role" items="${roles}">
                                                <div class="form-check">
                                                    <input class="form-check-input" type="checkbox" 
                                                           name="roleIds" value="${role.id}" id="role${role.id}"
                                                           <c:forEach var="empRole" items="${employee.roles}">
                                                               ${empRole.id == role.id ? 'checked' : ''}
                                                           </c:forEach>>
                                                    <label class="form-check-label" for="role${role.id}">
                                                        ${role.name}
                                                        <c:if test="${not empty role.description}">
                                                            <small class="text-muted">- ${role.description}</small>
                                                        </c:if>
                                                    </label>
                                                </div>
                                            </c:forEach>
                                        </div>
                                        <c:if test="${not empty bindingResult && bindingResult.hasFieldErrors('roles')}">
                                            <div class="text-danger mt-1">
                                                ${bindingResult.getFieldError('roles').defaultMessage}
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>

                            <div class="d-flex justify-content-between">
                                <a href="${pageContext.request.contextPath}/employees" class="btn btn-secondary">
                                    <i class="fas fa-times"></i> Cancel
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i>
                                    <c:choose>
                                        <c:when test="${employee.id != null}">Update Employee</c:when>
                                        <c:otherwise>Create Employee</c:otherwise>
                                    </c:choose>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Validate that at least one role is selected
        document.querySelector('form').addEventListener('submit', function(e) {
            const roleCheckboxes = document.querySelectorAll('input[name="roleIds"]:checked');
            if (roleCheckboxes.length === 0) {
                e.preventDefault();
                alert('Please select at least one role for the employee.');
                return false;
            }
        });

        // Set today's date as default hire date for new employees
        <c:if test="${employee.id == null}">
            document.getElementById('hireDate').value = new Date().toISOString().split('T')[0];
        </c:if>
    </script>
</body>
</html>