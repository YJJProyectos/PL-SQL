CREATE TABLE MI_EMPLOYEES( employee_id number(9) NOT NULL, id_manager number(9), salary number(9), leyenda VARCHAR2(20),
                CONSTRAINT EMP_PK PRIMARY KEY (employee_id) );
                
CREATE SEQUENCE employees_mas
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1
    CACHE 2;

CREATE INDEX emp_idx ON MI_EMPLOYEES(id_manager);
/*
2)	Crear el package PKG_ADM_EMPLOYEES e implementar las siguientes funcionalidades:
a.	PRC_INSERTAR: procedimiento que inserta en MI_EMPLOYEES los empleados de EMPLOYEES cuyo manager_id es el que se recibe como parámetro en este procedimiento. 
Utilizar un cursor para cargar los EMPLOYEES, recorrerlos e insertarlos en MI_EMPLOYEES.
i.	MI_EMPLOYEES.employee_id = EMPLOYEES.employee_id
ii.	MI_EMPLOYEES.manager_id = EMPLOYEES.manager_id
iii.	MI_EMPLOYEES.salary = EMPLOYEES.salary
iv.	MI_EMPLOYEES.leyenda = nombre y apellido de manager || ‘ -> ’ || nombre y apellido de empleado
b.	PRC_MOSTRAR_RESULT
i.	Invoca a función FUN_SUELDO y muestra por consola lo que retorna.
ii.	Invoca a función FUN_ACTUALIZAR_SUELDOS. Solo si su valor de retorno es true continua la ejecución del programa.
iii.	Mostrar por consola todo el contenido de MI_EMPLOYEES
c.	FUN_SUELDO: Función que recorre MI_EMPLOYEES y muestra por consola los empleados cuyo id sea par. 
Se manejará una excepción definida de forma tal que al encontrar un sueldo mayor a 10000 se arroje una excepción y salga de la función. La función retorna la cantidad de empleados que se mostró por consola.
d.	FUN_ACTUALIZAR_SUELDOS: Función que obtiene el sueldo promedio de MI_EMPLOYEES, y actualiza con este el salary para todos los empleados de MI_EMPLOYEES. 
La función devuelve true si todo salió bien o false en caso de algún error. */

CREATE OR REPLACE PACKAGE PKG_ADM_EMPLOYEES 
IS
    PROCEDURE PRC_INSERTAR(manager_id_search VARCHAR2);
    PROCEDURE PRC_MOSTRAR_RESULT;
    FUNCTION FUN_SUELDO RETURN NUMBER; 
    
    
END PKG_ADM_EMPLOYEES;
    
    
CREATE OR REPLACE PACKAGE BODY PKG_ADM_EMPLOYEES
IS
    PROCEDURE PRC_INSERTAR(manager_id_search VARCHAR2)
    IS 
    BEGIN
        FOR employees_take IN ( 
        SELECT e.first_name, e.last_name, e.employee_id, e.manager_id, e.salary, m.first_name m_first_name, m.last_name m_last_name FROM employees e
        LEFT OUTER JOIN employees m
        ON e.manager_id = m.employee_id
        WHERE manager_id_search = e.manager_id)
        
        LOOP 
            INSERT INTO MI_EMPLOYEES(employee_id, id_manager, salary, leyenda)
            VALUES (employees_take.employee_id, employees_take.manager_id, employees_take.salary, employees_take.m_first_name || ' ' || employees_take.first_name );
        END LOOP; 
    END PRC_INSERTAR;  
    PROCEDURE PRC_MOSTRAR_RESULT
    IS 
    BEGIN 
        dbms_output.put_line('Entro a procedimiento'); 
        dbms_output.put_line(TO_CHAR(FUN_SUELDO));         
    END PRC_MOSTRAR_RESULT; 
    
    FUNCTION FUN_SUELDO
    RETURN NUMBER
    IS
        cantidad NUMBER;
    BEGIN
        dbms_output.put_line('Entro funcion');
        FOR empleado IN ( SELECT leyenda, employee_id FROM MI_EMPLOYEES )
        LOOP 
            IF 0 = MOD(empleado.employee_id, 2)
            THEN 
                dbms_output.put_line(empleado.leyenda);
            
            END IF;
        END LOOP; 
        SELECT COUNT(*) INTO CANTIDAD FROM MI_EMPLOYEES;
        RETURN cantidad;
        
    END FUN_SUELDO; 
END PKG_ADM_EMPLOYEES;