
DROP TABLE CANCION_GENERO CASCADE CONSTRAINTS;
DROP TABLE CANCION CASCADE CONSTRAINTS;
DROP TABLE ALBUM CASCADE CONSTRAINTS;
DROP TABLE SELLO CASCADE CONSTRAINTS;
DROP TABLE GENERO CASCADE CONSTRAINTS;
DROP TABLE ARTISTA CASCADE CONSTRAINTS;

--- empezar los drops por las debiles, y empezar los create por las fuertes ---


CREATE TABLE ARTISTA(
    id_artista NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    esta_verificado CHAR (1),
    biografia VARCHAR2(250)
);


CREATE TABLE GENERO(
    id_genero NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL UNIQUE
);


CREATE TABLE SELLO(
    id_sello NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL
);


CREATE TABLE ALBUM(
    id_album NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    titulo VARCHAR2(100) NOT NULL,
    fecha_lanzamiento DATE,
    id_sello NUMBER REFERENCES SELLO(id_sello)
);


CREATE TABLE CANCION(
    id_cancion NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    titulo VARCHAR2(200),
    id_artista NUMBER REFERENCES ARTISTA(id_artista),
    id_album NUMBER REFERENCES ALBUM(id_album),
    duracion_segundos NUMBER,
    fecha_lanzamiento DATE
);


CREATE TABLE CANCION_GENERO(
    id_cancion NUMBER REFERENCES CANCION(id_cancion),
    id_genero NUMBER REFERENCES GENERO(id_genero)
);

-- INSERTAR VALORES DE ARTISTA --
INSERT INTO ARTISTA(nombre, esta_verificado, biografia) VALUES ('Michael Jackson', 'S', 'Michael Joseph Jackson 
nació el 29 de agosto de 1958 en Gary, Indiana, y falleció el 25 de junio de 2009 en Los Ángeles. 
Fue un cantante, bailarín y compositor estadounidense conocido mundialmente como el «Rey del Pop»');

INSERT INTO ARTISTA(nombre, esta_verificado) VALUES ('31 Minutos', 'S');
INSERT INTO ARTISTA(nombre, esta_verificado) VALUES ('Los Prisioneros', 'S');
INSERT INTO ARTISTA(nombre, esta_verificado) VALUES ('Gustavo Cerati', 'S');
COMMIT;
SELECT * FROM ARTISTA;

-- INSERTAR VALORES DE GENERO --
INSERT INTO GENERO(nombre) VALUES ('Pop');
INSERT INTO GENERO(nombre) VALUES ('Rock');
INSERT INTO GENERO(nombre) VALUES ('Electronica');
INSERT INTO GENERO(nombre) VALUES ('Pop rock');
COMMIT;
SELECT * FROM GENERO;

--INSERTAR VALORES DE SELLO --
INSERT INTO SELLO(nombre) VALUES ('Epic Records');
INSERT INTO SELLO(nombre) VALUES ('Feria Music');
INSERT INTO SELLO(nombre) VALUES ('Universal Music Group');
INSERT INTO SELLO(nombre) VALUES ('Warner Music Group');
COMMIT;
SELECT * FROM SELLO;

--INSERTAR VALORES DE ALBUM --
INSERT INTO ALBUM(titulo, fecha_lanzamiento, id_sello) VALUES ('Thriller', DATE '1982-11-30', 1);
INSERT INTO ALBUM(titulo, fecha_lanzamiento, id_sello) VALUES ('31 minutos', DATE '2003-7-8', 2);
INSERT INTO ALBUM(titulo, fecha_lanzamiento, id_sello) VALUES ('La voz de los 80', DATE '1984-12-13', 3);
INSERT INTO ALBUM(titulo, fecha_lanzamiento, id_sello) VALUES ('Bocanada', DATE '1999-6-28', 4);
COMMIT;
SELECT * FROM ALBUM;

-- INSERTAR VALORES DE CANCION --
INSERT INTO CANCION(titulo, id_artista, id_album, duracion_segundos, fecha_lanzamiento) VALUES ('Thriller', 1, 1, 357, DATE '1984-1-23');
INSERT INTO CANCION(titulo, id_artista, id_album, duracion_segundos, fecha_lanzamiento) VALUES ('Bailan sin César', 2, 2, 113, DATE '2003-7-8');
INSERT INTO CANCION(titulo, id_artista, id_album, duracion_segundos, fecha_lanzamiento) VALUES ('La voz de los 80', 3, 3, 250, DATE '1984-12-13');
INSERT INTO CANCION(titulo, id_artista, id_album, duracion_segundos, fecha_lanzamiento) VALUES ('Puente', 4, 4, 274, DATE '1999-11-12');
COMMIT;
SELECT * FROM CANCION;

-- INSERTAR VALORES DE CANCION_GENERO --
INSERT INTO CANCION_GENERO(ID_CANCION,ID_GENERO) VALUES (1, 1);
INSERT INTO CANCION_GENERO(ID_CANCION,ID_GENERO) VALUES (2, 2);
INSERT INTO CANCION_GENERO(ID_CANCION,ID_GENERO) VALUES (3, 2);
INSERT INTO CANCION_GENERO(ID_CANCION,ID_GENERO) VALUES (4, 4);
COMMIT;
SELECT * FROM CANCION_GENERO;

