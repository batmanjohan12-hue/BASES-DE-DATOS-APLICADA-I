-- DROPS  DE TABLAS DEBILES (Dependientes) A FUERTES (Independientes) -- 

DROP TABLE VIDEO_CARACTERISTICA CASCADE CONSTRAINTS;
DROP TABLE VIDEO_TIPO CASCADE CONSTRAINTS;
DROP TABLE REACCION_VIDEO CASCADE CONSTRAINTS;
DROP TABLE SUSCRIPCION CASCADE CONSTRAINTS;
DROP TABLE COMENTARIO CASCADE CONSTRAINTS;
DROP TABLE VIDEO CASCADE CONSTRAINTS;
DROP TABLE CANAL CASCADE CONSTRAINTS;
DROP TABLE FORMATO_VIDEO CASCADE CONSTRAINTS;
DROP TABLE CARACTERISTICA_VIDEO CASCADE CONSTRAINTS;
DROP TABLE TIPO_VIDEO CASCADE CONSTRAINTS;
DROP TABLE USUARIO CASCADE CONSTRAINTS;

-- CREAMOS LAS TABLAS FUERTES PRIMEROS LUEGO TABLAS DEBILES --


-- TABLA USUARIO --
CREATE TABLE USUARIO(
id_usuario NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
nombre VARCHAR2(100) NOT NULL,
fecha_creacion DATE NOT NULL

);

-- TABLA TIPO_VIDEO --

CREATE TABLE TIPO_VIDEO(
    id_tipo_video NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(80) NOT NULL UNIQUE
);

-- TABLA CARATERISTICA VIDEO --

CREATE TABLE CARACTERISTICA_VIDEO(
    id_caracteristica NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(80) NOT NULL UNIQUE
);

-- TABLA FORMATO_VIDEO --
CREATE TABLE FORMATO_VIDEO (
    id_formato NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(30) NOT NULL UNIQUE
);

-- TABLA CANAL --

CREATE TABLE CANAL(
    id_canal NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_usuario NUMBER NOT NULL REFERENCES USUARIO(id_usuario),
    nombre VARCHAR2(250) NOT NULL,
    fecha_creacion DATE NOT NULL,
    cantidad_subcriptores NUMBER CHECK (cantidad_subcriptores >=0) NOT NULL,
    esta_verificado CHAR(1),
    cantidad_videos NUMBER CHECK (cantidad_videos >=0) NOT NULL,
    descripcion VARCHAR2 (300)
);

-- TABLA VIDEO --

CREATE TABLE VIDEO(
    id_video NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_canal NUMBER NOT NULL REFERENCES CANAL(id_canal),
    id_formato NUMBER NOT NULL REFERENCES FORMATO_VIDEO(id_formato),
    titulo VARCHAR2(150) NOT NULL,
    fecha_creacion DATE NOT NULL,
    cantidad_visualizaciones NUMBER CHECK (cantidad_visualizaciones >= 0) NOT NULL,
    cantidad_likes NUMBER CHECK (cantidad_likes >= 0) NOT NULL,
    cantidad_dislike NUMBER CHECK (cantidad_dislike >= 0) NOT NULL,
    descripcion VARCHAR2(400),
    duracion NUMBER NOT NULL,
    url_portada VARCHAR2(400) NOT NULL
);

-- TABLA COMENTARIO --

CREATE TABLE COMENTARIO(
    id_comentario NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_usuario NUMBER NOT NULL REFERENCES USUARIO(id_usuario),
    id_video NUMBER NOT NULL REFERENCES VIDEO(id_video),
    comentario VARCHAR2(500) NOT NULL,
    fecha_creacion DATE NOT NULL,
    cantidad_likes NUMBER CHECK (cantidad_likes >=0) NOT NULL,
    cantidad_dislike NUMBER CHECK (cantidad_dislike >= 0) NOT NULL
);
-- TABLAS N:M --

-- TABLA SUSCRIPCION --

