/* Crear una Base de Datos */

CREATE DATABASE proyecto TEMPLATE template1;

/* Conexión a la base de datos */

\c proyecto

/* Crear un esquema dentro de la base de datos*/

CREATE SCHEMA m;

/* Crear dominios */

/* DOMINIOS */
CREATE DOMAIN m.veinte_caracteres varchar(20);
CREATE DOMAIN m.ochenta_caracteres varchar(60);
CREATE DOMAIN m.diez_mil_caracteres varchar(10000);
CREATE DOMAIN m.tipo_persona varchar(20)
		CHECK(VALUE IN('Coach','Tecnico','Estudiante'));
CREATE DOMAIN m.nivel varchar(10)
		CHECK (VALUE IN('Local','Nacional','Regional','Mundial'));
CREATE DOMAIN m.dificultad varchar(10)
		CHECK (VALUE IN('facil','medio','dificil'));
CREATE DOMAIN m.estatus varchar(10)
		CHECK (VALUE IN('campeon','subcampeon','eliminado'));
CREATE DOMAIN m.entero_mayor_igual_cero int
		CHECK(VALUE >= 0);
CREATE DOMAIN m.entero_mayor_cero int
		CHECK(VALUE > 0);

/**************************/
/*    Tablas primarias    */
/*________________________*/

CREATE TABLE m.Persona (
	ci 			int			PRIMARY KEY,
	nombre			m.ochenta_caracteres	NOT NULL,
	fecha_nac		date			NOT NULL,
	nacionalidad		m.ochenta_caracteres	NOT NULL,
	correo			m.ochenta_caracteres	NOT NULL,
	telefono		m.ochenta_caracteres	NOT NULL,
	tipo_p			m.tipo_persona		NOT NULL,
	carrera			m.ochenta_caracteres,
	cargo_universitario	m.ochenta_caracteres,
	preparacion		m.ochenta_caracteres,
	area_experticia		m.ochenta_caracteres
);

CREATE TABLE m.Equipo (
	nombre_e	m.ochenta_caracteres	NOT NULL,
	año_e		int			NOT NULL,
	PRIMARY KEY(nombre_e,año_e)
);

CREATE TABLE m.Site (
	pais_s		m.ochenta_caracteres	NOT NULL,
	ubicacion_s	m.ochenta_caracteres	NOT NULL,
	direccion_s	m.ochenta_caracteres	NOT NULL,
	nombre_s	m.ochenta_caracteres	NOT NULL,
	PRIMARY KEY(pais_s,ubicacion_s,direccion_s)
);

CREATE TABLE m.Competencia (
	nombre_c 	m.ochenta_caracteres	NOT NULL,
	año_c		int			NOT NULL,
	region		m.ochenta_caracteres,
	nivel		m.nivel			NOT NULL,
	dia		int			NOT NULL,
	mes		m.veinte_caracteres	NOT NULL,
	PRIMARY KEY(nombre_c,año_c)
);

CREATE TABLE m.Problema (
	nombre_prob m.nombre_prob PRIMARY KEY	NOT NULL,
	enunciado	m.diez_mil_caracteres	NOT NULL,
	dificultad	m.dificultad		NOT NULL,
);

/**************************/
/*   Tablas secundarias   */
/*________________________*/

CREATE TABLE m.Beca (
	ci_b 		int			NOT NULL, 
	tipo_beca 	m.ochenta_caracteres	NOT NULL,
	PRIMARY KEY(ci_b,tipo_beca),
	FOREIGN KEY(ci_b) REFERENCES m.Persona
			ON UPDATE CASCADE	ON DELETE CASCADE
);

CREATE TABLE m.Conforman (
	ci_conf 	int			NOT NULL, 
	nombre_e_conf 	m.ochenta_caracteres	NOT NULL,
	año_e_conf	int			NOT NULL,
	PRIMARY KEY(ci_conf,nombre_e_conf,año_e_conf),
	FOREIGN KEY(ci_conf) REFERENCES m.Persona
			ON UPDATE CASCADE	ON DELETE CASCADE,
	FOREIGN KEY(nombre_e_conf,año_e_conf) REFERENCES m.Equipo
			ON UPDATE CASCADE	ON DELETE CASCADE
);

CREATE TABLE m.Viaja (
	ci_v	 	int			NOT NULL, 
	nombre_c_v 	m.ochenta_caracteres	NOT NULL,
	año_c_v		int			NOT NULL,
	fecha_v		date			NOT NULL,
	hospedaje	m.ochenta_caracteres	NOT NULL,
	PRIMARY KEY(ci_v,nombre_c_v,año_c_v),
	FOREIGN KEY(ci_v) REFERENCES m.Persona
			ON UPDATE CASCADE	ON DELETE CASCADE,
	FOREIGN KEY(nombre_c_v,año_c_v) REFERENCES m.Competencia
			ON UPDATE CASCADE	ON DELETE CASCADE
);

