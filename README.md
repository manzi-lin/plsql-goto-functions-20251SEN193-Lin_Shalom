# PL/SQL GOTO Statements and Functions

## Trainee information
* **Trainee names:** UDAHEMUKA Manzi Lin Shalom
* **Registration number:** 20251SEN193

## Course Information
* **Course:** Database Development with PL/SQL (INSY 8311)
* **Instructor:** Eric Maniraguha
* **Assignment:** Individual Assignment III: PL/SQL GOTO Statements and Functions
* **Institution:** Adventist University of Central Africa (AUCA)

## Environment & Tools Used
* **Operating System:** Windows 11 Pro
* **Database Management System:** Oracle Database 21c Enterprise Edition
* **Integrated Development Environment (IDE):** Oracle SQL Developer (Version 23.1.1.345.2114 x64)

## Project Description
This repository contains the practical deliverables for Individual Assignment III. The exercises focus on controlling execution flow using PL/SQL GOTO statements, creating stored functions, handling structural exceptions, and integrating user-defined functions directly into SQL queries.

## Repository Structure

plsql-goto-functions-20251SEN193-Lin Shalom/
│
├── README.md
├── .gitignore
├── 00_setup/
│ └── create_tables.sql
├── 01_goto/
│ ├── A1_number_classifier.sql
│ ├── A2_salary_review.sql
│ ├── A3_illegal_goto.sql
│ └── A4_rewrite_no_goto.sql
├── 02_functions/
│ ├── B1_fn_annual_salary.sql
│ ├── B2_fn_years_of_service.sql
│ ├── B3_fn_calculate_tax.sql
│ ├── B4_fn_dept_name.sql
│ └── C1_fn_validate_payroll.sql
├── 03_tests/
│ ├── B5_functions_in_select.sql
│ ├── test_functions.sql
│ └── test_validate_payroll.sql
├── screenshots/
│ ├── A1_output.png
│ ├── A2_output.png
│ ├── A3_error_and_fix.png
│ ├── A4_output.png
│ ├── B5_select_output.png
│ └── C1_output.png
└── docs/
└── REFLECTION.md

## Execution Sequence
1. Run the database setup script in `00_setup/create_tables.sql` to establish the core schema.
2. Compile all PL/SQL stored functions located within the `02_functions/` directory.
3. Execute the control flow evaluation scripts inside `01_goto/`.
4. Run the functional validation test scripts inside `03_tests/` to verify execution results against expectations.