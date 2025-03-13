SELECT * FROM secure_data_view;
EXEC retrieve_decrypted_data(1);
SELECT * FROM security_audit ORDER BY access_time DESC;