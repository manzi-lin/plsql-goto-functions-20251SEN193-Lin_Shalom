# Assignment Reflection

## Environment & Development Tools
The practical execution of this assignment was completed using the following technology stack:
* **OS:** Windows 11 Pro
* **Database Server:** Oracle Database 21c Enterprise Edition
* **Development IDE:** Oracle SQL Developer 23.1.1 (Build 23.1.1.345.2114 - x64)

## Core Concepts Learned
* **PL/SQL GOTO Control Flow:** Explored how to implement unconditional branching using statement labels and analyzed structural limitations, specifically focusing on constraints preventing jumps into inner blocks, loops, or IF conditions.
* **Stored Functions:** Gained experience writing modular database routines that calculate parameters like annual compensation scales, years of service milestones, and tax applications.
* **Exception Handling Logic:** Designed error-catching rules within functions to provide data validation frameworks without breaking structural operations.
* **SQL Query Integration:** Learned to embed user-defined PL/SQL functions natively into standard DML statements like `SELECT` clauses to simplify data processing.

## Challenges and Solutions
* **Challenge:** Handling compilation errors caused by illegal GOTO branching when attempting to jump directly into restrictive scopes like sub-structures, internal loops, or conditional IF statements.
* **Solution:** Respected scoping rules by ensuring GOTO statements only branch outwards or within the same block level, and restructured code blocks into cleanly nested conditional statements to remove invalid label targets.

## AI Assistant Usage Notes
* **AI Tool Involvement:** An AI assistant was utilized to accelerate the learning process for this assignment. Specifically, the AI was used to discover top-tier PL/SQL database development platforms, source high-quality YouTube tutorials, and debug syntax and structural challenges related to error handling. Additionally, it assisted in drafting the baseline documentation layouts (`README.md`, `.gitignore`, and the skeleton of this reflection). All final deliverables, logic implementations, and test validations were reviewed and verified independently to maintain full academic integrity.

