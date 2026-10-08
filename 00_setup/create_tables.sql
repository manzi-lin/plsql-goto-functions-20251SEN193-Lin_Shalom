-- =====================================================================
-- 00_setup/create_tables.sql  (v2 - realistic RWF salaries)
-- Creates departments, employees, payrolls + sample data. Safe to re-run.
-- =====================================================================

SET SERVEROUTPUT ON

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE payrolls CASCADE CONSTRAINTS PURGE';
EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE employees CASCADE CONSTRAINTS PURGE';
EXCEPTION WHEN OTHERS THEN NULL; END;
/
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE departments CASCADE CONSTRAINTS PURGE';
EXCEPTION WHEN OTHERS THEN NULL; END;
/

CREATE TABLE departments (
  department_id   NUMBER(4)     PRIMARY KEY,
  department_name VARCHAR2(50)  NOT NULL
);

CREATE TABLE employees (
  employee_id   NUMBER(6)      PRIMARY KEY,
  first_name    VARCHAR2(30)   NOT NULL,
  last_name     VARCHAR2(30)   NOT NULL,
  email         VARCHAR2(60)   UNIQUE,
  hire_date     DATE           NOT NULL,
  salary        NUMBER(10,2)   NOT NULL CHECK (salary > 0),
  department_id NUMBER(4)      REFERENCES departments (department_id)
);

CREATE TABLE payrolls (
  payroll_id   NUMBER(8)     PRIMARY KEY,
  employee_id  NUMBER(6)     NOT NULL REFERENCES employees (employee_id),
  pay_month    DATE          NOT NULL,
  gross_salary NUMBER(10,2)  NOT NULL CHECK (gross_salary > 0),
  deductions   NUMBER(10,2)  NOT NULL CHECK (deductions >= 0),
  net_salary   NUMBER(10,2)  NOT NULL,
  status       VARCHAR2(20)  DEFAULT 'PENDING'
);

INSERT INTO departments VALUES (10, 'Finance');
INSERT INTO departments VALUES (20, 'IT');
INSERT INTO departments VALUES (30, 'Human Resources');
INSERT INTO departments VALUES (40, 'Marketing');

INSERT INTO employees VALUES (1001, 'Alice',    'Uwase',    'alice.uwase@auca.ac.rw',       DATE '2015-03-15',  250000, 30);
INSERT INTO employees VALUES (1002, 'Eric',     'Nkusi',    'eric.nkusi@auca.ac.rw',        DATE '2018-07-01',  850000, 20);
INSERT INTO employees VALUES (1003, 'Diane',    'Mukamana', 'diane.mukamana@auca.ac.rw',    DATE '2012-01-09', 1200000, 10);
INSERT INTO employees VALUES (1004, 'Jean',     'Bosco',    'jean.bosco@auca.ac.rw',        DATE '2021-09-20',  300000, 40);
INSERT INTO employees VALUES (1005, 'Claudine', 'Ingabire', 'claudine.ingabire@auca.ac.rw', DATE '2024-02-01',  190000, 20);
INSERT INTO employees VALUES (1006, 'Patrick',  'Mugisha',  'patrick.mugisha@auca.ac.rw',   DATE '2010-05-17',  950000, 10);

-- Pre-processed payroll rows (deductions = fn_calculate_tax of gross)
INSERT INTO payrolls VALUES (4001, 1002, TRUNC(SYSDATE,'MM'),  850000, 229000,  621000, 'PROCESSED');
INSERT INTO payrolls VALUES (4002, 1004, TRUNC(SYSDATE,'MM'),  300000,  64000,  236000, 'PROCESSED');

COMMIT;

PROMPT Setup complete: departments, employees and payrolls created and loaded.