CREATE TABLE m.Incidente (
	ci_v_i	 	int			NOT NULL, 
	nombre_c_v_i 	m.ochenta_caracteres	NOT NULL,
	año_c_v_i	int			NOT NULL,
	tipo_incidente	m.ochenta_caracteres	NOT NULL,
	PRIMARY KEY(ci_v_i,nombre_c_v_i,año_c_v_i,tipo_incidente),
	FOREIGN KEY(ci_v_i,nombre_c_v_i,año_c_v_i) REFERENCES m.Viaja
			ON UPDATE CASCADE	ON DELETE CASCADE
);

CREATE TABLE m.Participa (
	nombre_e_part		m.ochenta_caracteres	NOT NULL,
	año_e_part 		int			NOT NULL,
	pais_s_part		m.ochenta_caracteres	NOT NULL,
	ubicacion_s_part	m.ochenta_caracteres	NOT NULL,
	direccion_s_part	m.ochenta_caracteres	NOT NULL,
	nombre_c_part		m.ochenta_caracteres	NOT NULL,
	año_c_part		int			NOT NULL,
	estatus			m.estatus		NOT NULL,
	posicion_ranking	m.ochenta_caracteres	NOT NULL,
	PRIMARY KEY(nombre_e_part,año_e_part,pais_s_part,ubicacion_s_part,direccion_s_part,
		    nombre_c_part,año_c_part),
	FOREIGN KEY(nombre_e_part,año_e_part) REFERENCES m.Equipo
			ON UPDATE CASCADE	ON DELETE CASCADE,
	FOREIGN KEY(pais_s_part,ubicacion_s_part,direccion_s_part) REFERENCES m.Site
			ON UPDATE CASCADE	ON DELETE CASCADE,
	FOREIGN KEY(nombre_c_part,año_c_part) REFERENCES m.Competencia
			ON UPDATE CASCADE	ON DELETE CASCADE
);

CREATE TABLE m.Financiador_comp (
	nombre_e_part_f		m.ochenta_caracteres	NOT NULL,
	año_e_part_f 		int			NOT NULL,
	pais_s_part_f		m.ochenta_caracteres	NOT NULL,
	ubicacion_s_part_f	m.ochenta_caracteres	NOT NULL,
	direccion_s_part_f	m.ochenta_caracteres	NOT NULL,
	nombre_c_part_f		m.ochenta_caracteres	NOT NULL,
	año_c_part_f		int			NOT NULL,
	financiador		m.ochenta_caracteres	NOT NULL,
	PRIMARY KEY(nombre_e_part_f,año_e_part_f,pais_s_part_f,ubicacion_s_part_f,
		    direccion_s_part_f,nombre_c_part_f,año_c_part_f,financiador),
	FOREIGN KEY(nombre_e_part_f,año_e_part_f,pais_s_part_f,ubicacion_s_part_f,
		    direccion_s_part_f,nombre_c_part_f,año_c_part_f) REFERENCES m.Participa
			ON UPDATE CASCADE	ON DELETE CASCADE
);

CREATE TABLE m.Posee (
	nombre_prob_p	m.ochenta_caracteres	NOT NULL,
	nombre_c_p	m.ochenta_caracteres	NOT NULL,
	año_c_p		int			NOT NULL,
	PRIMARY KEY(nombre_prob_p,nombre_c_p,año_c_p),
	FOREGIN KEY(nombre_prob_p) REFERENCES m.Problema
			ON UPDATE CASCADE	ON DELETE CASCADE,
	FOREIGN KEY(nombre_c_p,año_c_p) REFERENCES m.Competencia
			ON UPDATE CASCADE	ON DELETE CASCADE
);

CREATE TABLE m.Resuelve (
	nombre_prob_r	m.ochenta_caracteres	NOT NULL,
	nombre_e_r	m.ochenta_caracteres	NOT NULL,
	año_e_r		int			NOT NULL,
	tiempo		m.ochenta_caracteres	NOT NULL,
	PRIMARY KEY(nombre_prob_r,nombre_e_r,año_e_r),
	FOREIGN KEY(nombre_prob_r) REFERENCES m.Problema
			ON UPDATE CASCADE	ON DELETE CASCADE,
	FOREIGN KEY(nombre_e_r,año_e_r) REFERENCES m.Equipo
			ON UPDATE CASCADE	ON DELETE CASCADE
);

