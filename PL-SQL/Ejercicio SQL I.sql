-- GUIA 1
-- Ej 1)
SELECT first_name, last_name, employee_id, department_id, job_id, commission_pct, salary
FROM employees
WHERE commission_pct IS NULL AND salary <= 10000 AND salary >=7000;

SELECT first_name, last_name, employee_id, department_id, job_id, commission_pct, salary
FROM employees
WHERE commission_pct IS NULL AND salary BETWEEN 7000 AND 10000;

-- Ej 2)
SELECT first_name, last_name, employee_id, job_id 
FROM employees
WHERE job_id IN ('IT_PROG', 'ST_MAN', 'PR_REP') 
ORDER BY job_id;
-- Ej 3)
SELECT first_name, last_name, job_id, salary, commission_pct, salary * commission_pct multiply_salary_commission
FROM employees
WHERE first_name = 'Alberto';
-- Ej 4)
SELECT DISTINCT department_id 
FROM employees 
ORDER BY department_id;

SELECT DISTINCT department_id 
FROM employees 
ORDER BY department_id DESC;

SELECT DISTINCT department_id, NVL(department_id, -1)
FROM employees 
ORDER BY department_id DESC;

-------------- PRUEBA MIA
SELECT first_name, department_id
FROM employees
ORDER BY 1 DESC, 2 DESC;

SELECT first_name, department_id
FROM employees
ORDER BY 1 DESC, 2 ASC;

-----------------------
-- EJ 5) 
SELECT manager_id, last_name, job_id
FROM employees
WHERE job_id NOT IN ('SA_REP', 'AD_VP') AND last_name LIKE 'K%' AND manager_id <=100 
ORDER BY manager_id DESC, last_name ASC;


SELECT manager_id, last_name, job_id
FROM employees
WHERE job_id NOT IN ('SA_REP', 'AD_VP') AND (last_name LIKE 'K%' OR manager_id <=100 )
ORDER BY manager_id DESC, last_name ASC;

------------------------
-- WHERE con alias no funca
/*
SELECT department_id depto
FROM employees
WHERE depto =1;  */
-- ESTE SI FUNCA 
SELECT department_id depto
FROM employees
ORDER BY depto;


-- EJ 6)
-- ALIAS con having NO FUNCA
/*
SELECT COUNT(department_id) cantidad, department_id 
FROM employees
WHERE department_id >= 40
GROUP BY department_id 
HAVING cantidad >=2
ORDER BY cantidad; */ 

SELECT COUNT(*) cantidad, department_id 
FROM employees
WHERE department_id >= 40 AND department_id IS NOT NULL
GROUP BY department_id 
HAVING COUNT(*) >=2
ORDER BY COUNT(*) DESC;

SELECT COUNT(*)
FROM employees 
GROUP BY department_id;

SELECT COUNT(department_id)
FROM employees 
GROUP BY department_id;

-- EJ 7)
SELECT COUNT(*), c.country_name
FROM locations l
LEFT OUTER JOIN countries c
ON l.country_id = c.country_id
GROUP BY c.country_name;
-- EJ 8)
SELECT AVG(salary) promedio, MAX(salary) maximo, MIN(salary) minimo, department_id
FROM employees
WHERE department_id IN (30, 100)
GROUP BY department_id;

update employees set salary=null
where employee_id in (114,115);
commit;

SELECT AVG(salary) promedio, MAX(salary) maximo, MIN(salary) minimo, department_id
FROM employees
WHERE department_id IN (30, 100)
GROUP BY department_id;

ALTER TABLE HR.EMPLOYEES MODIFY CONSTRAINT EMP_SALARY_MIN DISABLE VALIDATE;

update employees set salary=0
where employee_id in (114,115);
commit;



