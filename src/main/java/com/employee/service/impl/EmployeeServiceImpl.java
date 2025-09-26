package com.employee.service.impl;

import com.employee.dao.EmployeeDAO;
import com.employee.model.Employee;
import com.employee.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Service
@Transactional
public class EmployeeServiceImpl implements EmployeeService {
    
    @Autowired
    private EmployeeDAO employeeDAO;
    
    @Override
    public Employee save(Employee employee) {
        return employeeDAO.save(employee);
    }
    
    @Override
    public Employee findById(Long id) {
        return employeeDAO.findById(id).orElse(null);
    }
    
    @Override
    public List<Employee> findAll() {
        return employeeDAO.findAll();
    }
    
    @Override
    public Employee update(Employee employee) {
        return employeeDAO.update(employee);
    }
    
    @Override
    public void deleteById(Long id) {
        employeeDAO.deleteById(id);
    }
    
    @Override
    public List<Employee> findByDepartmentId(Long departmentId) {
        return employeeDAO.findByDepartmentId(departmentId);
    }
    
    @Override
    public List<Employee> findByRoleId(Long roleId) {
        return employeeDAO.findByRoleId(roleId);
    }
    
    @Override
    public Employee findByEmail(String email) {
        return employeeDAO.findByEmail(email);
    }
    
    @Override
    public List<Employee> searchByName(String name) {
        List<Employee> byFirstName = employeeDAO.findByFirstNameContaining(name);
        List<Employee> byLastName = employeeDAO.findByLastNameContaining(name);
        
        return Stream.concat(byFirstName.stream(), byLastName.stream())
                .distinct()
                .collect(Collectors.toList());
    }
    
    @Override
    public boolean existsByEmail(String email) {
        return findByEmail(email) != null;
    }
}