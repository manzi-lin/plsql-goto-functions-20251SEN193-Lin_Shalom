-- =====================================================================
-- 01_goto/A2_salary_review.sql
-- A2 - Salary Review (GOTO)
--
-- Walks through every employee and uses GOTO labels to route each
-- employee to one of three report sections:
--   * below the review threshold -> [REVIEW REQUIRED]
--   * above the top-tier limit   -> [TOP TIER]
--   * everything else            -> [OK]
-- All labels sit in the same block scope as the GOTOs that target
-- them, so every jump is legal.
-- =====================================================================

SET SERVEROUTPUT ON

DECLARE
  CURSOR emp_cur IS
    SELECT employee_id, first_name, last_name, salary
      FROM employees
     ORDER BY employee_id;

  c_review_threshold CONSTANT NUMBER := 300000;   -- below this = review
  c_top_tier         CONSTANT NUMBER := 1000000;  -- above this = top tier

  v_review_count PLS_INTEGER := 0;
  v_ok_count     PLS_INTEGER := 0;
  v_top_count    PLS_INTEGER := 0;
BEGIN
  DBMS_OUTPUT.PUT_LINE('==================================================');
  DBMS_OUTPUT.PUT_LINE(' SALARY REVIEW REPORT  (run on ' ||
                       TO_CHAR(SYSDATE, 'DD-MON-YYYY') || ')');
  DBMS_OUTPUT.PUT_LINE(' Review threshold: ' || c_review_threshold ||
                       '   Top-tier limit: ' || c_top_tier);
  DBMS_OUTPUT.PUT_LINE('==================================================');

  FOR rec IN emp_cur LOOP
    IF rec.salary < c_review_threshold THEN
      GOTO needs_review;
    ELSIF rec.salary > c_top_tier THEN
      GOTO top_tier;
    ELSE
      GOTO acceptable;
    END IF;

    <<needs_review>>
    v_review_count := v_review_count + 1;
    DBMS_OUTPUT.PUT_LINE('[REVIEW REQUIRED] ' || rec.employee_id || ' - ' ||
      rec.first_name || ' ' || rec.last_name || ' earns ' ||
      TO_CHAR(rec.salary, 'FM999,999,999.00') || ' (below threshold)');
    GOTO next_employee;

    <<top_tier>>
    v_top_count := v_top_count + 1;
    DBMS_OUTPUT.PUT_LINE('[TOP TIER]        ' || rec.employee_id || ' - ' ||
      rec.first_name || ' ' || rec.last_name || ' earns ' ||
      TO_CHAR(rec.salary, 'FM999,999,999.00'));
    GOTO next_employee;

    <<acceptable>>
    v_ok_count := v_ok_count + 1;
    DBMS_OUTPUT.PUT_LINE('[OK]              ' || rec.employee_id || ' - ' ||
      rec.first_name || ' ' || rec.last_name || ' earns ' ||
      TO_CHAR(rec.salary, 'FM999,999,999.00'));
    GOTO next_employee;

    <<next_employee>>
    NULL;
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('==================================================');
  DBMS_OUTPUT.PUT_LINE(' Summary: ' || v_review_count || ' need review, ' ||
                       v_ok_count || ' are OK, ' || v_top_count || ' are top tier.');
END;
/