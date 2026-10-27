# EPM Data Quality Assistant

An Oracle APEX application that identifies financial data-quality issues, highlights budget variances, tracks remediation progress, and uses OCI Generative AI to support financial investigation.

## Business Problem

Financial planning and analysis teams depend on accurate, consistent financial data. Missing values, invalid account references, incorrect reporting periods, and duplicate records can undermine reporting reliability and delay month-end activities.

Manual investigation can be time-consuming when teams need to identify exceptions, understand potential impacts, and track corrective actions.

## Solution

The EPM Data Quality Assistant provides a centralized interface for identifying and investigating financial data issues. It combines SQL-based validation, financial variance analysis, remediation tracking, and AI-generated investigation guidance.

## Features

### Data Quality Monitoring
- Identifies missing account codes and financial amounts.
- Detects invalid account and reporting-period references.
- Flags duplicate financial records.
- Provides business explanations and recommended actions.

### Financial Variance Analysis
- Compares actual financial amounts with budget values.
- Calculates absolute and percentage variances.
- Flags significant variances for review.

### Remediation Tracking
- Tracks statuses: `New`, `In Progress`, and `Resolved`.
- Supports assignment of responsible owners.
- Stores resolution notes and update timestamps.
- Displays remediation progress through reports.

### AI-Powered Exception Analysis
- Uses OCI Generative AI to analyze a selected financial exception.
- Produces an issue explanation, potential business impact, recommended investigation, suggested remediation, and validation steps.
- Supports human investigation; it does not automatically modify financial data.

### Overview Dashboard
- Summarizes financial records, exceptions, variances, and remediation statuses.
- Visualizes exceptions by issue type.

## Technology Stack

| Technology | Purpose |
|---|---|
| Oracle Autonomous AI Database | Database platform |
| Oracle SQL | Validation, joins, aggregations, calculations, and reporting |
| Oracle Database Views | Reusable business logic and reporting datasets |
| PL/SQL | Trigger for remediation update timestamps |
| Oracle APEX | Application interface, interactive reports, and editable remediation grid |
| OCI Generative AI | AI-generated explanations and investigation guidance |

## Architecture

```text
Financial Data
      |
      v
Oracle Database Tables
      |
      v
SQL Views and Validation Rules
      |
      +--------------------+
      |                    |
      v                    v
Data Quality          Variance Analysis
Exceptions            and Review Flags
      |                    |
      v                    v
Remediation Tracking  Overview Dashboard
      |
      v
Oracle APEX Interface
      |
      v
OCI Generative AI
      |
      v
Issue Explanation, Investigation
Guidance, and Remediation Suggestions
```

## Database Objects

Tables:
- `EPM_ACCOUNTS` — account reference data.
- `EPM_PERIODS` — reporting-period reference data.
- `EPM_FINANCIAL_DATA` — financial actual and budget records.
- `EPM_REMEDIATION_TRACKING` — status, ownership, resolution notes, and timestamps.

Views:
- `EPM_DATA_QUALITY_V` — identifies data-quality exceptions.
- `EPM_VARIANCE_V` — calculates financial variances and review status.
- `EPM_REMEDIATION_V` — adds business explanations and recommended actions.
- `EPM_REMEDIATION_STATUS_V` — combines exceptions with remediation status.

Trigger:
- `EPM_REMED_TRACK_BIU` — updates the remediation record timestamp on insert or update.

## Data Quality Rules

| Rule | Purpose |
|---|---|
| `MISSING_ACCOUNT` | Identifies records without an account code. |
| `MISSING_AMOUNT` | Identifies records with a missing financial amount. |
| `INVALID_ACCOUNT` | Identifies account references that do not match valid account data. |
| `INVALID_PERIOD` | Identifies reporting periods that do not match valid period data. |
| `DUPLICATE_RECORD` | Flags records matching the configured duplicate-detection rule. |

The demonstration dataset intentionally contains data-quality issues. It is designed to demonstrate validation, reporting, and remediation workflows rather than production-scale performance.

## AI Workflow

1. The user selects an exception in Oracle APEX.
2. The application retrieves the exception details from the database.
3. The user requests an explanation.
4. OCI Generative AI analyzes the supplied details using a defined system prompt.
5. The application displays five sections: issue explanation, potential business impact, recommended investigation, suggested remediation, and validation.
6. A finance or data professional reviews the suggestions and determines the appropriate corrective action.

## Validation and Testing

The implemented application has been manually tested to confirm that:
- The data-quality exceptions report displays six exception rows.
- Variance analysis displays three rows and flags the Travel Expenses variance of 2,500 for review (actual 8,500 versus budget 6,000).
- Remediation tracking displays six rows and reflects saved status changes.
- The AI analysis completes and returns all five expected sections.
- The overview dashboard displays its summary metrics and exception chart.

These are functional checks against the current demonstration dataset, not a production certification or performance benchmark.

## Business Value

The solution demonstrates how database-driven validation and AI-assisted investigation can support financial data governance. Potential benefits include faster issue identification, more consistent investigation, clearer ownership, and improved visibility into remediation. Quantified time savings have not been measured.

## Repository Contents

- `sql/` — SQL scripts for schema objects, views, seed data, and trigger.
- `tests/` — SQL checks for expected data-quality and variance results.
- `screenshots/` — screenshots of the running application.
- `docs/` — architecture and AI integration notes.

The SQL scripts and screenshots should be added from the actual implementation before treating the repository as a complete, reproducible deployment package.

## Security and Limitations

- Never commit OCI private keys, passwords, tokens, or other credentials.
- Use sanitized sample data only.
- The application provides recommendations; it does not automatically correct financial records.
- AI output may be inaccurate and requires human review.
- The project is a portfolio demonstration, not a production-certified financial control system.

## Future Enhancements

- Add automated SQL regression tests.
- Introduce configurable variance thresholds.
- Add exception filtering by entity, period, account, and status.
- Extend remediation auditing and role-based access controls.
- Evaluate AI output quality against a predefined test set.
- Test with a larger, representative dataset.
