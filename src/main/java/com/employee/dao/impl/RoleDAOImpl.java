package com.employee.dao.impl;

import com.employee.dao.RoleDAO;
import com.employee.model.Role;
import org.springframework.stereotype.Repository;

import javax.persistence.TypedQuery;
import java.util.List;

@Repository
public class RoleDAOImpl extends BaseDAOImpl<Role, Long> implements RoleDAO {
    
    @Override
    public Role findByName(String name) {
        String jpql = "SELECT r FROM Role r WHERE r.name = :name";
        TypedQuery<Role> query = entityManager.createQuery(jpql, Role.class);
        query.setParameter("name", name);
        List<Role> results = query.getResultList();
        return results.isEmpty() ? null : results.get(0);
    }
    
    @Override
    public List<Role> findByNameContaining(String name) {
        String jpql = "SELECT r FROM Role r WHERE LOWER(r.name) LIKE LOWER(:name)";
        TypedQuery<Role> query = entityManager.createQuery(jpql, Role.class);
        query.setParameter("name", "%" + name + "%");
        return query.getResultList();
    }
}