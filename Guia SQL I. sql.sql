-- Clase 3
-- ej 1
SELECT first_name, last_name, salary
FROM employees;
-- ej 2
SELECT AVG(salary)
FROM employees;
-- ej 3
SELECT first_name, last_name, salary
FROM employees
WHERE salary > ( SELECT AVG(salary)
                FROM employees );
                
SELECT MIN(salary)
FROM employees
GROUP BY department_id;
---
SELECT employee_id, last_name, salary
FROM employees
WHERE salary IN
            (SELECT MIN(salary)
            FROM employees
            GROUP BY department_id);
--- subconsulta en el from
SELECT employee_id, salary
FROM ( SELECT *
     FROM employees
     WHERE salary > 10000);

SELECT employee_id, last_name, salary
FROM employees
WHERE salary = ANY
            (SELECT MIN(salary)
            FROM employees
            GROUP BY department_id);
/*            
SELECT employee_id, last_name, salary
FROM employees
WHERE salary = ALL
            (SELECT MIN(salary)
            FROM employees
            GROUP BY department_id);
*/

SELECT * FROM dual;
SELECT ROUND(45.923, 2), ROUND(45.923, -1), ROUND(45.923, 0) FROM dual;

SELECT ROUND(AVG(salary), 0)
FROM employees;

SELECT UPPER(first_name), UPPER(last_name)
FROM employees;

SELECT LOWER(first_name), LOWER(last_name)
FROM employees;

SELECT INITCAP(first_name), INITCAP(last_name)
FROM employees;

SELECT first_name, last_name
FROM employees
WHERE LENGTH(first_name) = 3;

SELECT first_name, last_name
FROM employees
WHERE first_name LIKE '___';

SELECT CONCAT('Hello','World') FROM DUAL;
SELECT current_timestamp FROM dual;

SELECT current_date FROM dual; 


SELECT hire_date
FROM employees;
-- ej 1
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date = '17-JUN-03';

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date = TO_DATE('2003/06/17', 'yyyy/mm/dd');
-- ej 2
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '01-JAN-01' AND '10-MAR-06';

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date >= '01-JAN-01' AND hire_date <= '10-MAR-06';

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date = DATE '2003-06-17';

-- ej 3
SELECT first_name, last_name, hire_date, EXTRACT(YEAR FROM hire_date)
FROM employees;

-- ej 4
SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 2002;
-- ej 5
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date = current_date;