# Architecture

## Data layer

Oracle tables hold financial data, account and period reference data, and remediation tracking. SQL views centralize validation logic and provide reusable datasets for reporting.

## Application layer

Oracle APEX provides:
- An overview dashboard with summary metrics and an exception-type chart.
- An interactive report for data-quality exceptions.
- A variance analysis report.
- A remediation report.
- An editable remediation grid for status, assignment, and resolution notes.

## AI layer

A selected exception is converted into a text request and sent through the configured APEX Generative AI service to OCI Generative AI. The response is displayed separately from the request.

## Controls

- SQL rules identify known data-quality conditions.
- Remediation status is constrained to `New`, `In Progress`, or `Resolved`.
- A PL/SQL trigger refreshes the update timestamp.
- AI output is advisory and requires human review.
