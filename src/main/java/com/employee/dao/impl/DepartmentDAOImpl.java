package com.employee.dao.impl;

import com.employee.dao.DepartmentDAO;
import com.employee.model.Department;
import org.springframework.stereotype.Repository;

import javax.persistence.TypedQuery;
import java.util.List;

@Repository
public class DepartmentDAOImpl extends BaseDAOImpl<Department, Long> implements DepartmentDAO {
    
    @Override
    public Department findByName(String name) {
        String jpql = "SELECT d FROM Department d WHERE d.name = :name";
        TypedQuery<Department> query = entityManager.createQuery(jpql, Department.class);
        query.setParameter("name", name);
        List<Department> results = query.getResultList();
        return results.isEmpty() ? null : results.get(0);
    }
    
    @Override
    public List<Department> findByNameContaining(String name) {
        String jpql = "SELECT d FROM Department d WHERE LOWER(d.name) LIKE LOWER(:name)";
        TypedQuery<Department> query = entityManager.createQuery(jpql, Department.class);
        query.setParameter("name", "%" + name + "%");
        return query.getResultList();
    }
}