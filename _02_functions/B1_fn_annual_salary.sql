-- =====================================================================
-- 02_functions/B1_fn_annual_salary.sql
-- B1 - Annual Salary function
--
-- fn_annual_salary(p_monthly_salary) -> 12 * p_monthly_salary
-- Pure function: no SQL, no side effects, so it can safely be called
-- from SQL statements (see 03_tests/B5_functions_in_select.sql).
-- =====================================================================

CREATE OR REPLACE FUNCTION fn_annual_salary (
  p_monthly_salary IN NUMBER
) RETURN NUMBER IS
BEGIN
  IF p_monthly_salary IS NULL OR p_monthly_salary < 0 THEN
    RAISE_APPLICATION_ERROR(-20001,
      'Monthly salary must be a non-negative number.');
  END IF;

  RETURN ROUND(p_monthly_salary * 12, 2);
END fn_annual_salary;
/

-- Quick smoke test
SET SERVEROUTPUT ON
BEGIN
  DBMS_OUTPUT.PUT_LINE('Annual salary for 3,000/month: ' ||
                       fn_annual_salary(3000));
END;
/