-- 2.1 Select the last name of all employees.
SELECT last_name FROM employees;


-- 2.2 Select the last name of all employees, without duplicates.
SELECT DISTINCT last_name FROM employees;


-- 2.3 Select all the data of employees whose last name is "Smith".
SELECT * FROM employees WHERE last_name = 'Smith';


-- 2.4 Select all the data of employees whose last name is "Smith" or "Doe".
SELECT * FROM employees WHERE last_name = 'Smith' OR last_name = 'Doe';


-- 2.5 Select all the data of employees that work in department 14.
SELECT * FROM employees WHERE department = 14;


-- 2.6 Select all the data of employees that work in department 37 or department 77.
SELECT * FROM employees WHERE department = 37 OR department = 77;


-- 2.7 Select all the data of employees whose last name begins with an "S".
SELECT * FROM employees WHERE last_name LIKE 'S%';


-- 2.8 Select the sum of all the departments' budgets.
SELECT SUM(budget) FROM departments;


-- 2.9 Select the number of employees in each department (you only need to show the department code and the number of employees).
SELECT department, COUNT(*)
FROM employees
GROUP BY department;


-- 2.10 Select all the data of employees, including each employee's department's data.
SELECT *
FROM employees, departments
WHERE employees.department = departments.code;
-- or
SELECT *
FROM employees INNER JOIN departments
ON employees.department = departments.code;


-- 2.11 Select the name and last name of each employee, along with the name and budget of the employee's department.
SELECT 
  employees.name AS employee_name,
  employees.last_name AS employee_last_name, 
  departments.name AS department_name, budget
FROM employees, departments
WHERE employees.department = departments.code;
-- or
SELECT 
  employees.name AS employee_name,
  employees.last_name AS employee_last_name, 
  departments.name AS department_name, budget
FROM employees INNER JOIN departments
ON employees.department = departments.code;


-- 2.12 Select the name and last name of employees working for departments with a budget greater than $60,000.
SELECT 
  employees.name,
  last_name
FROM employees, departments
WHERE employees.department = departments.code
  AND departments.budget > 60000;
--or
SELECT 
  employees.name,
  last_name
FROM employees INNER JOIN departments

  AND departments.budget > 60000;


-- 2.13 Select the departments with a budget larger than the average budget of all the departments.
SELECT *
FROM departments
WHERE budget > (SELECT AVG(budget) FROM departments);


-- 2.14 Select the names of departments with more than two employees.
SELECT D.name
FROM departments AS D
WHERE (SELECT COUNT(*) FROM employees WHERE department = D.code ) > 2;
-- or
SELECT name
FROM departments
WHERE code in (SELECT department 
               FROM employees
               GROUP BY department
               HAVING COUNT(*) > 2);
-- or
SELECT D.name
FROM employees AS E, departments AS D
WHERE E.department = D.code
GROUP BY D.name
HAVING COUNT(*) > 2;


-- 2.15 Select the name and last name of employees working for departments with second lowest budget.
SELECT name, last_name
FROM employees
WHERE department = (SELECT code 
                    FROM departments 
                    ORDER BY budget 
                    LIMIT  1 
                    OFFSET 1);
-- or
SELECT name, last_name
FROM employees
WHERE department = (SELECT code 
                    FROM (SELECT * FROM departments ORDER BY budget LIMIT 2) AS S
                    ORDER BY budget DESC
                    LIMIT 1);



-- 2.16  Add a new department called "Quality Assurance", with a budget of $40,000 and departmental code 11. 
-- And Add an employee called "Mary Moore" in that department, with SSN 847-21-9811.
INSERT INTO departments(code, name, budget) VALUES(11, 'Quality Assurance', 40000);
INSERT INTO employees(name, last_name, ssn, department) VALUES('Mary', 'Moore', '847219811', 11);


-- 2.17 Reduce the budget of all departments by 10%.
UPDATE departments SET budget = budget - budget * 0.1;
--or
UPDATE departments SET budget = budget * 0.9;


-- 2.18 Reassign all employees from the Research department (code 77) to the IT department (code 14).
UPDATE employees SET department = 14 WHERE department = 77;


-- 2.19 Delete from the table all employees in the IT department (code 14).
DELETE FROM employees WHERE department = 14;


-- 2.20 Delete from the table all employees who work in departments with a budget greater than or equal to $60,000.
DELETE FROM employees
WHERE department IN (SELECT code FROM departments WHERE budget >= 60000);


-- 2.21 Delete from the table all employees.
DELETE FROM employees
