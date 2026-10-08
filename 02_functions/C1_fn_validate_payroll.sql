-- =====================================================================
-- 02_functions/C1_fn_validate_payroll.sql
-- C1 - Payroll Validator (Combined Task)
--
-- Combines Part A (the GOTO guard-clause pattern) with Part B (a
-- stored function). Each business rule that fails jumps to its own
-- failure label; if every rule passes, the function returns a VALID
-- message together with the computed net salary.
--
-- Business rules:
--   1. The employee must exist in the employees table.
--   2. Gross salary must be greater than zero.
--   3. Deductions cannot be negative.
--   4. Deductions must be less than gross salary.
-- =====================================================================

CREATE OR REPLACE FUNCTION fn_validate_payroll (
  p_employee_id  IN NUMBER,
  p_gross_salary IN NUMBER,
  p_deductions   IN NUMBER
) RETURN VARCHAR2 IS
  v_emp_count PLS_INTEGER := 0;
  v_result    VARCHAR2(200);
BEGIN
  -- Rule 1: employee must exist
  SELECT COUNT(*)
    INTO v_emp_count
    FROM employees
   WHERE employee_id = p_employee_id;

  IF v_emp_count = 0 THEN
    GOTO invalid_employee;
  END IF;

  -- Rule 2: gross salary must be positive
  IF p_gross_salary IS NULL OR p_gross_salary <= 0 THEN
    GOTO invalid_gross;
  END IF;

  -- Rule 3: deductions cannot be negative
  IF p_deductions IS NULL OR p_deductions < 0 THEN
    GOTO invalid_deduction;
  END IF;

  -- Rule 4: deductions must stay below gross salary
  IF p_deductions >= p_gross_salary THEN
    GOTO invalid_net;
  END IF;

  GOTO valid;   -- every rule passed

  <<invalid_employee>>
  v_result := 'INVALID: employee ' || p_employee_id || ' does not exist';
  GOTO finish;

  <<invalid_gross>>
  v_result := 'INVALID: gross salary must be greater than zero';
  GOTO finish;

  <<invalid_deduction>>
  v_result := 'INVALID: deductions cannot be negative';
  GOTO finish;

  <<invalid_net>>
  v_result := 'INVALID: deductions (' || p_deductions ||
              ') must be less than gross salary (' || p_gross_salary || ')';
  GOTO finish;

  <<valid>>
  v_result := 'VALID: net salary = ' ||
              TO_CHAR(p_gross_salary - p_deductions, 'FM999,999.00');

  <<finish>>
  RETURN v_result;
END fn_validate_payroll;
/