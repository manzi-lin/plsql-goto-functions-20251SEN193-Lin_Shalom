-- =====================================================================
-- 02_functions/B2_fn_years_of_service.sql
-- B2 - Years of Service function
--
-- fn_years_of_service(p_employee_id) -> whole years between the
-- employee's hire_date and today.
-- Demonstrates SQL inside a function and NO_DATA_FOUND handling.
-- =====================================================================

CREATE OR REPLACE FUNCTION fn_years_of_service (
  p_employee_id IN NUMBER
) RETURN NUMBER IS
  v_hire_date employees.hire_date%TYPE;
BEGIN
  SELECT hire_date
    INTO v_hire_date
    FROM employees
   WHERE employee_id = p_employee_id;

  RETURN FLOOR(MONTHS_BETWEEN(TRUNC(SYSDATE), v_hire_date) / 12);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20002,
      'Employee ' || p_employee_id || ' does not exist.');
END fn_years_of_service;
/

-- Quick smoke test
SET SERVEROUTPUT ON
BEGIN
  DBMS_OUTPUT.PUT_LINE('Employee 1003 has ' ||
                       fn_years_of_service(1003) || ' year(s) of service.');
END;
/