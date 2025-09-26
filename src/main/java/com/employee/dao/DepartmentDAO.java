package com.employee.dao;

import com.employee.model.Department;
import java.util.List;

public interface DepartmentDAO extends BaseDAO<Department, Long> {
    Department findByName(String name);
    List<Department> findByNameContaining(String name);
}