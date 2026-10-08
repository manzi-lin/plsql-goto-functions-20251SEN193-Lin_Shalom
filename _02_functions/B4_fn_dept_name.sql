-- =====================================================================
-- 02_functions/B4_fn_dept_name.sql
-- B4 - Department Name function
--
-- fn_dept_name(p_department_id) -> departments.department_name
-- Raises a friendly application error when the department is unknown.
-- =====================================================================

CREATE OR REPLACE FUNCTION fn_dept_name (
  p_department_id IN NUMBER
) RETURN VARCHAR2 IS
  v_name departments.department_name%TYPE;
BEGIN
  SELECT department_name
    INTO v_name
    FROM departments
   WHERE department_id = p_department_id;

  RETURN v_name;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20004,
      'Department ' || p_department_id || ' does not exist.');
END fn_dept_name;
/

-- Quick smoke test (including the exception path)
SET SERVEROUTPUT ON
DECLARE
  v_name VARCHAR2(50);
BEGIN
  DBMS_OUTPUT.PUT_LINE('Department 20: ' || fn_dept_name(20));

  BEGIN
    v_name := fn_dept_name(999);
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Unknown department -> ' || SQLERRM);
  END;
END;
/