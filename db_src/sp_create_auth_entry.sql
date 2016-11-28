/* Stored Procedures */
DELIMITER //

/**
 * Creates a new authentication entry that can be validated against.
 *
 * INCOMPLETE
 **/

DROP PROCEDURE phae_auth.create_auth_entry;

CREATE PROCEDURE phae_auth.create_auth_entry (
	IN user_name VARCHAR(256),
	IN user_password VARCHAR(100),
  IN external_id VARCHAR(36)
) BEGIN
	DECLARE new_salt VARCHAR(50);
	DECLARE generated_hash VARCHAR(128);

	SET new_salt = SUBSTRING(MD5(RAND()) FROM 1 FOR 50);
	SET generated_hash = SHA2(CONCAT(user_password, new_salt) , 512);

    /* Inactivate any auth entries that already exist for this account ID */
	UPDATE
		phae_auth.auth_credentials
	SET
		is_active = 0
	WHERE
		external_id = external_id
		AND
    is_active = 1
		AND
    indicator_credential = user_name
		AND
		id != 0 /* For index ref */
	;

	/* Now, create this auth entry. */
	INSERT INTO phae_auth.auth_credentials (
		indicator_credential,
    external_id,
		salt,
		pass_key,
		created_timestamp,
		created_by,
		last_activity,
		is_active
	) VALUE (
		user_name,
    external_id,
		new_salt,
		generated_hash,
		CURRENT_TIMESTAMP,
		'0',
		CURRENT_TIMESTAMP,
		'1'
	);
END // /* End Create entry logic */
