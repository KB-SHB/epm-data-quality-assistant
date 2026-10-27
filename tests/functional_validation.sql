-- EPM Data Quality Assistant: functional validation queries.
-- Expected results for the current sample dataset are included as comments.

-- Test 1: Data-quality exceptions.
-- Expected: 6 exception rows.
SELECT COUNT(*) AS EXCEPTION_ROWS
FROM ADMIN.EPM_DATA_QUALITY_V;

-- Test 2: Distinct financial records affected.
-- Expected: 6 distinct record IDs with issues.
SELECT COUNT(DISTINCT RECORD_ID) AS RECORDS_WITH_ISSUES
FROM ADMIN.EPM_DATA_QUALITY_V;

-- Test 3: Variance report.
-- Expected: 3 rows.
SELECT COUNT(*) AS VARIANCE_ROWS
FROM ADMIN.EPM_VARIANCE_V;

-- Test 4: Review variance.
-- Expected: Travel Expenses has actual 8500, budget 6000, variance 2500,
-- and review status REVIEW. Confirm exact entity/account labels in the result.
SELECT *
FROM ADMIN.EPM_VARIANCE_V
WHERE REVIEW_STATUS = 'REVIEW';

-- Test 5: Remediation status report.
-- Expected: 6 exception rows in the current dataset.
SELECT COUNT(*) AS REMEDIATION_ROWS
FROM ADMIN.EPM_REMEDIATION_STATUS_V;

-- Test 6: Status counts.
SELECT REMEDIATION_STATUS, COUNT(*) AS ISSUE_COUNT
FROM ADMIN.EPM_REMEDIATION_STATUS_V
GROUP BY REMEDIATION_STATUS
ORDER BY REMEDIATION_STATUS;

-- Test 7: Trigger exists and is enabled.
SELECT TRIGGER_NAME, STATUS
FROM USER_TRIGGERS
WHERE TRIGGER_NAME = 'EPM_REMED_TRACK_BIU';
