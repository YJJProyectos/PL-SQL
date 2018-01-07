--- INDICE 
CREATE INDEX price_idx
    ON arts(precio);
    
EXECUTE SP_ALTA_DEPTO_V2('Depto Nuevo');
EXECUTE SP_ALTA_DEPTO(71, 'Depto 71');

SELECT department_name
FROM departments;

-- GUIA 1 
-- ej 9
SELECT MIN(salary), MAX(salary), MAX(salary) - MIN(salary) DIFFERENCE
FROM employees
GROUP BY job_id;
-- ej 10
SELECT j.job_title, SUM(e.salary)
FROM employees e
LEFT OUTER JOIN jobs j
ON e.job_id = j.job_id
WHERE e.job_id NOT LIKE '%REP%'
GROUP BY j.job_title
HAVING SUM(salary) >= 13000
ORDER BY SUM(e.salary) DESC;
-- ej 11
SELECT first_name, COUNT(*)
FROM employees
GROUP BY first_name
HAVING COUNT(*) > 1;
-- ej 12
    (SELECT AVG(salary) average
    FROM employees
    GROUP BY department_id);
    
SELECT MAX(average)
FROM
    (SELECT AVG(salary) average
    FROM employees
    GROUP BY department_id);
    


-- GUIA 2

--1)-Hacer una consulta que muestre nombre y apellido de empleado, nombre del departamento y id de locación para los empleados 
--cuyo manager sea el empleado con identificador 149.
SELECT e.first_name, e.last_name, d.department_id, l.location_id
FROM employees e
LEFT OUTER JOIN departments d
ON e.department_id = d.department_id
LEFT OUTER JOIN locations l
ON d.location_id = l.location_id
WHERE e.manager_id = 149;

-- 2)-Hacer una consulta que muestre nombre y apellido del empleado, el nombre del departamento 
--y la ciudad en donde se encuentra el departamento al cual pertenece para todos los empleados.

SELECT e.first_name, e.last_name, d.department_name, l.city
FROM employees e
LEFT OUTER JOIN departments d
ON e.department_id = d.department_id
LEFT OUTER JOIN locations l
ON d.location_id = l.location_id;

-- 3)-Escriba una consulta que muestre el apellido del empleado, nombre del departamento, identificador de la localización 
--y ciudad de todos los empleados que cobren comisión y que el país en el cual se encuentra el departamento sea ‘UK’.  
SELECT e.last_name, d.department_name, l.location_id, l.city
FROM employees e
LEFT OUTER JOIN departments d
ON e.department_id = d.department_id
LEFT OUTER JOIN locations l
ON d.location_id = l.location_id
WHERE e.commission_pct IS NOT NULL AND l.country_id = 'UK';
