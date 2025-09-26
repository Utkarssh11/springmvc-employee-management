<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        <c:choose>
            <c:when test="${department.id != null}">Edit Department</c:when>
            <c:otherwise>Add Department</c:otherwise>
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
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/departments">Departments</a></li>
                <li class="breadcrumb-item active">
                    <c:choose>
                        <c:when test="${department.id != null}">Edit Department</c:when>
                        <c:otherwise>Add Department</c:otherwise>
                    </c:choose>
                </li>
            </ol>
        </nav>

        <!-- Page Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h1>
                <i class="fas fa-building-circle-arrow-right"></i>
                <c:choose>
                    <c:when test="${department.id != null}">Edit Department</c:when>
                    <c:otherwise>Add New Department</c:otherwise>
                </c:choose>
            </h1>
            <a href="${pageContext.request.contextPath}/departments" class="btn btn-secondary">
                <i class="fas fa-arrow-left"></i> Back to List
            </a>
        </div>

        <!-- Department Form -->
        <div class="row">
            <div class="col-md-8 mx-auto">
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title mb-0">Department Information</h5>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${department.id != null}">
                                <c:set var="formAction" value="${pageContext.request.contextPath}/departments/${department.id}" />
                            </c:when>
                            <c:otherwise>
                                <c:set var="formAction" value="${pageContext.request.contextPath}/departments" />
                            </c:otherwise>
                        </c:choose>

                        <form action="${formAction}" method="post">
                            <div class="mb-4">
                                <label for="name" class="form-label">
                                    Department Name <span class="text-danger">*</span>
                                </label>
                                <input type="text" class="form-control ${not empty bindingResult && bindingResult.hasFieldErrors('name') ? 'is-invalid' : ''}" 
                                       id="name" name="name" value="${department.name}" required 
                                       placeholder="Enter department name">
                                <c:if test="${not empty bindingResult && bindingResult.hasFieldErrors('name')}">
                                    <div class="invalid-feedback">
                                        ${bindingResult.getFieldError('name').defaultMessage}
                                    </div>
                                </c:if>
                                <div class="form-text">
                                    Enter a unique name for the department (2-50 characters)
                                </div>
                            </div>

                            <div class="mb-4">
                                <label for="description" class="form-label">Description</label>
                                <textarea class="form-control ${not empty bindingResult && bindingResult.hasFieldErrors('description') ? 'is-invalid' : ''}" 
                                          id="description" name="description" rows="4" 
                                          placeholder="Enter department description (optional)">${department.description}</textarea>
                                <c:if test="${not empty bindingResult && bindingResult.hasFieldErrors('description')}">
                                    <div class="invalid-feedback">
                                        ${bindingResult.getFieldError('description').defaultMessage}
                                    </div>
                                </c:if>
                                <div class="form-text">
                                    Provide a brief description of the department (up to 200 characters)
                                </div>
                            </div>

                            <div class="d-flex justify-content-between">
                                <a href="${pageContext.request.contextPath}/departments" class="btn btn-secondary">
                                    <i class="fas fa-times"></i> Cancel
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i>
                                    <c:choose>
                                        <c:when test="${department.id != null}">Update Department</c:when>
                                        <c:otherwise>Create Department</c:otherwise>
                                    </c:choose>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Help Information -->
                <div class="card mt-4">
                    <div class="card-header">
                        <h6 class="card-title mb-0">
                            <i class="fas fa-info-circle"></i> Information
                        </h6>
                    </div>
                    <div class="card-body">
                        <ul class="mb-0">
                            <li>Department names must be unique across the system</li>
                            <li>Once created, departments can be assigned to employees</li>
                            <li>You cannot delete a department that has employees assigned to it</li>
                            <li>All fields marked with <span class="text-danger">*</span> are required</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Focus on the name field when page loads
        document.getElementById('name').focus();

        // Character counter for description
        const descriptionField = document.getElementById('description');
        const maxLength = 200;
        
        // Create character counter element
        const counterDiv = document.createElement('div');
        counterDiv.className = 'form-text text-end';
        counterDiv.id = 'charCounter';
        descriptionField.parentNode.appendChild(counterDiv);
        
        function updateCounter() {
            const currentLength = descriptionField.value.length;
            counterDiv.textContent = currentLength + '/' + maxLength + ' characters';
            
            if (currentLength > maxLength * 0.8) {
                counterDiv.className = 'form-text text-end text-warning';
            } else {
                counterDiv.className = 'form-text text-end text-muted';
            }
        }
        
        descriptionField.addEventListener('input', updateCounter);
        updateCounter(); // Initial call
    </script>
</body>
</html>