/* Stored Procedures */
DELIMITER //

CREATE PROCEDURE phae_auth.disable_account (
	IN user_id INT
) BEGIN
	UPDATE
		auth_credentials
	SET
		is_active = 0
	WHERE
		account_id = 1
    AND
    login_credential_id != 0
	;
END // /* END Disable account */

/* NO SUPPORT YET */

CREATE PROCEDURE phae_auth.log_failed_attempt (
	IN provided_name VARCHAR(256)
) BEGIN

	UPDATE
		auth_credentials
	SET
		failed_attempts = failed_attempts + 1
	WHERE
		indicator_credential = providedName
		AND
		is_active = 1
		AND
		login_credential_id != 0
	;
END // /* END Fail logging */
