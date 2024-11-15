\pset pager on

SET client_encoding = 'UTF8';

BEGIN;
\echo 'Creando el esquema para la BBDD de discos'

CREATE SCHEMA IF NOT EXISTS pl2t;

\echo 'Creando un esquema temporal'

\echo 'creando la tabla temporal canciones'
CREATE TABLE pl2t.canciones (
    id_del_disco text,
    titulo_de_la_cancion text,
    duracion text);

\echo 'creando la tabla temporal discos'
CREATE TABLE pl2t.discos (
    id_disco TEXT,
    nombre_del_disco text,
    fecha_de_lanzamiento text,
    id_grupo text,
    nombre_del_grupo text,
    url_del_grupo text,
    generos text,
    url_portada text);

\echo 'creando la tabla temporal ediciones'
CREATE TABLE pl2t.ediciones (
    id_del_disco TEXT,
    anno_de_la_edicion TEXT,
    pais_de_la_edicion TEXT,
    formato TEXT
);

\echo 'creando la tabla temporal generos'
CREATE TABLE pl2t.generos (
    anno_publicacion_genero TEXT,
    titulodisco TEXT,
    genero TEXT
);

\echo 'creando la tabla temporal grupo'
CREATE TABLE pl2t.grupo (
    nombre_grupo TEXT,
    URL TEXT
);

\echo 'creando la tabla temporal desea'
CREATE TABLE pl2t.desea (
    nombre_usuario TEXT,
    titulo_disco TEXT,
    anno_lanzamiento_disco TEXT
);

\echo 'creando la tabla temporal tiene'
CREATE TABLE pl2t.tiene (
    nombre_usuario TEXT,
    anno_lanzamiento TEXT,
    anno_edicion TEXT,
    pais_edicion TEXT,
    formato TEXT,
    estado TEXT
);

CREATE TABLE pl2t.usuarios (
	nombre_completo TEXT,
	nombre_usuario TEXT,
	email TEXT,
	password TEXT
);

\echo 'Cargando datos'

\copy pl2t.canciones from './canciones.csv' WITH (FORMAT csv, HEADER, DELIMITER ';', NULL 'NULL', ENCODING'UTF-8');

\copy pl2t.discos from './discos.csv' WITH (FORMAT csv, HEADER, DELIMITER ';', NULL 'NULL', ENCODING'UTF-8');

\copy pl2t.ediciones from './ediciones.csv' WITH (FORMAT csv, HEADER, DELIMITER ';', NULL 'NULL', ENCODING'UTF-8');

\copy pl2t.desea FROM './usuario_desea_disco.csv' WITH (FORMAT csv, HEADER, DELIMITER ';', NULL 'NULL', ENCODING 'UTF-8');

\copy pl2t.usuarios from './usuarios.csv' WITH (FORMAT csv, HEADER, DELIMITER ';', NULL 'NULL', ENCODING'UTF-8');

--\copy pl2t. from '~/clase/BDPL2/usuarios.csv' WITH (FORMAT csv, HEADER, DELIMITER ';', NULL 'NULL', ENCODING'UTF-8');

\echo 'insertando datos en el esquema final'

CREATE SCHEMA IF NOT EXISTS pl2final;

CREATE TABLE IF NOT EXISTS pl2final.usuarios (
	nombre_completo TEXT NOT NULL,
	nombre_usuario TEXT UNIQUE NOT NULL,
	email TEXT NOT NULL,
	password TEXT NOT NULL,
    CONSTRAINT usuario_pk PRIMARY KEY (nombre_usuario)
);

CREATE TABLE IF NOT EXISTS pl2final.grupo (

);

CREATE TABLE IF NOT EXISTS pl2final.discos (
    id_disco INTEGER NOT NULL UNIQUE,
    nombre_del_disco TEXT NOT NULL UNIQUE,
    fecha_de_lanzamiento INTEGER NOT NULL UNIQUE,
    id_grupo INTEGER NOT NULL,
    nombre_del_grupo TEXT NOT NULL,
    url_del_grupo TEXT NOT NULL,
    url_portada TEXT NOT NULL,
    CONSTRAINT fecha_valida CHECK (fecha_de_lanzamiento > 0),
    CONSTRAINT discos_pk PRIMARY KEY (fecha_de_lanzamiento, nombre_del_disco)
    --CONSTRAINT canciones_fk FOREIGN KEY (id_grupo) REFERENCES (pl2final.grupo)
);

CREATE TABLE IF NOT EXISTS pl2final.canciones (
    id_del_disco INTEGER NOT NULL,
    titulo_de_la_cancion TEXT NOT NULL,
    duracion TIME NOT NULL, --falta lo del formato hh:mm:ss
    CONSTRAINT canciones_pk PRIMARY KEY (titulo_de_la_cancion),
    CONSTRAINT canciones_fk FOREIGN KEY (id_del_disco) REFERENCES pl2final.discos(id_disco)
);

CREATE TABLE IF NOT EXISTS pl2final.ediciones (
    id_del_disco INTEGER NOT NULL,
    anno_de_la_edicion INTEGER NOT NULL,
    pais_de_la_edicion TEXT NOT NULL,
    formato TEXT NOT NULL,
    CONSTRAINT anno_valido CHECK (anno_de_la_edicion > 0),
    CONSTRAINT pais_valido CHECK (pais_de_la_edicion != 'None' AND pais_de_la_edicion != ''),
    CONSTRAINT ediciones_pk PRIMARY KEY (formato, anno_de_la_edicion, pais_de_la_edicion), 
    CONSTRAINT ediciones_fk FOREIGN KEY (id_del_disco) REFERENCES pl2final.discos(id_disco)
);

CREATE TABLE IF NOT EXISTS pl2final.generos (

);


CREATE TABLE IF NOT EXISTS pl2final.desea (
    nombre_usuario TEXT NOT NULL ,
    titulo_disco TEXT NOT NULL,
    anno_lanzamiento_disco INTEGER NOT NULL,
    CONSTRAINT anno_valido CHECK (anno_lanzamiento_disco > 0),
    CONSTRAINT desea_fk1 FOREIGN KEY (nombre_usuario) REFERENCES pl2final.usuarios(nombre_usuario),
    CONSTRAINT desea_fk2 FOREIGN KEY (titulo_disco) REFERENCES pl2final.discos(nombre_del_disco),
    CONSTRAINT desea_fk3 FOREIGN KEY (anno_lanzamiento_disco) REFERENCES pl2final.discos(fecha_de_lanzamiento)
);

CREATE TABLE IF NOT EXISTS pl2final.tiene (

);

\echo Formateando duracion

\echo Consulta 1: texto de la consulta

\echo Consulta n:

END
--ROLLBACK;                       -- importante! permite correr el script multiples veces...
