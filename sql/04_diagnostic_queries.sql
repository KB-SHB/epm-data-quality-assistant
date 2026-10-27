-- Diagnostic queries for the running EPM Data Quality Assistant.
-- The application uses ADMIN as the object-owning schema in its APEX SQL sources.

-- 1. Exception counts by issue type.
SELECT ISSUE_TYPE, COUNT(*) AS EXCEPTION_COUNT
FROM ADMIN.EPM_DATA_QUALITY_V
GROUP BY ISSUE_TYPE
ORDER BY EXCEPTION_COUNT DESC, ISSUE_TYPE;

-- 2. Number of distinct records with issues versus total exception rows.
SELECT
    (SELECT COUNT(DISTINCT RECORD_ID)
       FROM ADMIN.EPM_DATA_QUALITY_V) AS RECORDS_WITH_ISSUES,
    (SELECT COUNT(*)
       FROM ADMIN.EPM_DATA_QUALITY_V) AS TOTAL_EXCEPTIONS
FROM DUAL;

-- 3. Remediation status summary.
SELECT REMEDIATION_STATUS, COUNT(*) AS ISSUE_COUNT
FROM ADMIN.EPM_REMEDIATION_STATUS_V
GROUP BY REMEDIATION_STATUS
ORDER BY REMEDIATION_STATUS;

-- 4. Variances flagged for review.
SELECT *
FROM ADMIN.EPM_VARIANCE_V
WHERE REVIEW_STATUS = 'REVIEW'
ORDER BY ABS(VARIANCE_AMOUNT) DESC;

-- 5. Completion rate for resolved exceptions.
SELECT
    (SELECT COUNT(*) FROM ADMIN.EPM_DATA_QUALITY_V) AS TOTAL_EXCEPTIONS,
    (SELECT COUNT(*)
       FROM ADMIN.EPM_REMEDIATION_TRACKING
      WHERE REMEDIATION_STATUS = 'Resolved') AS RESOLVED_ISSUES,
    NVL(
        ROUND(
            100 * (
                SELECT COUNT(*)
                FROM ADMIN.EPM_REMEDIATION_TRACKING
                WHERE REMEDIATION_STATUS = 'Resolved'
            ) / NULLIF(
                (SELECT COUNT(*) FROM ADMIN.EPM_DATA_QUALITY_V),
                0
            ),
            1
        ),
        0
    ) AS COMPLETION_RATE_PCT
FROM DUAL;
