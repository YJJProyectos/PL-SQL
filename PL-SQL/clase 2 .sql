/*SELECT last_name
FROM employees
WHERE last_name LIKE '_o%'; */

/*SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary >=10000
OR job_id LIKE '%MAN%'; */

/*SELECT last_name, job_id
FROM employees
WHERE job_id NOT IN ('IT_PROG', 'ST_CLERK', 'SA_REP'); */

/*SELECT last_name, job_id, department_id, hire_date
FROM employees
ORDER BY hire_date ASC; */

/*SELECT last_name, job_id, department_id, salary
FROM employees
ORDER BY salary, department_id DESC; */

/*SELECT COUNT(*)
FROM employees
WHERE department_id = 50;
*/
/*SELECT COUNT(commission_pct)
FROM employees
WHERE department_id = 80; */

SELECT AVG(salary), MAX(salary), MIN(salary), MAX(salary)
FROM employees;

SELECT AVG(salary), MAX(salary), MIN(salary), MAX(salary)
FROM employees
WHERE job_id LIKE '%RE%';

SELECT department_id, AVG(salary)
FROM employees
GROUP BY department_id
ORDER BY department_id;

SELECT department_id, AVG(salary) prom
FROM employees
GROUP BY department_id
ORDER BY prom;

SELECT department_id, COUNT(*) cantidad
FROM employees
GROUP BY department_id
ORDER BY department_id;

SELECT department_id dept_id, job_id, SUM(salary), COUNT(*)
FROM employees
GROUP BY department_id, job_id;

/*SELECT department_id, COUNT(*) CANTIDAD
FROM employees
GROUP BY department_id
HAVING CANTIDAD> 10; */

SELECT employees.employee_id, employees.first_name, employees.last_name, employees.department_id 
FROM employees;

SELECT departments.department_id, departments.department_name, departments.manager_id, departments.location_id
FROM departments;

-- unir las dos consultas

SELECT employees.employee_id, employees.first_name, employees.last_name, employees.department_id,
    departments.department_id, departments.department_name, departments.manager_id, departments.location_id
FROM employees, departments;

SELECT employees.employee_id, employees.first_name, employees.last_name, employees.department_id,
    departments.department_id, departments.department_name, departments.manager_id, departments.location_id
FROM employees, departments
WHERE employees.department_id = departments.department_id;

SELECT * FROM employees
INNER JOIN departments
ON employees.department_id = departments.department_id;

SELECT * FROM employees
LEFT OUTER JOIN departments
ON employees.department_id = departments.department_id;

SELECT e.first_name, e.last_name, d.department_name, l.city, l.state_province
FROM employees e, departments d, locations l
WHERE e.department_id = d.department_id 
AND d.location_id = l.location_id;

SELECT e.first_name, e.last_name, d.department_name, l.city, l.state_province
FROM employees e 
INNER JOIN departments d
ON e.department_id = d.department_id
INNER JOIN locations l
ON d.location_id = l.location_id;
----- 2da parte

SELECT e.first_name, e.last_name, d.department_name, l.city, l.state_province
FROM employees e 
INNER JOIN departments d
ON e.department_id = d.department_id
INNER JOIN locations l
ON d.location_id = l.location_id;

SELECT e.first_name, e.last_name, d.department_name, l.city, l.state_province
FROM employees e 
INNER JOIN departments d
ON e.department_id = d.department_id AND d.department_name IN ('IT','Shipping')
INNER JOIN locations l
ON d.location_id = l.location_id ;

SELECT e.first_name, e.last_name, e.salary , d.department_name, l.city, l.state_province
FROM employees e 
INNER JOIN departments d
ON e.department_id = d.department_id
INNER JOIN locations l
ON d.location_id = l.location_id
ORDER BY e.salary DESC;

SELECT first_name, last_name, salary
FROM employees
WHERE ROWNUM <=3
ORDER BY salary DESC;

SELECT e.first_name, e.last_name, d.department_name, l.city, l.state_province
FROM employees e 
INNER JOIN departments d
ON e.department_id = d.department_id
INNER JOIN locations l
ON d.location_id = l.location_id 
WHERE  d.department_name IN ('IT','Shipping');

SELECT e.first_name, e.last_name, d.department_name, e.salary
FROM employees e
FULL OUTER JOIN departments d
ON e.department_id = d.department_id
WHERE ROWNUM <= 3
ORDER BY e.salary DESC;

SELECT e.first_name, e.last_name, d.department_name, l.street_address, l.city, c.country_name, r.region_name
FROM employees e
INNER JOIN departments d
ON d.department_id = e.department_id
INNER JOIN locations l
ON d.location_id = l.location_id
INNER JOIN countries c
ON l.country_id = c.country_id
INNER JOIN regions r
ON c.region_id = r.region_id;

SELECT e.first_name, e.last_name, d.department_name, l.street_address, l.city, c.country_name, r.region_name
FROM employees e
LEFT OUTER JOIN departments d
ON d.department_id = e.department_id OR e.department_id IS NULL --revisar el nulo
INNER JOIN locations l
ON d.location_id = l.location_id
INNER JOIN countries c
ON l.country_id = c.country_id
INNER JOIN regions r
ON c.region_id = r.region_id;

SELECT e.first_name, e.last_name, d.department_name
FROM employees e
INNER JOIN departments d
ON e.employee_id = d.manager_id ;

SELECT e.first_name "name employee", e.last_name "last name employee", manager.first_name "name manager", manager.last_name "last name manager"
FROM employees e
LEFT OUTER JOIN employees manager
ON e.manager_id = manager.employee_id;

