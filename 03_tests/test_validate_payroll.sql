-- =====================================================================
-- 03_tests/test_validate_payroll.sql  (v2 - matches new salary scale)
-- =====================================================================

SET SERVEROUTPUT ON

DECLARE
  v_result VARCHAR2(200);

  PROCEDURE check_result(p_label VARCHAR2, p_result VARCHAR2, p_expect_valid BOOLEAN) IS
  BEGIN
    IF (p_expect_valid AND p_result LIKE 'VALID%') OR
       (NOT p_expect_valid AND p_result LIKE 'INVALID%') THEN
      DBMS_OUTPUT.PUT_LINE('[PASS] ' || p_label || ' -> ' || p_result);
    ELSE
      DBMS_OUTPUT.PUT_LINE('[FAIL] ' || p_label || ' -> ' || p_result);
    END IF;
  END;
BEGIN
  check_result('T1 valid payroll',          fn_validate_payroll(1001, 250000,  40000), TRUE);
  check_result('T2 unknown employee',       fn_validate_payroll(9999, 250000,  40000), FALSE);
  check_result('T3 zero gross salary',      fn_validate_payroll(1001,      0,  40000), FALSE);
  check_result('T4 negative gross salary',  fn_validate_payroll(1001,   -100,      0), FALSE);
  check_result('T5 negative deductions',    fn_validate_payroll(1001, 250000,    -50), FALSE);
  check_result('T6 deductions = gross',     fn_validate_payroll(1001, 250000, 250000), FALSE);
  check_result('T7 deductions > gross',     fn_validate_payroll(1001, 250000, 300000), FALSE);

  v_result := fn_validate_payroll(1002, 850000, 229000);
  IF v_result LIKE 'VALID%' THEN
    DELETE FROM payrolls WHERE payroll_id = 5001;
    INSERT INTO payrolls
      VALUES (5001, 1002, TRUNC(SYSDATE,'MM'), 850000, 229000, 621000, 'VALIDATED');
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('[PASS] T8 validated payroll stored -> ' || v_result);
  ELSE
    DBMS_OUTPUT.PUT_LINE('[FAIL] T8 validator rejected a good payroll -> ' || v_result);
  END IF;
END;
/