-- EPM Data Quality Assistant
-- Remediation tracking table.
-- Run only if the table does not already exist.
-- Existing working table is described in the project documentation.

CREATE TABLE EPM_REMEDIATION_TRACKING (
    RECORD_ID          NUMBER        NOT NULL,
    ISSUE_TYPE         VARCHAR2(50)  NOT NULL,
    REMEDIATION_STATUS VARCHAR2(20)  DEFAULT 'New' NOT NULL,
    ASSIGNED_TO        VARCHAR2(100),
    RESOLUTION_NOTES   VARCHAR2(1000),
    UPDATED_AT         TIMESTAMP     DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT EPM_REMED_TRACKING_PK
        PRIMARY KEY (RECORD_ID, ISSUE_TYPE),
    CONSTRAINT EPM_REMED_STATUS_CK
        CHECK (REMEDIATION_STATUS IN ('New', 'In Progress', 'Resolved'))
);

-- Note:
-- In the completed project, this table was initialized from existing exception
-- rows with a MERGE and contained six tracking rows. Re-run initialization only
-- after reviewing the source view and existing data.
