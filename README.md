# Hospital Management Database

**A MySQL portfolio project by Lekan Toriola, Information Technology student at Babcock University.**

This project models hospital appointments, admissions, prescriptions and payments.
It demonstrates relational design and SQL reporting across **12 tables, 2 views
and 123 fictional sample records**. Eight example reports answer questions about
doctor workload, patient activity, payments, room occupancy and medication stock.

## Start here

- [Database schema and relationships](docs/schema.md)
- [Eight reporting queries](reports.sql)
- [Project walkthrough and interview notes](docs/project-walkthrough.md)
- [Checks for data integrity and reporting accuracy](tests/verify.sql)

## What is implemented

| Area | Evidence in the repository |
| --- | --- |
| Relational design | Primary keys, foreign keys, unique fields, defaults and check constraints across 12 tables |
| Reporting views | One row per appointment or prescription, using its assigned doctor |
| SQL analysis | JOINs, LEFT JOINs, GROUP BY, HAVING, conditional aggregation, CTEs and subqueries in `reports.sql` |
| Reproducible setup | One SQL file creates the schema, sample data and views in an empty database |
| Verification | Import checks, view regression checks, constraint checks and a rollback check |

The seed records use generated names, birth dates and contact placeholders. The
dates are fixed so report results are repeatable. They are examples, not patient
records from a hospital.

## Run the project

Use **MySQL 8.0.16 or later**; the verification workflow uses MySQL 8.0. The SQL
uses MySQL-specific features and is not intended for SQLite, PostgreSQL or MariaDB.
You need a MySQL server plus MySQL Workbench or the `mysql` command-line client.

### MySQL Workbench

1. Download this repository using **Code → Download ZIP** and extract it, or clone it.
2. Connect Workbench to your local MySQL server. Create a fresh schema:

   ```sql
   CREATE DATABASE hospital_portfolio_demo
       CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
   ```

3. Refresh **SCHEMAS**, then double-click `hospital_portfolio_demo` to make it the
   default schema. Use a different, empty schema if that name already exists.
4. Choose **File → Open SQL Script**, open `hospital_management.sql`, and execute
   the whole script. Check the Action Output for errors.
5. Open `reports.sql` with the same default schema and run the report you want.
6. Open and execute `tests/verify.sql` to check the imported data and view logic.
   A successful run ends with **All verification checks passed**.

The setup file creates tables and inserts sample rows. It does not delete or
replace an existing database. Import it once into an empty schema; importing it
again into the same schema will produce “table already exists” errors.

### Command line

Run these commands from the repository directory. Replace `your_mysql_user` with
your local account; `-p` prompts for its password.

```bash
mysql -u your_mysql_user -p -e "CREATE DATABASE hospital_portfolio_demo CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;"
mysql -u your_mysql_user -p hospital_portfolio_demo < hospital_management.sql
mysql -u your_mysql_user -p --table hospital_portfolio_demo < reports.sql
mysql -u your_mysql_user -p --table hospital_portfolio_demo < tests/verify.sql
```

The `<` form works in Bash and Windows Command Prompt. In PowerShell, use the
interactive MySQL client instead:

```text
mysql -u your_mysql_user -p hospital_portfolio_demo
```

Then run these at the `mysql>` prompt from the repository directory:

```sql
SOURCE hospital_management.sql;
SOURCE reports.sql;
SOURCE tests/verify.sql;
```

Setup needs table, index and view creation privileges plus INSERT and SELECT.
The verification script also creates and drops a temporary test procedure and
tests updates. Use a local development database account with those permissions.

## Example results

These results describe the bundled sample data, not real hospital performance.

| Question | Expected result |
| --- | --- |
| How many appointments are recorded? | 20: 10 completed and 10 scheduled |
| Which doctors have the most appointments? | Doctors 04 and 06, with 4 each |
| How many patients made multiple payments? | 3 |
| Which rooms have an active admission? | G101 and G102 |
| Which medications have 50 units or fewer? | Metformin (50) and Azithromycin (45) |

For example, this query includes doctors with no appointments and counts actual
appointments rather than the placeholder row produced by a LEFT JOIN:

```sql
SELECT d.doctor_id,
       CONCAT(d.first_name, ' ', d.last_name) AS doctor,
       COUNT(a.appointments_id) AS appointment_count
FROM doctors AS d
LEFT JOIN appointments AS a ON a.doctor_id = d.doctor_id
GROUP BY d.doctor_id, d.first_name, d.last_name
ORDER BY appointment_count DESC, d.doctor_id;
```

## Why the view joins matter

An appointment belongs to its recorded `doctor_id`. Joining a patient to every
doctor in the patient's department can duplicate appointments and name the wrong
doctor. The views follow `appointments.doctor_id` and `prescriptions.doctor_id`
directly. Their tests also cover a doctor from a different department and an
event with missing optional relationships.

The views use `SQL SECURITY INVOKER`, so access depends on the querying account's
permissions rather than a hard-coded `root@localhost` account.

## Current scope and next improvements

This is a database and reporting project; it has no application interface.
`medical_tests` and `audit_log` have table definitions but no sample records.
There are no application stored procedures or triggers in this version.

Possible next steps:

- Add a dispensed quantity to prescriptions before implementing stock deduction.
- Add admission/discharge procedures and checks for overlapping room stays.
- Add audit triggers and demonstrate their output with focused tests.
- Replace flexible status strings and optional relationships with business rules
  once the required workflow is defined.

Room status is set explicitly in the sample data. It is not automatically updated
when admissions change; the active-admissions report uses `discharge_date IS NULL`.

## Verification

The GitHub Actions workflow imports the project into a fresh MySQL 8.0 service,
runs every report, and runs `tests/verify.sql`. The tests fail on a SQL error or
incorrect expected result. Their test data is rolled back; auto-increment counters
can still advance during a test run.

Reference: [MySQL script execution](https://dev.mysql.com/doc/refman/8.0/en/mysql-batch-commands.html)
and [view security](https://dev.mysql.com/doc/refman/8.0/en/create-view.html).
