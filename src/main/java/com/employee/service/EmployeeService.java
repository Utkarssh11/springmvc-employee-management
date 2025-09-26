package com.employee.service;

import com.employee.model.Employee;
import java.util.List;

public interface EmployeeService {
    Employee save(Employee employee);
    Employee findById(Long id);
    List<Employee> findAll();
    Employee update(Employee employee);
    void deleteById(Long id);
    List<Employee> findByDepartmentId(Long departmentId);
    List<Employee> findByRoleId(Long roleId);
    Employee findByEmail(String email);
    List<Employee> searchByName(String name);
    boolean existsByEmail(String email);
}