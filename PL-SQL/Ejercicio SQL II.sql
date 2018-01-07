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
--4)- Listar los nombres y apellidos de los empleados y el nombre y apellido de su manager. El nombre tiene que estar separado del apellido por ' ' 
--y debe ponerse la leyenda 'es empleado de' para que quede de la siguiente forma:
-- Neena Kochhar es empleado de Steven King. 
--Tener en cuenta que la información está toda en la misma tabla de empleados por lo tanto hay que hacer un join con ella misma.

-- Para conectar multiples Strings o varchar se usa || , o se podria hacer con muchos CONCAT
SELECT e.FIRST_NAME || ' ' || e.LAST_NAME || ' es empleado de ' || manager.FIRST_NAME || ' ' || manager.LAST_NAME
FROM employees e
JOIN employees manager
ON e.manager_id = manager.employee_id;

--5)- Listar el nombre de la ciudad y el departamento incluyendo las ciudades que no tienen departamentos.
SELECT d.DEPARTMENT_NAME, l.CITY, d.DEPARTMENT_ID
FROM departments d
RIGHT OUTER JOIN locations l
ON d.location_id = l.location_id;

--6)- Utilizando el query del punto 4 incluír en la lista aquellos empleados que  no tienen jefe.
SELECT e.FIRST_NAME || ' ' || e.LAST_NAME || ' es empleado de ' || manager.FIRST_NAME || ' ' || manager.LAST_NAME
FROM employees e
LEFT OUTER JOIN employees manager
ON e.manager_id = manager.employee_id;


SELECT e.FIRST_NAME || ' ' || e.LAST_NAME || ' es empleado de ' || manager.FIRST_NAME || ' ' || manager.LAST_NAME
FROM employees e,employees manager
WHERE (e.manager_id = manager.employee_id (+));

--7)-Elabora una consulta que despliegue el nombre y el apellido del empleado,la fecha de contratación , 
--la fecha de la primer revisión salarial que fue a los seis meses de haber sido contratado, su primer día  viernes en la empresa para los empleados del departamento de Marketing.
SELECT first_name,last_name, hire_date,ADD_MONTHS(hire_date, 6) REVISION, NEXT_DAY (hire_date, 'FRIDAY'), LAST_DAY (hire_date),
EXTRACT ( DAY FROM hire_date), TO_CHAR(hire_date, 'DAY'), TO_CHAR(hire_date, 'DY'), TO_CHAR(hire_date, 'Dy')
FROM employees e,departments d
WHERE department_name='Marketing'
AND e.department_id=d.department_id;

--8)-Buscar los apellidos, salario de los empleados, nombre del departamento para aquellos que ganan un salario igual al salario mínimo para cada departamento. 
--Resolverlo de dos formas posibles utilizando el operador ANY y utilizando el operador IN.
SELECT e.first_name, e.last_name, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.salary IN ( SELECT MIN(salary)
                    FROM employees
                    GROUP BY department_id )
AND e.department_id = d.department_id
ORDER BY d.department_name;

SELECT e.first_name, e.last_name, e.department_id, d.department_name
FROM employees e, departments d
WHERE e.salary = ANY ( SELECT MIN(salary)
                    FROM employees
                    GROUP BY department_id )
AND e.department_id = d.department_id
ORDER BY d.department_name;

--10)-Escribir una consulta que muestre id de empleado, apellido, id de job y salario para los empleados que tengan el salario 
-- mayor a TODOS los empleados que tengan el puesto 'IT_PROG'. Excluír aquellos empleados que tengan el puesto 'IT_PROG'. 
-- Si alguno mayor a 4200 ( que seria el menor ) 
SELECT e.employee_id, e.last_name, e.job_id, e.salary
FROM employees e
WHERE e.salary > ANY ( SELECT salary
                    FROM employees
                    WHERE UPPER(job_id) = 'IT_PROG')
AND UPPER(e.job_id) != 'IT_PROG'
ORDER BY e.salary DESC;

-- ACA todos tienen que ser mayores a 9000
SELECT e.employee_id, e.last_name, e.job_id, e.salary
FROM employees e
WHERE e.salary > ALL ( SELECT salary
                    FROM employees
                    WHERE UPPER(job_id) = 'IT_PROG')
AND UPPER(e.job_id) != 'IT_PROG'
ORDER BY e.salary DESC;


SELECT salary
FROM employees
WHERE UPPER(job_id) = 'IT_PROG';

--11)-Escribir una consulta que cuente la cantidad de departamentos agrupados por país, pero sólo para aquellos países que pertenezcan a la región ‘America’ y ‘Europe’. 
SELECT l.country_id, COUNT(*)
FROM departments d, locations l
WHERE d.LOCATION_ID = l.LOCATION_ID 
AND l.country_id IN ( SELECT c.country_id
                    FROM countries c , regions r
                    WHERE c.region_id = r.region_id 
                    AND r.REGION_NAME IN ('Americas', 'Europe') )
GROUP BY l.country_id
ORDER BY l.country_id DESC;

-- 12)-Elabora una consulta que despliegue el apellido del empleado, número de departamento y todos los empleados que trabajen en el mismo departamento es decir los colegas.
--Realizar la consulta para los departamentos 20 y 60. Etiquetar las columnas con los nombres adecuados. 
SELECT e.last_name apellido, e.department_id
FROM employees
WHERE e.department_id IN (20, 60);

SELECT last_name, department_id
FROM employees
WHERE department_id IN (20, 60);

SELECT e.last_name apellido, e.department_id dpto_nro, colega.last_name colega
FROM employees e 
INNER JOIN employees colega
ON e.department_id = colega.department_id
WHERE e.department_id IN (20, 60)
AND e.last_name != colega.last_name;

select e.LAST_NAME,e.DEPARTMENT_ID,e1.LAST_NAME Colega
from employees e, employees e1
where e.DEPARTMENT_ID IN (20,60) 
and  e.EMPLOYEE_ID != e1.EMPLOYEE_ID
and  e.DEPARTMENT_ID = e1.DEPARTMENT_ID
order by 2 asc;

select e.last_name "Apellido", e.department_id "Nro de depto", m.last_name "Colegas"
from employees e right join employees m
on e.department_id = m.department_id
where e.department_id in(20, 60) AND e.last_name not in(m.last_name);
------------------
    
            
