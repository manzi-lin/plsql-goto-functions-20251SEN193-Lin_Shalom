-- =====================================================================
-- 03_tests/B5_functions_in_select.sql  (v2)
-- B5 - Functions used directly inside SQL statements
-- All four functions are side-effect free, so all calls are legal.
-- =====================================================================

SET SERVEROUTPUT ON
SET NUMWIDTH 15

-- 1) Every function in a single SELECT list
SELECT employee_id,
       first_name || ' ' || last_name     AS employee,
       salary,
       fn_annual_salary(salary)           AS annual_salary,
       fn_calculate_tax(salary)           AS monthly_tax,
       fn_years_of_service(employee_id)   AS years_of_service,
       fn_dept_name(department_id)        AS department
  FROM employees
 ORDER BY employee_id;

-- 2) A function inside a WHERE clause and ORDER BY
SELECT employee_id,
       first_name || ' ' || last_name     AS employee,
       salary,
       fn_calculate_tax(salary)           AS monthly_tax
  FROM employees
 WHERE fn_calculate_tax(salary) > 2000
 ORDER BY fn_calculate_tax(salary) DESC;

-- 3) A function inside a GROUP BY aggregate query
SELECT fn_dept_name(department_id)        AS department,
       COUNT(*)                           AS headcount,
       SUM(fn_calculate_tax(salary))      AS total_monthly_tax
  FROM employees
 GROUP BY department_id
 ORDER BY department;