CREATE TABLE SUSCRIPCION(
    id_usuario NUMBER NOT NULL REFERENCES USUARIO(id_usuario),
    id_canal NUMBER NOT NULL REFERENCES CANAL(id_canal),
    fecha_suscripcion DATE NOT NULL,
    PRIMARY KEY (id_usuario, id_canal)
);

-- TABLA REACCION_VIDEO
CREATE TABLE REACCION_VIDEO (
    id_usuario NUMBER NOT NULL REFERENCES USUARIO(id_usuario),
    id_video NUMBER NOT NULL REFERENCES VIDEO(id_video),
    tipo_reaccion VARCHAR2(10) NOT NULL CHECK (tipo_reaccion IN ('LIKE', 'DISLIKE')),
    PRIMARY KEY (id_usuario, id_video)
);

-- TABLA VIDEO_TIPO --
CREATE TABLE VIDEO_TIPO (
    id_video NUMBER NOT NULL REFERENCES VIDEO(id_video),
    id_tipo_video NUMBER NOT NULL REFERENCES TIPO_VIDEO(id_tipo_video),
    PRIMARY KEY (id_video, id_tipo_video)
);

-- TABLA VIDEO_CARACTERISTICA --
CREATE TABLE VIDEO_CARACTERISTICA (
    id_video NUMBER NOT NULL REFERENCES VIDEO(id_video),
    id_caracteristica NUMBER NOT NULL REFERENCES CARACTERISTICA_VIDEO(id_caracteristica),
    PRIMARY KEY (id_video, id_caracteristica)
);

-- LOS INSERT INTO --

-- 1. USUARIOS
INSERT INTO USUARIO (nombre, fecha_creacion) VALUES ('Jawed Karim', DATE '2005-04-22');
INSERT INTO USUARIO (nombre, fecha_creacion) VALUES ('Carlos Gamer', DATE '2022-04-19');
INSERT INTO USUARIO (nombre, FECHA_CREACION) VALUES ('Michael Jackson', DATE '2010-05-28');

-- CONFIRMAR CAMBIOS --
COMMIT;
-- SELECCIONAR TABLA --
SELECT * FROM USUARIO;

-- 2. CATÁLOGOS
INSERT INTO TIPO_VIDEO (nombre) VALUES ('Gameplay');
INSERT INTO TIPO_VIDEO (nombre) VALUES ('Tutorial');
INSERT INTO TIPO_VIDEO (nombre) VALUES ('Guía');
INSERT INTO TIPO_VIDEO (nombre) VALUES ('Musica');
INSERT INTO TIPO_VIDEO (nombre) VALUES ('Vlog');
COMMIT;
SELECT * FROM TIPO_VIDEO;


INSERT INTO CARACTERISTICA_VIDEO (nombre) VALUES ('HD');
INSERT INTO CARACTERISTICA_VIDEO (nombre) VALUES ('Subtítulos ES');
INSERT INTO CARACTERISTICA_VIDEO (nombre) VALUES ('4K');
INSERT INTO CARACTERISTICA_VIDEO (nombre) VALUES ('240p');

COMMIT;
SELECT * FROM CARACTERISTICA_VIDEO;

INSERT INTO FORMATO_VIDEO (nombre) VALUES ('Video Normal');
INSERT INTO FORMATO_VIDEO (nombre) VALUES ('Short');
INSERT INTO FORMATO_VIDEO (nombre) VALUES ('Directo');
COMMIT;
SELECT * FROM FORMATO_VIDEO;

-- 3. CANALES
INSERT INTO CANAL (id_usuario, nombre, fecha_creacion, cantidad_subcriptores, esta_verificado, cantidad_videos) 
VALUES (1, 'jawed', DATE '2005-04-23', 6650000, 'S', 1);
INSERT INTO CANAL (id_usuario, nombre, fecha_creacion, cantidad_subcriptores, esta_verificado, cantidad_videos, descripcion) 
VALUES (2, 'Carlos Gaming Channel', DATE '2023-01-16', 12000, 'N', 34, 'Canal sobre gameplays y guías.');
INSERT INTO CANAL (ID_USUARIO, nombre, fecha_creacion, CANTIDAD_SUBCRIPTORES, ESTA_VERIFICADO, CANTIDAD_VIDEOS, DESCRIPCION)
VALUES (3, 'Michael Jackson', DATE '2010-05-28', 41500000, 'S', 157, 'El rey del Pop');
COMMIT;
SELECT * FROM CANAL;

