-- =====================================================================
-- 03_tests/test_functions.sql
-- Manual test script for the Part B functions (B1-B4).
-- Prerequisites: 00_setup/create_tables.sql and all of 02_functions/.
-- =====================================================================

SET SERVEROUTPUT ON

DECLARE
  v_num  NUMBER;
  v_text VARCHAR2(100);

  PROCEDURE expect_equal(p_label VARCHAR2, p_actual NUMBER, p_expected NUMBER) IS
  BEGIN
    IF p_actual = p_expected THEN
      DBMS_OUTPUT.PUT_LINE('[PASS] ' || p_label || ' -> ' || p_actual);
    ELSE
      DBMS_OUTPUT.PUT_LINE('[FAIL] ' || p_label || ' -> got ' || p_actual ||
                           ', expected ' || p_expected);
    END IF;
  END;
BEGIN
  DBMS_OUTPUT.PUT_LINE('--- B1: fn_annual_salary ---');
  expect_equal('B1 annual(3000)', fn_annual_salary(3000), 36000);
  expect_equal('B1 annual(0)',    fn_annual_salary(0),    0);

  DBMS_OUTPUT.PUT_LINE('--- B2: fn_years_of_service ---');
  -- Employee 1003 was hired on 2012-01-09, so at least 10 years by 2026.
  DBMS_OUTPUT.PUT_LINE('B2 employee 1003 -> ' ||
                       fn_years_of_service(1003) || ' years');
  BEGIN
    v_num := fn_years_of_service(9999);
    DBMS_OUTPUT.PUT_LINE('[FAIL] B2 unknown employee should have raised an error');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('[PASS] B2 unknown employee -> ' || SQLERRM);
  END;

  DBMS_OUTPUT.PUT_LINE('--- B3: fn_calculate_tax (boundary tests) ---');
  expect_equal('B3 tax( 50000)', fn_calculate_tax( 50000),     0);
  expect_equal('B3 tax( 60000)', fn_calculate_tax( 60000),     0);
  expect_equal('B3 tax( 80000)', fn_calculate_tax( 80000),  2000);
  expect_equal('B3 tax(100000)', fn_calculate_tax(100000),  4000);
  expect_equal('B3 tax(150000)', fn_calculate_tax(150000), 19000);
  BEGIN
    v_num := fn_calculate_tax(-5);
    DBMS_OUTPUT.PUT_LINE('[FAIL] B3 negative salary should have raised an error');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('[PASS] B3 negative salary -> ' || SQLERRM);
  END;

  DBMS_OUTPUT.PUT_LINE('--- B4: fn_dept_name ---');
  v_text := fn_dept_name(20);
  IF v_text = 'IT' THEN
    DBMS_OUTPUT.PUT_LINE('[PASS] B4 dept 20 -> ' || v_text);
  ELSE
    DBMS_OUTPUT.PUT_LINE('[FAIL] B4 dept 20 -> ' || v_text);
  END IF;
  BEGIN
    v_text := fn_dept_name(999);
    DBMS_OUTPUT.PUT_LINE('[FAIL] B4 unknown department should have raised an error');
  EXCEPTION
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('[PASS] B4 unknown department -> ' || SQLERRM);
  END;
END;
/