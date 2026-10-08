-- =====================================================================
-- 01_goto/A4_rewrite_no_goto.sql
-- A4 - Rewrite Without GOTO
--
-- The GOTO logic from A1 and A2 rewritten with structured control
-- flow (CASE / IF-ELSIF). Same results, but:
--   * the flow reads top-to-bottom with no jumps,
--   * there are no labels to place or misplace,
--   * the compiler verifies every branch is handled.
-- =====================================================================

SET SERVEROUTPUT ON
SET VERIFY OFF

-- ------------------------------------------------------------------
-- Rewrite of A1: number classifier
-- ------------------------------------------------------------------
ACCEPT p_num PROMPT 'Enter a number: '

DECLARE
  v_num NUMBER := &p_num;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Classifying number: ' || v_num);

  CASE
    WHEN v_num < 0 THEN
      DBMS_OUTPUT.PUT_LINE('Result: ' || v_num || ' is NEGATIVE.');
    WHEN v_num = 0 THEN
      DBMS_OUTPUT.PUT_LINE('Result: ' || v_num || ' is ZERO.');
    ELSE
      DBMS_OUTPUT.PUT_LINE('Result: ' || v_num || ' is POSITIVE.');
  END CASE;
END;
/

-- ------------------------------------------------------------------
-- Rewrite of A2: salary review loop (no GOTO, no labels)
-- ------------------------------------------------------------------
DECLARE
  CURSOR emp_cur IS
    SELECT employee_id, first_name, last_name, salary
      FROM employees
     ORDER BY employee_id;

  c_review_threshold CONSTANT NUMBER := 300000;
  c_top_tier         CONSTANT NUMBER := 1000000;

  v_review_count PLS_INTEGER := 0;
  v_ok_count     PLS_INTEGER := 0;
  v_top_count    PLS_INTEGER := 0;

  v_category VARCHAR2(20);
BEGIN
  DBMS_OUTPUT.PUT_LINE('==================================================');
  DBMS_OUTPUT.PUT_LINE(' SALARY REVIEW REPORT (structured rewrite, no GOTO)');
  DBMS_OUTPUT.PUT_LINE('==================================================');

  FOR rec IN emp_cur LOOP
    v_category := CASE
                    WHEN rec.salary < c_review_threshold THEN 'REVIEW REQUIRED'
                    WHEN rec.salary > c_top_tier         THEN 'TOP TIER'
                    ELSE                                      'OK'
                  END;

    IF v_category = 'REVIEW REQUIRED' THEN
      v_review_count := v_review_count + 1;
    ELSIF v_category = 'TOP TIER' THEN
      v_top_count := v_top_count + 1;
    ELSE
      v_ok_count := v_ok_count + 1;
    END IF;

    DBMS_OUTPUT.PUT_LINE('[' || RPAD(v_category, 16) || '] ' || rec.employee_id ||
      ' - ' || rec.first_name || ' ' || rec.last_name || ' earns ' ||
      TO_CHAR(rec.salary, 'FM999,999,999.00'));
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('==================================================');
  DBMS_OUTPUT.PUT_LINE(' Summary: ' || v_review_count || ' need review, ' ||
                       v_ok_count || ' are OK, ' || v_top_count || ' are top tier.');
END;
/