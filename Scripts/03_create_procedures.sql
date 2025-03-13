CREATE OR REPLACE PROCEDURE insert_encrypted_data (p_user_id NUMBER, p_ssn VARCHAR2, p_ccn VARCHAR2) AS
    l_key RAW(32);
    l_encrypted_ssn RAW(2000);
    l_encrypted_ccn RAW(2000);
BEGIN
    SELECT key_value INTO l_key FROM user_keys WHERE user_id = p_user_id;
    l_encrypted_ssn := encrypt_data(p_ssn, l_key);
    l_encrypted_ccn := encrypt_data(p_ccn, l_key);

    INSERT INTO secure_data (user_id, encrypted_ssn, encrypted_ccn) 
    VALUES (p_user_id, l_encrypted_ssn, l_encrypted_ccn);

    COMMIT;
END insert_encrypted_data;
/

CREATE OR REPLACE PROCEDURE retrieve_decrypted_data (p_user_id IN NUMBER) AS
    l_ssn VARCHAR2(20);
    l_ccn VARCHAR2(20);
    l_key RAW(32);
    l_user VARCHAR2(100);
BEGIN
    l_user := SYS_CONTEXT('USERENV', 'SESSION_USER');

    INSERT INTO security_audit (user_name, action, accessed_data)
    VALUES (l_user, 'DECRYPTION ATTEMPT', 'User ID: ' || p_user_id);

    SELECT key_value INTO l_key FROM user_keys WHERE user_id = p_user_id;

    SELECT decrypt_data(encrypted_ssn, l_key), decrypt_data(encrypted_ccn, l_key)
    INTO l_ssn, l_ccn
    FROM secure_data WHERE user_id = p_user_id;

    DBMS_OUTPUT.PUT_LINE('Decrypted SSN: ' || l_ssn);
    DBMS_OUTPUT.PUT_LINE('Decrypted CCN: ' || l_ccn);
END retrieve_decrypted_data;
/