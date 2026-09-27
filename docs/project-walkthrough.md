# Presenting this project

Use the repository's actual queries and results when discussing this work. Run the
project yourself and practise explaining the joins before adding new features.

## A short introduction

“This is my MySQL hospital management learning project. It has 12 related tables
for patients, staff, appointments, admissions, prescriptions and payments. I use
primary and foreign keys to connect the records, and reporting queries to examine
doctor workload, payment totals, active admissions and medication stock.”

“One issue I learned to identify is an incorrect join: linking a patient to all
doctors in a department can duplicate a consultation and name the wrong doctor.
The corrected views use the doctor ID on the appointment or prescription. The
checks cover that case, including a doctor from a different department.”

## Five-minute demonstration

1. Open `docs/schema.md` and explain the patient → appointment ← doctor relationship.
2. Import `hospital_management.sql` into an empty local database.
3. Run report 2 in `reports.sql`. Explain why LEFT JOIN includes doctors with zero
   appointments and why `COUNT(a.appointments_id)` does not count empty matches.
4. Run reports 4 and 5. Explain the difference between listing every patient's
   total payments and using HAVING to select patients with multiple payments.
5. Run `tests/verify.sql` and show its success message. Explain what would fail if
   the views joined through department membership again.
6. Describe the next feature you would build and the rule it needs: for example,
   a dispensed quantity before subtracting medication stock.

## Questions to practise

| Question | Points to cover |
| --- | --- |
| Why not store everything in one table? | Different entities have different lifecycles; foreign keys connect them without repeating every patient's or doctor's details in each event. |
| What is the difference between WHERE and HAVING? | WHERE filters input rows. HAVING filters groups after aggregation; report 5 uses a payment count. |
| How can a JOIN inflate a total? | Joining two one-to-many child tables before aggregation can multiply rows. Report 3 aggregates patient and doctor counts separately. |
| What does a foreign key guarantee? | A non-NULL reference must identify an existing parent. It does not guarantee appointment availability or prevent overlapping admissions. |
| Why use LEFT JOIN in the views? | Optional foreign keys may be NULL. An appointment or prescription should remain visible even if related details are missing. |
| What does ROLLBACK do here? | It reverses test inserts and updates in InnoDB. Auto-increment numbers may still have gaps. |
| Is stock deducted automatically? | No. The current schema has dosage text, not a dispensed quantity, and this version includes no stock trigger. |

## Skills demonstrated by this version

Relational schema design, integrity constraints, MySQL imports, JOINs, grouped
reporting, HAVING, subqueries, CTEs, views and regression checks. Application
procedures, audit automation and room/stock triggers are future work.
