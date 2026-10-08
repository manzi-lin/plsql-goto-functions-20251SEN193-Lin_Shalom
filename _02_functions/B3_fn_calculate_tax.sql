-- =====================================================================
-- 02_functions/B3_fn_calculate_tax.sql
-- B3 - Tax Calculator function
--
-- Progressive monthly tax bands (Rwanda PAYE-style, amounts in RWF):
--   * first        60,000  -> 0%
--   *   60,001 -  100,000  -> 10% of the amount above 60,000
--   *  above      100,000  -> 4,000 + 30% of the amount above 100,000
-- Example: 150,000 -> 4,000 + 0.30 * 50,000 = 19,000
-- =====================================================================

CREATE OR REPLACE FUNCTION fn_calculate_tax (
  p_salary IN NUMBER
) RETURN NUMBER IS
  c_band1_ceiling CONSTANT NUMBER := 60000;
  c_band2_ceiling CONSTANT NUMBER := 100000;
  c_band2_rate    CONSTANT NUMBER := 0.10;
  c_band3_rate    CONSTANT NUMBER := 0.30;

  v_tax NUMBER := 0;
BEGIN
  IF p_salary IS NULL OR p_salary < 0 THEN
    RAISE_APPLICATION_ERROR(-20003,
      'Salary must be a non-negative number.');
  END IF;

  IF p_salary > c_band2_ceiling THEN
    v_tax := (c_band2_ceiling - c_band1_ceiling) * c_band2_rate   -- the 4,000
           + (p_salary - c_band2_ceiling) * c_band3_rate;
  ELSIF p_salary > c_band1_ceiling THEN
    v_tax := (p_salary - c_band1_ceiling) * c_band2_rate;
  END IF;
  -- p_salary <= 60,000 falls through with v_tax = 0

  RETURN ROUND(v_tax, 2);
END fn_calculate_tax;
/

-- Quick smoke test across every bracket
SET SERVEROUTPUT ON
BEGIN
  DBMS_OUTPUT.PUT_LINE('Tax on  50,000 (0% band):  ' || fn_calculate_tax(50000));
  DBMS_OUTPUT.PUT_LINE('Tax on  80,000 (10% band): ' || fn_calculate_tax(80000));
  DBMS_OUTPUT.PUT_LINE('Tax on 150,000 (30% band): ' || fn_calculate_tax(150000));
END;
/