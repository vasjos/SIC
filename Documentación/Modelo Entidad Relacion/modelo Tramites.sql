-- DROP SCHEMA tramites;

CREATE SCHEMA tramites AUTHORIZATION postgres;

-- DROP TYPE tramites."_dependencia";

CREATE TYPE tramites."_dependencia" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = tramites.dependencia,
	DELIMITER = ',');

-- DROP TYPE tramites."_descripciontramites";

CREATE TYPE tramites."_descripciontramites" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = tramites.descripciontramites,
	DELIMITER = ',');

-- DROP TYPE tramites."_documentos";

CREATE TYPE tramites."_documentos" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = tramites.documentos,
	DELIMITER = ',');

-- DROP TYPE tramites."_empleado";

CREATE TYPE tramites."_empleado" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = tramites.empleado,
	DELIMITER = ',');

-- DROP TYPE tramites."_persona";

CREATE TYPE tramites."_persona" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = tramites.persona,
	DELIMITER = ',');

-- DROP TYPE tramites."_tramite";

CREATE TYPE tramites."_tramite" (
	INPUT = array_in,
	OUTPUT = array_out,
	RECEIVE = array_recv,
	SEND = array_send,
	ANALYZE = array_typanalyze,
	ALIGNMENT = 8,
	STORAGE = any,
	CATEGORY = A,
	ELEMENT = tramites.tramite,
	DELIMITER = ',');

-- DROP TYPE tramites.dependencia;

CREATE TYPE tramites.dependencia AS (
	iddependencia int4,
	nombre varchar(80));

-- DROP TYPE tramites.descripciontramites;

CREATE TYPE tramites.descripciontramites AS (
	iddescripciontramite int4,
	descripcion varchar(50));

-- DROP TYPE tramites.documentos;

CREATE TYPE tramites.documentos AS (
	tipodocumento int4,
	descripcion varchar(50));

-- DROP TYPE tramites.empleado;

CREATE TYPE tramites.empleado AS (
	idempleado int4,
	iddependencia int4,
	fechaingreso date);

-- DROP TYPE tramites.persona;

CREATE TYPE tramites.persona AS (
	idpersona int4,
	tipodocumento int4,
	numeroidentificacion varchar(20),
	nombres varchar(100),
	apellidos varchar(100),
	telefono bpchar(20),
	direccion varchar(300),
	email varchar(100));

-- DROP TYPE tramites.tramite;

CREATE TYPE tramites.tramite AS (
	idtramite int4,
	numero int4,
	añoradicacion int4,
	iddescripciontramite int4,
	descripcion varchar(200),
	idpersona int4,
	idfuncionario int4);

-- DROP SEQUENCE tramites.persona_idpersona_seq;

CREATE SEQUENCE tramites.persona_idpersona_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;
-- DROP SEQUENCE tramites.tramite_idtramite_seq;

CREATE SEQUENCE tramites.tramite_idtramite_seq
	INCREMENT BY 1
	MINVALUE 1
	MAXVALUE 2147483647
	START 1
	CACHE 1
	NO CYCLE;-- tramites.dependencia definition

-- Drop table

-- DROP TABLE tramites.dependencia;

CREATE TABLE tramites.dependencia (
	iddependencia int4 NOT NULL,
	nombre varchar(80) NOT NULL,
	CONSTRAINT dependencia_pkey PRIMARY KEY (iddependencia)
);


-- tramites.descripciontramites definition

-- Drop table

-- DROP TABLE tramites.descripciontramites;

CREATE TABLE tramites.descripciontramites (
	iddescripciontramite int4 NOT NULL, -- id
	descripcion varchar(50) NULL, -- descripcion
	CONSTRAINT descripciontramites_pk PRIMARY KEY (iddescripciontramite)
);

-- Column comments

COMMENT ON COLUMN tramites.descripciontramites.iddescripciontramite IS 'id';
COMMENT ON COLUMN tramites.descripciontramites.descripcion IS 'descripcion';


-- tramites.documentos definition

-- Drop table

-- DROP TABLE tramites.documentos;

CREATE TABLE tramites.documentos (
	tipodocumento int4 NOT NULL,
	descripcion varchar(50) NULL,
	CONSTRAINT documentos_pk PRIMARY KEY (tipodocumento)
);


-- tramites.persona definition

-- Drop table

-- DROP TABLE tramites.persona;

CREATE TABLE tramites.persona (
	idpersona int4 NOT NULL GENERATED ALWAYS AS IDENTITY, -- Campo Llave
	tipodocumento int4 NOT NULL, -- Tipo de Identificacion
	numeroidentificacion varchar(20) NOT NULL, -- Numero de identificacion
	nombres varchar(100) NOT NULL, -- Nombres
	apellidos varchar(100) NULL, -- Apellidos
	telefono bpchar(20) NULL, -- Telefono
	direccion varchar(300) NULL, -- Direccion
	email varchar(100) NULL, -- Email
	CONSTRAINT persona_pk PRIMARY KEY (idpersona),
	CONSTRAINT persona_fk FOREIGN KEY (tipodocumento) REFERENCES tramites.documentos(tipodocumento)
);

-- Column comments

COMMENT ON COLUMN tramites.persona.idpersona IS 'Campo Llave';
COMMENT ON COLUMN tramites.persona.tipodocumento IS 'Tipo de Identificacion';
COMMENT ON COLUMN tramites.persona.numeroidentificacion IS 'Numero de identificacion';
COMMENT ON COLUMN tramites.persona.nombres IS 'Nombres';
COMMENT ON COLUMN tramites.persona.apellidos IS 'Apellidos';
COMMENT ON COLUMN tramites.persona.telefono IS 'Telefono';
COMMENT ON COLUMN tramites.persona.direccion IS 'Direccion';
COMMENT ON COLUMN tramites.persona.email IS 'Email';


-- tramites.empleado definition

-- Drop table

-- DROP TABLE tramites.empleado;

CREATE TABLE tramites.empleado (
	idempleado int4 NOT NULL, -- Llave foranea de pesonas
	iddependencia int4 NOT NULL,
	fechaingreso date NOT NULL, -- fecha ingreso
	CONSTRAINT empleado_pk PRIMARY KEY (idempleado),
	CONSTRAINT dependencia_fk FOREIGN KEY (iddependencia) REFERENCES tramites.dependencia(iddependencia),
	CONSTRAINT empleado_fk FOREIGN KEY (iddependencia) REFERENCES tramites.dependencia(iddependencia),
	CONSTRAINT persona_fk FOREIGN KEY (idempleado) REFERENCES tramites.persona(idpersona)
);

-- Column comments

COMMENT ON COLUMN tramites.empleado.idempleado IS 'Llave foranea de pesonas';
COMMENT ON COLUMN tramites.empleado.fechaingreso IS 'fecha ingreso';


-- tramites.tramite definition

-- Drop table

-- DROP TABLE tramites.tramite;

CREATE TABLE tramites.tramite (
	idtramite int4 NOT NULL GENERATED ALWAYS AS IDENTITY,
	numero int4 NOT NULL,
	añoradicacion int4 NOT NULL,
	iddescripciontramite int4 NOT NULL,
	descripcion varchar(200) NULL,
	idpersona int4 NOT NULL,
	idfuncionario int4 NOT NULL,
	CONSTRAINT tramite_pkey PRIMARY KEY (idtramite),
	CONSTRAINT tramitefuncionario_fk FOREIGN KEY (idfuncionario) REFERENCES tramites.empleado(idempleado),
	CONSTRAINT tramitepersona_fk FOREIGN KEY (idpersona) REFERENCES tramites.persona(idpersona)
);
