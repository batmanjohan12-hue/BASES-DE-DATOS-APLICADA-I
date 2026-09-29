-- DROPS --

DROP TABLE  CASCADE CONSTRAINTS;
DROP TABLE CASCADE CONSTRAINTS;
DROP TABLE  CASCADE CONSTRAINTS;
DROP TABLE  CASCADE CONSTRAINTS;
DROP TABLE  CASCADE CONSTRAINTS;
DROP TABLE  CASCADE CONSTRAINTS;




-- CREAMOS LAS TABLAS FUERTES PRIMEROS LUEGO TABLAS DEBILES --


-- TABLA USUARIO --
CREATE TABLE USUARIO(
id_usuario NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
nombre VARCHAR2(100) NOT NULL,
fecha_creacion DATE

);

-- TABLA CANAL --

CREATE TABLE CANAL(
    id_canal NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(250) NOT NULL,
    fecha_inicio DATE,
    cantidad_subcriptores NUMBER CHECK (cantidad_subcriptores >=0),
    esta_verificado CHAR(1),
    cantidad_videos NUMBER CHECK (cantidad_videos >=0),
    descripcion VARCHAR2(300)

);

-- TABLA VIDEO --

CREATE TABLE VIDEO(
    id_video NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    titulo VARCHAR2(150) NOT NULL,
    fecha_creacion DATE,
    cantidad_vizualicaciones NUMBER CHECK (cantidad_vizualicaciones >= 0),
    cantidad_likes NUMBER CHECK (cantidad_likes >= 0),
    cantidad_dislike NUMBER CHECK (cantidad_dislike >= 0),
    descripcion VARCHAR2(400),
    duracion NUMBER,
    url_portada NUMBER NOT NULL,
    id_canal REFERENCES CANAL(id_canal)

);

-- TABLA TIPO_VIDEO --

CREATE TABLE TIPO_VIDEO(
    id_tipo_video NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(80) NOT NULL UNIQUE,
    id_video NUMBER REFERENCES VIDEO(id_video)

);

-- TABLA CARATERISTICA VIDEO --

CREATE TABLE CARATERISTICA_VIDEO(
    id_carateristica_video NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(80) NOT NULL UNIQUE,
    id_video NUMBER REFERENCES VIDEO(id_video)

);

-- TABLA COMENTARIO --

CREATE TABLE COMENTARIO(
    id_comentario NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    comentario VARCHAR2(500) NOT NULL,
    fecha_creacion DATE,
    cantidad_likes NUMBER CHECK (cantidad_likes >=0),
    cantidad_dislike NUMBER CHECK (cantidad_dislike >= 0),
    id_usuario NUMBER REFERENCES USUARIO(id_usuario),
    id_video NUMBER REFERENCES VIDEO(id_video)

);

-- TABLA 

