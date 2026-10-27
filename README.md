# EPM Data Quality Assistant

An Oracle APEX portfolio application that identifies financial data-quality exceptions, highlights budget variances, tracks remediation, and uses OCI Generative AI to support investigation.

## Business problem

Financial planning and analysis teams rely on accurate financial data. Missing values, invalid account references, invalid reporting periods, and duplicate records can reduce confidence in reporting and delay investigation.

This project demonstrates a practical workflow for detecting data issues, prioritizing financial variances, recording remediation progress, and using generative AI to help a human analyst investigate exceptions.

## Features

- **Data-quality monitoring:** flags missing account codes, missing amounts, invalid account references, invalid periods, and duplicate records.
- **Variance analysis:** compares actuals with budgets and calculates absolute and percentage variances.
- **Remediation tracking:** records status (`New`, `In Progress`, `Resolved`), owner, resolution notes, and update timestamps.
- **AI-assisted investigation:** sends selected exception details to OCI Generative AI and displays a structured analysis.
- **Overview dashboard:** summarizes record counts, exceptions, variances, remediation statuses, and exceptions by type.

## Technology stack

| Technology | Role in the project |
|---|---|
| Oracle Autonomous AI Database | Database platform |
| Oracle SQL | Validation logic, joins, calculations, and reporting |
| Oracle database views | Reusable data-quality, variance, and remediation logic |
| PL/SQL | Trigger to refresh remediation update timestamps |
| Oracle APEX | Dashboard, interactive reports, selector, and editable remediation grid |
| OCI Generative AI | AI-generated investigation guidance |

## Architecture

```text
Financial tables and reference data
                 |
                 v
      SQL validation and views
          /             \
         v               v
Data-quality issues   Variance analysis
         |
         v
Remediation tracking
         |
         v
Oracle APEX application
         |
         v
OCI Generative AI analysis
         |
         v
Human review and validation
```

## Database objects

Tables:
- `EPM_ACCOUNTS` — account reference data.
- `EPM_PERIODS` — reporting-period reference data.
- `EPM_FINANCIAL_DATA` — financial actual/budget data.
- `EPM_REMEDIATION_TRACKING` — remediation status, ownership, notes, and timestamps.

Views:
- `EPM_DATA_QUALITY_V` — identifies exception rows.
- `EPM_VARIANCE_V` — compares actuals and budgets.
- `EPM_REMEDIATION_V` — enriches exceptions with explanations and recommended actions.
- `EPM_REMEDIATION_STATUS_V` — joins exception details with remediation tracking.

Trigger:
- `EPM_REMED_TRACK_BIU` — refreshes the `UPDATED_AT` timestamp on insert/update.

> The SQL folder contains implementation notes and diagnostic queries based on the verified project configuration. Where an exact original table definition or full view DDL was not available in the project notes, the files explicitly identify that limitation rather than pretending to be an exact database export.

## AI workflow

1. The user selects an exception in the APEX page.
2. APEX loads the selected exception details into the request field.
3. The user clicks **Explain with AI**.
4. OCI Generative AI generates five sections: issue explanation, potential business impact, recommended investigation, suggested remediation, and validation.
5. A human reviews the recommendations. The AI does not automatically modify financial records.

The APEX integration uses the configured OCI Generative AI service. Never publish private keys, API credentials, wallet files, passwords, or other secrets.

## Validation performed

The following functional tests passed against the current demonstration application:

- Data Quality Exceptions displays six exception rows.
- Variance Analysis displays three rows; Travel Expenses shows actual `8500`, budget `6000`, variance `2500`, and status `REVIEW`.
- Remediation Tracking displays six rows and reflects saved status changes.
- Explain with AI completes and returns all five expected sections.
- The Overview dashboard displays its summary cards and exception-type chart.

These checks validate the current sample workflow. They are not a production certification, security review, or performance benchmark.

## Repository layout

```text
epm-data-quality-assistant/
├── README.md
├── sql/
│   ├── README.md
│   ├── 01_remediation_tracking.sql
│   ├── 02_remediation_status_view.sql
│   ├── 03_remediation_timestamp_trigger.sql
│   └── 04_diagnostic_queries.sql
├── tests/
│   ├── README.md
│   └── functional_validation.sql
├── docs/
│   ├── README.md
│   ├── architecture.md
│   └── ai-integration.md
└── screenshots/
    └── README.md
```

## Business value and limitations

The project demonstrates how database-driven controls and AI-assisted investigation can support financial data governance. Potential benefits include faster issue identification, more consistent investigation, and improved visibility into remediation. Quantified time savings have not been measured.

This is a portfolio demonstration, not a production-certified financial control system. AI output can be inaccurate and requires human review. The sample dataset is intentionally small.

## Future enhancements

- Export exact DDL for all tables and views from the live database.
- Add automated SQL regression tests.
- Make variance thresholds configurable.
- Add filtering by entity, period, account, and status.
- Evaluate AI output against a predefined test set.
- Test with a larger, representative dataset.
