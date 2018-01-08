exec PKG_ADM_EMPLOYEES.PRC_INSERTAR(100);

exec pkg_adm_employees.prc_mostrar_result;

DELETE FROM MI_EMPLOYEES;

SELECT manager_id, first_name || ' ' || last_name FROM employees WHERE manager_id = 100;
SELECT MOD(15,2) FROM DUAL;