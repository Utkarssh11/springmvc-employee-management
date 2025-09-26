-- Sample data for Employee Management System

-- Create database if not exists
CREATE DATABASE IF NOT EXISTS employee_management;
USE employee_management;

-- Sample departments
INSERT INTO departments (dept_name, description) VALUES 
('Information Technology', 'Responsible for technology infrastructure and software development'),
('Human Resources', 'Manages employee relations, recruitment, and organizational development'),
('Sales', 'Handles customer acquisition and revenue generation'),
('Marketing', 'Manages brand promotion and market analysis'),
('Finance', 'Manages financial operations and accounting');

-- Sample roles
INSERT INTO roles (role_name, description) VALUES 
('Software Developer', 'Develops and maintains software applications'),
('System Administrator', 'Manages IT infrastructure and systems'),
('HR Manager', 'Oversees human resources operations'),
('Sales Manager', 'Manages sales team and strategies'),
('Marketing Specialist', 'Creates marketing campaigns and content'),
('Financial Analyst', 'Analyzes financial data and trends'),
('Team Lead', 'Leads and coordinates team activities'),
('Senior Developer', 'Senior software development role with mentoring responsibilities');

-- Sample employees (Note: Actual insertion should be done through the application)
-- These are example INSERT statements that would work after the tables are created by Hibernate:

/*
INSERT INTO employees (first_name, last_name, email, phone, hire_date, salary, dept_id) VALUES 
('John', 'Smith', 'john.smith@company.com', '1234567890', '2023-01-15', 75000.00, 1),
('Sarah', 'Johnson', 'sarah.johnson@company.com', '2345678901', '2023-02-20', 85000.00, 1),
('Michael', 'Brown', 'michael.brown@company.com', '3456789012', '2023-03-10', 65000.00, 2),
('Emily', 'Davis', 'emily.davis@company.com', '4567890123', '2023-04-05', 70000.00, 3),
('David', 'Wilson', 'david.wilson@company.com', '5678901234', '2023-05-12', 72000.00, 4);

-- Sample employee-role assignments
INSERT INTO employee_roles (emp_id, role_id) VALUES 
(1, 1), (1, 7),  -- John: Software Developer, Team Lead
(2, 8), (2, 7),  -- Sarah: Senior Developer, Team Lead
(3, 3),          -- Michael: HR Manager
(4, 4),          -- Emily: Sales Manager
(5, 5);          -- David: Marketing Specialist
*/