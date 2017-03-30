
/*Tablas de Nivel 3*/
DROP TABLE m.Incidente;
DROP TABLE m.Financiador_comp;


/*Tablas de Nivel 2*/
DROP TABLE m.Beca;
DROP TABLE m.Conforman;
DROP TABLE m.Viaja;
DROP TABLE m.Participa;
DROP TABLE m.Posee;
DROP TABLE m.Resuelve;

/*Tablas de Nivel 1*/
DROP TABLE m.Persona;
DROP TABLE m.Equipo;
DROP TABLE m.Competencia;
DROP TABLE m.Site;
DROP TABLE m.Problema;



DROP DOMAIN m.veinte_caracteres;
DROP DOMAIN m.ochenta_caracteres;
DROP DOMAIN m.diez_mil_caracteres;
DROP DOMAIN m.tipo_persona;
DROP DOMAIN m.nivel;
DROP DOMAIN m.dificultad;
DROP DOMAIN m.estatus;
DROP DOMAIN m.entero_mayor_igual_cero;
DROP DOMAIN m.entero_mayor_cero;



/*
REVOKE ALL ON SCHEMA m FROM admin;
REVOKE ALL ON SCHEMA m FROM estudiante;

DROP USER programador;
DROP USER coordinador;

DROP ROLE admin;
DROP ROLE estudiante;*/


DROP SCHEMA m;

\c postgres

DROP DATABASE proyecto;
