package com.employee.dao;

import com.employee.model.Employee;
import java.util.List;

public interface EmployeeDAO extends BaseDAO<Employee, Long> {
    List<Employee> findByDepartmentId(Long departmentId);
    List<Employee> findByRoleId(Long roleId);
    Employee findByEmail(String email);
    List<Employee> findByFirstNameContaining(String firstName);
    List<Employee> findByLastNameContaining(String lastName);
}