-- Create a package to encrypt and decrypt data (Package Specification)
CREATE OR REPLACE PACKAGE encryption_pkg AS
    FUNCTION encrypt_data(p_plain_text VARCHAR2, p_key RAW) RETURN RAW;
    FUNCTION decrypt_data(p_encrypted RAW, p_key RAW) RETURN VARCHAR2;
    FUNCTION mask_sensitive_data(p_data VARCHAR2, p_mask_type VARCHAR2) RETURN VARCHAR2;
END encryption_pkg;
/
