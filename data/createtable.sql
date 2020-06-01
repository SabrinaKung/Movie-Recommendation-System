/*
CREATE TABLE movie(
	movie_name character varying,
	movie_day character varying NOT NULL,
	theater character varying NOT NULL,
	t_location character varying  NOT NULL,
	movie_time character varying NOT NULL,
	PRIMARY KEY( movie_name,theater,movie_day,movie_time )
)
CREATE TABLE actor(
	actor_name character varying,
	actor_id character varying NOT NULL,
	sex character varying not NULL,
	PRIMARY KEY(actor_id)
)

CREATE TABLE movie_type(
	movie_name character varying NOT NULL,
	type_name character varying NOT NULL,
	PRIMARY KEY(movie_name)
)

CREATE TABLE seat(
	t_name character varying NOT NULL,
	s_row character varying NOT NULL,
	s_column character varying NOT NULL,
	has_someone bool NOT NULL,
	PRIMARY KEY(t_name,s_row,s_column)
)

*/
CREATE TABLE customer(
	c_name character varying NOT NULL,
	c_phone character varying NOT NULL,
	c_id character varying NOT NULL,
	c_list int NOT NULL,
	m_name character varying NOT NULL,
	m_theater character varying NOT NULL,
	m_day character varying NOT NULL,
	m_time character varying NOT NULL,
	m_row character varying NOT NULL,
	m_column character varying NOT NULL,
	PRIMARY KEY(c_list)
)













