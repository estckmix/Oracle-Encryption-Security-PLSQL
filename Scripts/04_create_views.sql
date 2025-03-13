CREATE OR REPLACE VIEW secure_data_view AS 
SELECT 
    sd.id,
    sd.user_id,
    CASE 
        WHEN EXISTS (
            SELECT 1 FROM user_role_privs 
            WHERE grantee = SYS_CONTEXT('USERENV', 'SESSION_USER') 
            AND granted_role = 'DATA_SECURITY_ROLE'
        ) 
        THEN decrypt_data(sd.encrypted_ssn, uk.key_value) 
        ELSE mask_sensitive_data(decrypt_data(sd.encrypted_ssn, uk.key_value), 'SSN') 
    END AS ssn,
    CASE 
        WHEN EXISTS (
            SELECT 1 FROM user_role_privs 
            WHERE grantee = SYS_CONTEXT('USERENV', 'SESSION_USER') 
            AND granted_role = 'DATA_SECURITY_ROLE'
        ) 
        THEN decrypt_data(sd.encrypted_ccn, uk.key_value) 
        ELSE mask_sensitive_data(decrypt_data(sd.encrypted_ccn, uk.key_value), 'CCN') 
    END AS ccn
FROM secure_data sd
JOIN user_keys uk ON sd.user_id = uk.user_id;
/