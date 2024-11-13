\pset pager on

SET client_encoding = 'UTF8';

BEGIN;
\echo 'Creando el esquema para la BBDD de discos'

CREATE SCHEMA IF NOT EXISTS pl2t;

\echo 'Creando un esquema temporal'

\echo 'creando la tabla temporal canciones'
CREATE TABLE pl2t.canciones (
    id_del_disco text,
    Titulo_de_la_cancion text,
    duracion text);

\echo 'creando la tabla temporal discos'
CREATE TABLE pl2t.discos (
    id_disco TEXT,
    Nombre_del_disco text,
    fecha_de_lanzamiento text,
    id_grupo text,
    Nombre_del_grupo text,
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



SET search_path='nombre del esquema o esquemas utilizados';

\echo 'Cargando datos'

\copy pl2t.canciones from '~/clase/BDPL2/canciones.csv' WITH (FORMAT csv, HEADER, DELIMITER ';', NULL 'NULL', ENCODING'UTF-8');

\copy pl2t.discos from '~/clase/BDPL2/discos.csv' WITH (FORMAT csv, HEADER, DELIMITER ';', NULL 'NULL', ENCODING'UTF-8');

\copy pl2t.ediciones from '~/clase/BDPL2/ediciones.csv' WITH (FORMAT csv, HEADER, DELIMITER ';', NULL 'NULL', ENCODING'UTF-8');

\copy pl2t.desea FROM '~/clase/BDPL2/usuario_desea_disco.csv' WITH (FORMAT csv, HEADER, DELIMITER ';', NULL 'NULL', ENCODING 'UTF-8');

\copy pl2t.usuarios from '~/clase/BDPL2/usuarios.csv' WITH (FORMAT csv, HEADER, DELIMITER ';', NULL 'NULL', ENCODING'UTF-8');

--\copy pl2t. from '~/clase/BDPL2/usuarios.csv' WITH (FORMAT csv, HEADER, DELIMITER ';', NULL 'NULL', ENCODING'UTF-8');

\echo insertando datos en el esquema final

\echo Consulta 1: texto de la consulta

\echo Consulta n:

END
--ROLLBACK;                       -- importante! permite correr el script multiples veces...p
