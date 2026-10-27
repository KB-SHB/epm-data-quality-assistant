# OCI Generative AI integration

## Purpose

The AI feature supports investigation of a selected financial data-quality exception. It does not write changes to the financial data.

## User workflow

1. The user selects an exception from the APEX selector.
2. A dynamic action loads record ID, issue type, entity, account, period, issue details, business explanation, and recommended action into the request item.
3. The user clicks **Explain with AI**.
4. The configured APEX Generative AI service sends the request to OCI Generative AI.
5. The result is displayed in a separate read-only response item.

## Response structure

The system prompt requests five sections:
1. Issue Explanation
2. Potential Business Impact
3. Recommended Investigation
4. Suggested Remediation
5. Validation

The prompt instructs the model not to invent missing values, not to claim that data was changed, and to require human validation.

## Configuration and security

The working application uses an APEX Generative AI service configured for OCI Generative AI in the Frankfurt region and a Cohere Command model. Do not publish the API signing private key, APEX web credential contents, credential IDs if considered sensitive by your organization, or other secret values. Configure credentials separately in each environment.

## Limitations

Generated content can be incomplete or incorrect. Users must validate recommendations against the organization's financial policies and source systems.
