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

UPDATE employees 
SET hire_date = current_date
WHERE employee_id = 100;
COMMIT;

SELECT first_name, last_name, employee_id, hire_date
FROM employees
WHERE employee_id = 100;


SELECT first_name, last_name, hire_date
FROM employees
WHERE TO_DATE(hire_date) = TO_DATE(current_date);


SELECT pepe.first_name, pepe.last_name, pepe.salary 
FROM (SELECT first_name, last_name, salary
FROM employees
WHERE salary > ( SELECT AVG(salary)
                FROM employees ) ) pepe
WHERE first_name LIKE 'S%';

-- 2da parte, transacciones
INSERT INTO departments(department_id, department_name, manager_id, location_id)
VALUES (71, 'Public Relations', 100, 1700);

-- 1) El mismo insert pero no le pasan las columnas  con otro id
-- 2) Exactamente al anterior pero poner id nada mas, el manager id, depto id
-- 3) 
-- 1)
-- Prueba de errores de INSERT 
INSERT INTO departments
VALUES (72, 'Public Relations', 100, 1700);

INSERT INTO departments(department_id, department_name, manager_id, location_id)
VALUES (71, 'Public Relations', 100);

INSERT INTO departments(department_id, department_name)
VALUES (73, 'Public Relations');

INSERT INTO departments(department_id, manager_id, location_id)
VALUES (74, 300, 1400);

INSERT INTO departments(department_id, department_name, manager_id, location_id)
VALUES (75, 'Public Relations', null, null);

INSERT INTO departments(department_id, department_name, manager_id, location_id)
VALUES (76, 'Public Relations', 9500, 1700);

-- actualizar nombre depto, al depto con id 71
UPDATE departments
SET department_name = 'Nuevo'
WHERE department_id = 71;

DELETE FROM departments 
WHERE department_id = 71;

SELECT department_name, department_id
FROM departments
WHERE department_id = 71;

-- actualizarle el salario a todos los empleados un 10%
UPDATE employees
SET salary = salary * 1.10;

SELECT salary
FROM employees;

-- delete borra registros, no columnas
DELETE FROM departments;

CREATE TABLE articulos( articulo_id NUMBER(8) NOT NULL PRIMARY KEY, descripcion VARCHAR(200), precio NUMBER(8,2));

INSERT INTO articulos(articulo_id, descripcion, precio)
VALUES (1,'Primer Articulo', 100);

SELECT articulo_id, descripcion, precio 
FROM articulos;

CREATE SEQUENCE articulos_mas
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    NOCACHE;

INSERT INTO articulos(articulo_id, descripcion, precio)
VALUES (articulos_mas.NEXTVAL, 'Segundo producto', 200);

INSERT INTO articulos(articulo_id, descripcion, precio)
VALUES (articulos_mas.NEXTVAL, 'Tercer producto', 300);
Commit;