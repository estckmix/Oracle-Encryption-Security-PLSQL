Step-by-Step Guide: PL/SQL Encryption & Security Project

This project implements encryption, decryption, and security features in Oracle PL/SQL using DBMS_CRYPTO. It ensures data protection for sensitive information like Social Security Numbers (SSNs) and Credit Card Numbers (CCNs). Additionally, it includes role-based access control and audit logging.

________________________________________

Installation & Setup

Step 1: Create Database Tables

Run the script 01_create_tables.sql to create necessary tables.

@sql_scripts/01_create_tables.sql;

Step 2: Create Functions

Run the script 02_create_functions.sql to define encryption, decryption, and masking logic.

@sql_scripts/02_create_functions.sql;

Step 3: Create Stored Procedures

Run the script 03_create_procedures.sql to define procedures for inserting and retrieving encrypted data.

@sql_scripts/03_create_procedures.sql;

Step 4: Create Secure Views

Run the script 04_create_views.sql to create a secure view that conditionally decrypts or masks data.

@sql_scripts/04_create_views.sql;

Step 5: Set Up Roles & Permissions

Run the script 05_create_roles_permissions.sql to define security roles and grant access permissions.

@sql_scripts/05_create_roles_permissions.sql;

Step 6: Insert Sample Data

Run the script 06_insert_sample_data.sql to populate tables with encrypted data.

@sql_scripts/06_insert_sample_data.sql;

Step 7: Run Test Queries

Use 07_test_queries.sql to test encryption, decryption, and security audit logs.

@sql_scripts/07_test_queries.sql;

________________________________________

Package Details

encryption_pkg.pks (Package Specification)

encryption_pkg.pkb (Package Body)
