-- =====================================================================
-- 01_goto/A1_number_classifier.sql
-- A1 - Number Classifier (GOTO)
--
-- Prompts for a number and classifies it as NEGATIVE, ZERO or POSITIVE.
-- Each classification lives behind its own GOTO label to demonstrate
-- unstructured control flow.
--
-- GOTO rules honoured here:
--   * Every label is followed by at least one executable statement.
--   * No GOTO ever jumps INTO an IF/CASE/LOOP block.
--
-- Run as a SCRIPT (F5 in SQL Developer) so the ACCEPT prompt works.
-- =====================================================================

SET SERVEROUTPUT ON
SET VERIFY OFF

ACCEPT p_num PROMPT 'Enter a number: '

DECLARE
  v_num NUMBER := &p_num;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Classifying number: ' || v_num);

  IF v_num < 0 THEN
    GOTO negative;
  ELSIF v_num = 0 THEN
    GOTO zero;
  ELSE
    GOTO positive;
  END IF;

  <<negative>>
  DBMS_OUTPUT.PUT_LINE('Result: ' || v_num || ' is NEGATIVE.');
  GOTO done;

  <<zero>>
  DBMS_OUTPUT.PUT_LINE('Result: ' || v_num || ' is ZERO.');
  GOTO done;

  <<positive>>
  DBMS_OUTPUT.PUT_LINE('Result: ' || v_num || ' is POSITIVE.');
  GOTO done;

  <<done>>
  NULL;  -- every label must be followed by at least one statement
END;
/