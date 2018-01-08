SELECT MIN(hire_date)
FROM employees;
-- ej 2
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '01-JAN-01' AND '10-MAR-06';

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN DATE '2001-01-01' AND DATE '2006-03-10';
-- 1)-El empleado ‘Luis Popp’  pasa a trabajar al departamento  ‘Purchasing’.
--Se necesita actualizar el sueldo y el departamento de Popp con los mismos valores de sueldo que el empleado  que ingresó primero al departamento. 
SELECT first_name, last_name, department_id 
FROM employees
WHERE first_name = 'Luis' AND last_name = 'Popp';

UPDATE employees
SET department_id = ( SELECT department_id 
                    FROM departments
                    WHERE department_name = 'Purchasing')
    ,salary = ( SELECT salary
                FROM employees
                WHERE hire_date = (SELECT MIN(e.hire_date)
                                    FROM employees e, departments d
                                    WHERE e.department_id = d.department_id
                                    AND d.department_name = 'Purchasing') 
            )
WHERE first_name = 'Luis' AND last_name = 'Popp';

UPDATE employees 
SET (department_id,salary)= (SELECT department_id,salary
FROM employees
WHERE hire_date = (SELECT MIN (hire_date) 
                   FROM employees e, departments d
                   WHERE e.DEPARTMENT_ID=d.DEPARTMENT_ID
                   AND   d.DEPARTMENT_NAME='Purchasing'))
WHERE first_name='Luis'
And last_name='Popp';
-- 2)- Insertar un registro en la tabla Locations con los siguientes valores:
-- 		LOCATION_ID ? 9999
--		STREET_ADDRESS ?'Manuela Pedraza'
--    POSTAL_CODE?1429
-- CITY,STATE_PROVINCE ?'Buenos Aires'
--COUNTRY_ID ? ‘AR’
INSERT INTO locations(location_id, street_address, postal_code, city, state_province, country_id)
VALUES (9999, 'Manuela Pedraza', 1429, 'Buenos Aires',' Buenos Aires', 'AR');

commit;
-- 3)- Modificar la tabla Departments para que el location_id del departamento Purchasing sea el del registro que insertamos en el punto anterior. 
--No olvidar hacer commit para los cambios.
UPDATE departments
SET location_id = 9999
WHERE department_name = 'Purchasing';
commit;

-- 4)- La empresa cerrará los departamentos del país cuyo id es ‘AR’ entonces hay que eliminar los empleados que pertenezcan al departamento del país ‘AR’ 
--y el registro correspondiente en la tabla Departments.Para obtener el id del departamento de los registros a borrar hacer una subconsulta utilizando como dato
-- que el país es ‘AR’ (hacer el join entre las tablas que corresponda para obtener el dato). 
--1-Modifico el valor de manager_id a null y luego procedo a borrar los registros de la tabla empleados  
update departments set manager_id =null, location_id = null
where department_id in 
(select   department_id 
from countries c, locations l, departments d
where c.COUNTRY_ID='AR'
and c.COUNTRY_ID    =l.COUNTRY_ID
and d.LOCATION_ID   =l.LOCATION_ID);
--2-Hago el delete de la tabla job_history porque hay una constraint referencial con la tabla de empleados 
delete from job_history where employee_id in
(select employee_id from employees where department_id in (
(select   department_id 
from countries c, locations l, departments d
where c.COUNTRY_ID='AR'
and c.COUNTRY_ID    =l.COUNTRY_ID
and d.LOCATION_ID   =l.LOCATION_ID)));


delete from departments where department_id =
(select   department_id 
from countries c, locations l, departments d
where c.COUNTRY_ID='AR'
and c.COUNTRY_ID    =l.COUNTRY_ID
and d.LOCATION_ID   =l.LOCATION_ID);

delete from employees e where e.department_id =(
select   department_id 
from countries c, locations l, departments d
where c.COUNTRY_ID='AR'
and c.COUNTRY_ID    =l.COUNTRY_ID
and d.LOCATION_ID   =l.LOCATION_ID);


select   department_id 
from countries c, locations l, departments d
where c.COUNTRY_ID='AR'
and c.COUNTRY_ID    =l.COUNTRY_ID
and d.LOCATION_ID   =l.LOCATION_ID;

select * from departments where department_id=30;


(select employee_id, department_id from employees where department_id in (
(select   department_id 
from countries c, locations l, departments d
where c.COUNTRY_ID='AR'
and c.COUNTRY_ID    =l.COUNTRY_ID
and d.LOCATION_ID   =l.LOCATION_ID)));

SELECT employee_id FROM job_history WHERE employee_id IN (select employee_id from employees where department_id in (
(select   department_id 
from countries c, locations l, departments d
where c.COUNTRY_ID='AR'
and c.COUNTRY_ID    =l.COUNTRY_ID
and d.LOCATION_ID   =l.LOCATION_ID)));

-- 5)-Insertar en la tabla Departments registros con las siguientes características:
-- Id de departamento sea el id de la tabla original + 100, el nombre del departamento sea el nombre del departamento original concatenado con el id de país al que pertenece,
--las columnas de manager_id y de locations id mantengan el valor de la tabla original.

INSERT INTO departments (SELECT d.department_id + 300, d.department_name || ' ' || l.country_id, d.manager_id, d.location_id 
                        FROM departments d, locations l 
                        WHERE D.location_id = L.location_id);
(SELECT d.department_id + 300, d.department_name || ' ' || l.country_id, d.manager_id, d.location_id 
                        FROM departments d, locations l 
                        WHERE D.location_id = L.location_id);
-- 6)- Modificar el número de departamento  de los empleados que ingresaron el 17 de agosto de 1997. El nuevo departamento a asignarle será el que mayor cantidad de empleados tiene.

UPDATE employees
SET department_id = ( 
    SELECT department_id FROM (SELECT department_id, COUNT(*)
                             FROM employees
                             GROUP BY department_id
                             ORDER BY 2 DESC) 
    WHERE ROWNUM = 1
)
WHERE EXTRACT(YEAR FROM hire_date) = 1997;

SELECT DISTINCT( EXTRACT(YEAR FROM hire_date)) FROM employees;

SELECT department_id FROM (SELECT department_id, COUNT(*)
FROM employees
GROUP BY department_id
ORDER BY 2 DESC) 
WHERE ROWNUM = 1;
