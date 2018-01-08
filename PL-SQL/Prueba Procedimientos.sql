exec PKG_ADM_EMPLOYEES.PRC_INSERTAR(100);

DELETE FROM MI_EMPLOYEES;

SELECT manager_id, first_name || ' ' || last_name FROM employees WHERE manager_id = 100;