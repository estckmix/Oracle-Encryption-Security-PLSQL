-- Create a package to encrypt and decrypt data (Package Body)
REATE OR REPLACE PACKAGE BODY encryption_pkg AS
    FUNCTION encrypt_data(p_plain_text VARCHAR2, p_key RAW) RETURN RAW IS
    BEGIN
        RETURN DBMS_CRYPTO.ENCRYPT(UTL_RAW.CAST_TO_RAW(p_plain_text), DBMS_CRYPTO.ENCRYPT_AES256 + DBMS_CRYPTO.CHAIN_CBC, p_key);
    END encrypt_data;

    FUNCTION decrypt_data(p_encrypted RAW, p_key RAW) RETURN VARCHAR2 IS
    BEGIN
        RETURN UTL_RAW.CAST_TO_VARCHAR2(DBMS_CRYPTO.DECRYPT(p_encrypted, DBMS_CRYPTO.ENCRYPT_AES256 + DBMS_CRYPTO.CHAIN_CBC, p_key));
    END decrypt_data;

    FUNCTION mask_sensitive_data(p_data VARCHAR2, p_mask_type VARCHAR2) RETURN VARCHAR2 IS
    BEGIN
        IF p_mask_type = 'SSN' THEN
            RETURN 'XXX-XX-' || SUBSTR(p_data, -4);
        ELSIF p_mask_type = 'CCN' THEN
            RETURN 'XXXX-XXXX-XXXX-' || SUBSTR(p_data, -4);
        ELSE
            RETURN 'DATA MASKED';
        END IF;
    END mask_sensitive_data;
END encryption_pkg;
/