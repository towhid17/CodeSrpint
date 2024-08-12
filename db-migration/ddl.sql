CREATE TABLE "user" (
	id			INTEGER,
	user_name	VARCHAR(255)	NOT NULL,
	email		VARCHAR(255)	NOT NULL,
	password	VARCHAR(255) 	NOT NULL,
	full_name	VARCHAR(255),
	dob			DATE,
	lock 		BOOLEAN         NOT NULL,
	CONSTRAINT pk_user PRIMARY KEY (id),
	CONSTRAINT uk_user_user_name UNIQUE (user_name),
	CONSTRAINT uk_user_email UNIQUE (email) 
);

CREATE TABLE difficulty (
	id			INTEGER,
	name		VARCHAR(255)	NOT NULL,
	CONSTRAINT pk_difficulty PRIMARY KEY (id), 
	CONSTRAINT uk_difficulty_name UNIQUE (name)
);

CREATE TABLE category (
	id			INTEGER,
	name		VARCHAR(255)	NOT NULL,
	CONSTRAINT pk_category PRIMARY KEY (id),
	CONSTRAINT uk_category_name UNIQUE (name)
);

CREATE TABLE tag (
	id			INTEGER,
	name		VARCHAR(255)	NOT NULL,
	CONSTRAINT pk_tag PRIMARY KEY (id),
	CONSTRAINT uk_tag_name UNIQUE (name)
);

CREATE TABLE problem (
	id				INTEGER,
	title			VARCHAR(255)	NOT NULL,
	description 	VARCHAR(500)	NOT NULL,
	difficulty_id	INTEGER			NOT NULL,
	category_id		INTEGER			NOT NULL,
    deleted		    BOOLEAN,
	CONSTRAINT pk_problem PRIMARY KEY (id),
	CONSTRAINT fk_problem_difficulty_id FOREIGN KEY (difficulty_id) REFERENCES difficulty (id),
	CONSTRAINT fk_problem_category_id FOREIGN KEY (category_id) REFERENCES category (id)
);

CREATE TABLE problem_tag (
	problem_id		INTEGER		 NOT NULL,
	tag_id			INTEGER		 NOT NULL,
	CONSTRAINT fk_problem_tag_problem_id FOREIGN KEY (problem_id) REFERENCES problem (id),
	CONSTRAINT fk_problem_tag_tag_id FOREIGN KEY (tag_id) REFERENCES tag (id)
);

CREATE TABLE editorial (
	id 				INTEGER,
	description		TEXT		        NOT NULL,
	average_rating	DOUBLE PRECISION,
	num_of_rating	INTEGER,
	problem_id		INTEGER		        NOT NULL,
	CONSTRAINT pk_editorial PRIMARY KEY (id),
	CONSTRAINT fk_editorial_problem_id FOREIGN KEY (problem_id) REFERENCES problem (id)
);

CREATE TABLE submission (
	id				INTEGER,
	script			BYTEA		 NOT NULL,
	submission_date	TIMESTAMPTZ  NOT NULL,
	status			VARCHAR(50)  NOT NULL,
	user_id			INTEGER		 NOT NULL,
	problem_id		INTEGER		 NOT NULL,
	CONSTRAINT pk_submission PRIMARY KEY (id),
	CONSTRAINT fk_submission_user_id FOREIGN KEY (user_id) REFERENCES "user" (id),
	CONSTRAINT fk_submission_problem_id FOREIGN KEY (problem_id) REFERENCES problem (id)
);

CREATE TABLE example (
	id 				INTEGER,
	input 			VARCHAR(255)	NOT NULL,
	output			VARCHAR(255)	NOT NULL,
	problem_id		INTEGER			NOT NULL,
	CONSTRAINT pk_example PRIMARY KEY (id),
	CONSTRAINT fk_example_problem_id FOREIGN KEY (problem_id) REFERENCES problem (id)
);

CREATE TABLE "constraint" (
	id 				INTEGER,
	description 	VARCHAR(255)	NOT NULL,
	problem_id		INTEGER			NOT NULL,
	CONSTRAINT pk_constraint PRIMARY KEY (id),
	CONSTRAINT fk_constraint_problem_id FOREIGN KEY (problem_id) REFERENCES problem (id)
);

CREATE TABLE role (
	id			INTEGER,
	type		INTEGER 	NOT NULL,
	CONSTRAINT pk_role PRIMARY KEY (id),
	CONSTRAINT uk_role_type UNIQUE (type)
);

CREATE TABLE user_role (
	user_id			INTEGER		 NOT NULL,
	role_id			INTEGER		 NOT NULL,
	CONSTRAINT fk_user_role_user_id FOREIGN KEY (user_id) REFERENCES "user" (id),
	CONSTRAINT fk_user_role_role_id FOREIGN KEY (role_id) REFERENCES role (id)
);

CREATE TABLE editorial_rating (
    id              INTEGER,
    user_id			INTEGER		 NOT NULL,
	editorial_id	INTEGER		 NOT NULL,
	value           INTEGER      NOT NULL,
    CONSTRAINT pk_editorial_rating PRIMARY KEY (id),
	CONSTRAINT fk_editorial_rating_user_id FOREIGN KEY (user_id) REFERENCES "user" (id),
	CONSTRAINT fk_editorial_raing_editorial_id FOREIGN KEY (editorial_id) REFERENCES editorial (id),
    CONSTRAINT uk_editorial_rating_user_editorial UNIQUE (user_id, editorial_id)
);