-- 4. VIDEOS
INSERT INTO VIDEO (id_canal, id_formato, titulo, fecha_creacion, cantidad_visualizaciones, cantidad_likes, cantidad_dislike, duracion, url_portada)
VALUES (1, 1, 'Me at the zoo', DATE '2005-04-23', 430000000, 19000000, 30000, 19, 'https://img.youtube.com/thumb1.jpg');
INSERT INTO VIDEO (id_canal, id_formato, titulo, fecha_creacion, cantidad_visualizaciones, cantidad_likes, cantidad_dislike, descripcion, duracion, url_portada) 
VALUES (2, 3, 'Directazo del año SQL + FNAF', DATE '2024-03-01', 450, 122, 5, 'Denle like al directo y compartan para poder comer chavales :).', 10800, 'https://img.youtube.com/caradesorprendidoomg2.jpg');
INSERT INTO VIDEO (id_canal, id_formato, titulo, fecha_creacion, cantidad_visualizaciones, cantidad_likes, cantidad_dislike, descripcion, duracion, url_portada) 
VALUES (3, 1, 'Liberian Girl', DATE '2012-09-17', 23440000, 270000, 0, 'Liberian Girl out now.', 232, 'https://img.youtube.com/portadaliberiangirl.jpg');
COMMIT;
SELECT * FROM VIDEO;

-- 5. COMENTARIOS
INSERT INTO COMENTARIO (id_usuario, id_video, comentario, fecha_creacion, cantidad_likes, cantidad_dislike) 
VALUES (2, 1, 'Increible que este sea el primer video de YT xd.', DATE '2025-08-21', 1240, 4);
COMMIT;
SELECT * FROM COMENTARIO;

-- 6. TABLAS DE RELACIÓN N:M
INSERT INTO SUSCRIPCION (id_usuario, id_canal, fecha_suscripcion) VALUES (1, 3, DATE '2014-02-12');
INSERT INTO SUSCRIPCION (id_usuario, id_canal, fecha_suscripcion) VALUES (2, 1, DATE '2025-08-21');
INSERT INTO SUSCRIPCION (id_usuario, id_canal, fecha_suscripcion) VALUES (2, 3, DATE '2023-01-21');
COMMIT;
SELECT * FROM SUSCRIPCION;

INSERT INTO REACCION_VIDEO (id_usuario, id_video, tipo_reaccion) VALUES (2, 1, 'LIKE');
INSERT INTO REACCION_VIDEO (id_usuario, id_video, tipo_reaccion) VALUES (1, 1, 'DISLIKE');
COMMIT;
SELECT * FROM REACCION_VIDEO;

INSERT INTO VIDEO_TIPO (id_video, id_tipo_video) VALUES (1, 3);
INSERT INTO VIDEO_TIPO (id_video, id_tipo_video) VALUES (1, 5);
INSERT INTO VIDEO_TIPO (id_video, id_tipo_video) VALUES (2, 1);
INSERT INTO VIDEO_TIPO (id_video, ID_TIPO_VIDEO) VALUES (2, 2);
INSERT INTO VIDEO_TIPO (id_video, id_tipo_video) VALUES (3, 4);
COMMIT;
SELECT * FROM VIDEO_TIPO;

INSERT INTO VIDEO_CARACTERISTICA (id_video, id_caracteristica) VALUES (1, 4);
INSERT INTO VIDEO_CARACTERISTICA (id_video, id_caracteristica) VALUES (1, 2);
INSERT INTO VIDEO_CARACTERISTICA (id_video, id_caracteristica) VALUES (2, 1);
INSERT INTO VIDEO_CARACTERISTICA (id_video, id_caracteristica) VALUES (3, 1);
COMMIT;
SELECT * FROM VIDEO_CARACTERISTICA;