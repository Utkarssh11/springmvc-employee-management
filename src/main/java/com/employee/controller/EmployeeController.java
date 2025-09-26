package com.employee.controller;

import com.employee.model.Department;
import com.employee.model.Employee;
import com.employee.model.Role;
import com.employee.service.DepartmentService;
import com.employee.service.EmployeeService;
import com.employee.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.validation.Valid;
import java.util.List;

@Controller
@RequestMapping("/employees")
public class EmployeeController {
    
    @Autowired
    private EmployeeService employeeService;
    
    @Autowired
    private DepartmentService departmentService;
    
    @Autowired
    private RoleService roleService;
    
    @GetMapping
    public String listEmployees(Model model) {
        List<Employee> employees = employeeService.findAll();
        model.addAttribute("employees", employees);
        return "employees/list";
    }
    
    @GetMapping("/new")
    public String showCreateForm(Model model) {
        Employee employee = new Employee();
        List<Department> departments = departmentService.findAll();
        List<Role> roles = roleService.findAll();
        
        model.addAttribute("employee", employee);
        model.addAttribute("departments", departments);
        model.addAttribute("roles", roles);
        
        return "employees/form";
    }
    
    @PostMapping
    public String createEmployee(@Valid @ModelAttribute Employee employee, 
                               BindingResult result, 
                               @RequestParam("roleIds") List<Long> roleIds,
                               Model model, 
                               RedirectAttributes redirectAttributes) {
        
        // Check for duplicate email
        if (employeeService.existsByEmail(employee.getEmail())) {
            result.rejectValue("email", "error.employee", "Email already exists");
        }
        
        if (result.hasErrors()) {
            List<Department> departments = departmentService.findAll();
            List<Role> roles = roleService.findAll();
            model.addAttribute("departments", departments);
            model.addAttribute("roles", roles);
            return "employees/form";
        }
        
        // Set roles
        for (Long roleId : roleIds) {
            Role role = roleService.findById(roleId);
            if (role != null) {
                employee.addRole(role);
            }
        }
        
        employeeService.save(employee);
        redirectAttributes.addFlashAttribute("successMessage", "Employee created successfully!");
        return "redirect:/employees";
    }
    
    @GetMapping("/{id}")
    public String viewEmployee(@PathVariable Long id, Model model) {
        Employee employee = employeeService.findById(id);
        if (employee == null) {
            return "redirect:/employees";
        }
        model.addAttribute("employee", employee);
        return "employees/view";
    }
    
    @GetMapping("/{id}/edit")
    public String showEditForm(@PathVariable Long id, Model model) {
        Employee employee = employeeService.findById(id);
        if (employee == null) {
            return "redirect:/employees";
        }
        
        List<Department> departments = departmentService.findAll();
        List<Role> roles = roleService.findAll();
        
        model.addAttribute("employee", employee);
        model.addAttribute("departments", departments);
        model.addAttribute("roles", roles);
        
        return "employees/form";
    }
    
    @PostMapping("/{id}")
    public String updateEmployee(@PathVariable Long id, 
                               @Valid @ModelAttribute Employee employee, 
                               BindingResult result,
                               @RequestParam("roleIds") List<Long> roleIds,
                               Model model, 
                               RedirectAttributes redirectAttributes) {
        
        Employee existingEmployee = employeeService.findById(id);
        if (existingEmployee == null) {
            return "redirect:/employees";
        }
        
        // Check for duplicate email (excluding current employee)
        Employee emailCheck = employeeService.findByEmail(employee.getEmail());
        if (emailCheck != null && !emailCheck.getId().equals(id)) {
            result.rejectValue("email", "error.employee", "Email already exists");
        }
        
        if (result.hasErrors()) {
            List<Department> departments = departmentService.findAll();
            List<Role> roles = roleService.findAll();
            model.addAttribute("departments", departments);
            model.addAttribute("roles", roles);
            return "employees/form";
        }
        
        // Clear existing roles and set new ones
        existingEmployee.getRoles().clear();
        for (Long roleId : roleIds) {
            Role role = roleService.findById(roleId);
            if (role != null) {
                existingEmployee.addRole(role);
            }
        }
        
        // Update other fields
        existingEmployee.setFirstName(employee.getFirstName());
        existingEmployee.setLastName(employee.getLastName());
        existingEmployee.setEmail(employee.getEmail());
        existingEmployee.setPhone(employee.getPhone());
        existingEmployee.setHireDate(employee.getHireDate());
        existingEmployee.setSalary(employee.getSalary());
        existingEmployee.setDepartment(employee.getDepartment());
        
        employeeService.update(existingEmployee);
        redirectAttributes.addFlashAttribute("successMessage", "Employee updated successfully!");
        return "redirect:/employees";
    }
    
    @PostMapping("/{id}/delete")
    public String deleteEmployee(@PathVariable Long id, RedirectAttributes redirectAttributes) {
        Employee employee = employeeService.findById(id);
        if (employee != null) {
            employeeService.deleteById(id);
            redirectAttributes.addFlashAttribute("successMessage", "Employee deleted successfully!");
        }
        return "redirect:/employees";
    }
    
    @GetMapping("/search")
    public String searchEmployees(@RequestParam(required = false) String name, Model model) {
        List<Employee> employees;
        if (name != null && !name.trim().isEmpty()) {
            employees = employeeService.searchByName(name.trim());
        } else {
            employees = employeeService.findAll();
        }
        
        model.addAttribute("employees", employees);
        model.addAttribute("searchName", name);
        return "employees/list";
    }
}