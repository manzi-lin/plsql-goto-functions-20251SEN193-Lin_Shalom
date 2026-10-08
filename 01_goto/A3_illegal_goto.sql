-- =====================================================================
-- 01_goto/A3_illegal_goto.sql
-- A3 - Illegal GOTO and Fix
--
-- PART 1 is intentionally ILLEGAL and raises:
--     PLS-00375: illegal GOTO statement; this GOTO cannot branch
--                to label 'INSIDE_IF'
-- because a GOTO may never jump INTO an IF statement.
--
-- PART 2 is the fix: the label is moved to the same block level as
-- the GOTO that targets it, so the jump is legal.
--
-- Run the WHOLE file as a script: the expected compile error is the
-- point of the exercise (screenshot -> screenshots/A3_error_and_fix.png).
-- SQL*Plus / SQL Developer report the error and continue to Part 2.
-- =====================================================================

SET SERVEROUTPUT ON

PROMPT --- PART 1: ILLEGAL GOTO (expected to fail with PLS-00375) ---

DECLARE
  v_num NUMBER := 5;
BEGIN
  GOTO inside_if;                       -- ILLEGAL: target is inside an IF

  IF v_num > 0 THEN
    <<inside_if>>
    DBMS_OUTPUT.PUT_LINE('Positive number: ' || v_num);
  END IF;
END;
/

PROMPT --- PART 2: FIXED VERSION ---

DECLARE
  v_num    NUMBER := 5;
  v_result VARCHAR2(30);
BEGIN
  -- Decide the message FIRST with structured IF/ELSE...
  IF v_num > 0 THEN
    v_result := 'Positive number: ' || v_num;
  ELSE
    v_result := 'Not positive: ' || v_num;
  END IF;

  -- ...then one legal, forward jump to the shared output label.
  GOTO show_result;

  <<show_result>>
  DBMS_OUTPUT.PUT_LINE('Result: ' || v_result);
END;
/