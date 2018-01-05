/*SELECT employees.first_name, employees.last_name, employees.salary, employees.salary + 300 
FROM employees 
WHERE salary > 14000; */

/* SELECT last_name, 12*salary*commission_pct, commission_pct
FROM employees;*/

/*SELECT last_name, salary, NVL(commission_pct, 0),
(salary*12) + (salary*12*NVL(commission_pct, 0)) AN_SAL
FROM employees; */
/*SELECT DISTINCT department_id
FROM employees; */

-- salarios de 17000
SELECT last_name, first_name
FROM employees
WHERE salary = 17000;
--salarios diferente de 17000
SELECT last_name, first_name
FROM employees
WHERE salary <> 17000;
-- salario entre 9000 y 24000
SELECT last_name, first_name
FROM employees
WHERE salary BETWEEN 9000 AND 24000;
-- Salario de 6000 o 8000 o 9000
SELECT last_name, first_name, salary
FROM employees
WHERE salary IN (6000, 8000, 9000);
-- Personas con department_id Nulo
SELECT last_name, first_name
FROM employees
WHERE department_id IS NULL;
-- Apellidos con King
SELECT last_name, first_name
FROM employees
WHERE last_name = 'King';
-- Nombres que empiezan con D
SELECT last_name, first_name
FROM employees
WHERE first_name LIKE 'D%';
            