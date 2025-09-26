package com.employee.service.impl;

import com.employee.dao.DepartmentDAO;
import com.employee.model.Department;
import com.employee.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class DepartmentServiceImpl implements DepartmentService {
    
    @Autowired
    private DepartmentDAO departmentDAO;
    
    @Override
    public Department save(Department department) {
        return departmentDAO.save(department);
    }
    
    @Override
    public Department findById(Long id) {
        return departmentDAO.findById(id).orElse(null);
    }
    
    @Override
    public List<Department> findAll() {
        return departmentDAO.findAll();
    }
    
    @Override
    public Department update(Department department) {
        return departmentDAO.update(department);
    }
    
    @Override
    public void deleteById(Long id) {
        departmentDAO.deleteById(id);
    }
    
    @Override
    public Department findByName(String name) {
        return departmentDAO.findByName(name);
    }
    
    @Override
    public List<Department> searchByName(String name) {
        return departmentDAO.findByNameContaining(name);
    }
    
    @Override
    public boolean existsByName(String name) {
        return findByName(name) != null;
    }
}