/* Stored Procedures */
DELIMITER //

/**
 * Checks a provided set of credentials against active records and returns a token
 *
 * INCOMPLETE
 **/
DROP PROCEDURE IF EXISTS phae_auth.validate_login;

CREATE PROCEDURE phae_auth.validate_login (
	IN providedName VARCHAR(256),
	IN providedPass VARCHAR(256),
	OUT token VARCHAR(128)
) BEGIN
	DECLARE credential_Id INT;

    /* Get the credential entry Id with password descrimination */

	SET credential_Id = (
    SELECT
    	id
    FROM
    	phae_auth.auth_credentials
    WHERE
    	indicator_credential = providedName
    	AND
    	is_active = 1 /* Restrict only to active accounts*/
    	AND
    	pass_key = SHA2(CONCAT(providedPass, salt), 512) /* validate the password */
  );

	IF (credential_Id IS NOT NULL) THEN
		UPDATE
			phae_auth.auth_credentials
		SET
			last_activity = CURRENT_TIMESTAMP
		WHERE
			id = credential_Id
			AND
			indicator_credential = providedName
			AND
			is_active = 1
		;
    SET token = SUBSTRING(MD5(RAND()) FROM 1 FOR 128);
    
    INSERT INTO phae_auth.bearer_tokens (
		credential,
		token,
        date_set
	) VALUES (
		credential_Id,
		token,
        CURRENT_TIMESTAMP
	) ON DUPLICATE KEY UPDATE
		token = token,
        date_set = CURRENT_TIMESTAMP;

	END IF;
END // /* END Validation Logic */
