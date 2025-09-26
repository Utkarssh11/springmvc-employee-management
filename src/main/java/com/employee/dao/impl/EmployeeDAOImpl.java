package com.employee.dao.impl;

import com.employee.dao.EmployeeDAO;
import com.employee.model.Employee;
import org.springframework.stereotype.Repository;

import javax.persistence.TypedQuery;
import java.util.List;

@Repository
public class EmployeeDAOImpl extends BaseDAOImpl<Employee, Long> implements EmployeeDAO {
    
    @Override
    public List<Employee> findByDepartmentId(Long departmentId) {
        String jpql = "SELECT e FROM Employee e WHERE e.department.id = :departmentId";
        TypedQuery<Employee> query = entityManager.createQuery(jpql, Employee.class);
        query.setParameter("departmentId", departmentId);
        return query.getResultList();
    }
    
    @Override
    public List<Employee> findByRoleId(Long roleId) {
        String jpql = "SELECT e FROM Employee e JOIN e.roles r WHERE r.id = :roleId";
        TypedQuery<Employee> query = entityManager.createQuery(jpql, Employee.class);
        query.setParameter("roleId", roleId);
        return query.getResultList();
    }
    
    @Override
    public Employee findByEmail(String email) {
        String jpql = "SELECT e FROM Employee e WHERE e.email = :email";
        TypedQuery<Employee> query = entityManager.createQuery(jpql, Employee.class);
        query.setParameter("email", email);
        List<Employee> results = query.getResultList();
        return results.isEmpty() ? null : results.get(0);
    }
    
    @Override
    public List<Employee> findByFirstNameContaining(String firstName) {
        String jpql = "SELECT e FROM Employee e WHERE LOWER(e.firstName) LIKE LOWER(:firstName)";
        TypedQuery<Employee> query = entityManager.createQuery(jpql, Employee.class);
        query.setParameter("firstName", "%" + firstName + "%");
        return query.getResultList();
    }
    
    @Override
    public List<Employee> findByLastNameContaining(String lastName) {
        String jpql = "SELECT e FROM Employee e WHERE LOWER(e.lastName) LIKE LOWER(:lastName)";
        TypedQuery<Employee> query = entityManager.createQuery(jpql, Employee.class);
        query.setParameter("lastName", "%" + lastName + "%");
        return query.getResultList();
    }
}