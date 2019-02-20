CREATE OR REPLACE PROCEDURE STATS_APEX.QA_MERGE_EMAIL (v_rule_id INTEGER, v_email_to VARCHAR2, v_email_cc VARCHAR2, v_email_from VARCHAR2,v_notify CHAR, v_notify_success CHAR, v_notify_error CHAR, v_success_message VARCHAR2, v_error_message VARCHAR2)
AS
BEGIN

IF v_notify = 'Y' THEN

MERGE INTO QA_EMAIL A
USING QA_BUSINESS_RULES B
ON (A.RULE_ID = B.RULE_ID)
WHEN MATCHED THEN
UPDATE SET EMAIL_TO = REPLACE(v_email_to,':',';'),
    EMAIL_CC = REPLACE(v_email_cc,':',';'),
    EMAIL_FROM = REPLACE(v_email_from,':',';'),
    SUCCESS_MESSAGE = CASE WHEN v_notify_success = 'Y' THEN v_success_message ELSE NULL END,
    ERROR_MESSAGE = CASE WHEN v_notify_error = 'Y' THEN v_error_message ELSE NULL END
WHERE RULE_ID = v_rule_id

WHEN NOT MATCHED THEN 

INSERT VALUES(v_rule_id, REPLACE(v_email_to,':',';'),REPLACE(v_email_cc,':',';'),REPLACE(v_email_from,':',';'),CASE WHEN v_notify_success = 'Y' THEN v_success_message ELSE NULL END,CASE WHEN v_notify_error = 'Y' THEN v_error_message ELSE NULL END);

END IF;

EXCEPTION WHEN OTHERS THEN

RAISE_APPLICATION_ERROR('20001', 'Email Merge Failed');

END;
/
