package com.employee.service;

import com.employee.model.Department;
import java.util.List;

public interface DepartmentService {
    Department save(Department department);
    Department findById(Long id);
    List<Department> findAll();
    Department update(Department department);
    void deleteById(Long id);
    Department findByName(String name);
    List<Department> searchByName(String name);
    boolean existsByName(String name);
}