--- CREAR TABLA CONSOLA ---
CREATE TABLE consola(
    id_consola NUMBER(4) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_consola VARCHAR2(60) NOT NULL UNIQUE,
    tipo_consola VARCHAR2(20) NOT NULL CHECK(tipo_consola IN ('SOBREMESA', 'PORTATIL', 'HIBRIDA')),
    anio_lanzamiento NUMBER(4) NOT NULL CHECK(anio_lanzamiento BETWEEN 1983 AND 2030),
    precio_referencia_usd NUMBER(6,2) NOT NULL CHECK(precio_referencia_usd > 0),
    estado_fabricacion VARCHAR2 (15) DEFAULT 'ACTIVA' NOT NULL CHECK(estado_fabricacion IN ('ACTIVA', 'DESCONTINUADA'))
);

--- CREAR TABLA FRANQUICIA ---
CREATE TABLE franquicia(
    id_franquicia NUMBER(4) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_franquicia VARCHAR2(60) NOT NULL UNIQUE,
    creador_principal VARCHAR2(80),
    anio_debut NUMBER(4) NOT NULL CHECK(anio_debut >= 1980),
    estudio_principal VARCHAR2(60) DEFAULT 'NINTENDO EPD' NOT NULL
);

--- CREAR TABLA VIDEOJUEGO ---
CREATE TABLE videojuego(
    id_juego NUMBER(6) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    codigo_catalogo VARCHAR2(10) NOT NULL UNIQUE,
    titulo VARCHAR2(100) NOT NULL,
    id_franquincia NUMBER(4) NOT NULL REFERENCES franquicia(id_franquicia),
    id_consola NUMBER(4) NOT NULL REFERENCES consola(id_consola),
    clasificacion_esrb VARCHAR2(5) NOT NULL CHECK(clasificacion_esrb IN ('E', 'E10+', 'T', 'M')),
    precio_clp NUMBER(8) NOT NULL CHECK(precio_clp >= 0),
    puntaje_metacritic NUMBER(3) CHECK(puntaje_metacritic BETWEEN 0 AND 100),
    stock_fisico NUMBER(5) DEFAULT 0 NOT NULL CHECK(stock_fisico >= 0),
    fecha_lanzamiento DATE NOT NULL
);

--- CREAR TABLA JUGADOR ---
CREATE TABLE jugador(
    id_jugador NUMBER(6) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nickname VARCHAR2(30) NOT NULL UNIQUE,
    email VARCHAR2(100) NOT NULL UNIQUE,
    pais VARCHAR2(40) DEFAULT 'Chile' NOT NULL,
    monedas_oro NUMBER(6) DEFAULT 0 NOT NULL CHECK(monedas_oro >= 0),
    suscripcion_online VARCHAR2(15) DEFAULT 'GRATUITA' NOT NULL CHECK(suscripcion_online IN ('GRATUITA', 'INDIVIDUAL', 'FAMILIAR', 'EXPANSION')),
    id_juego_favorito NUMBER(6) REFERENCES videojuego(id_juego)

);

--- CREAR TABLA EXPERIMENTAL ACCESORIO_PRUEBA ---
CREATE TABLE accesorio_prueba(
    id_accesorio NUMBER(4) GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_accesorio VARCHAR2(40) NOT NULL,
    precio_usd NUMBER(5,2) NOT NULL CHECK(precio_usd > 0),
    id_consola NUMBER(4) NOT NULL REFERENCES consola(id_consola)
);

--- LOS ALTER TABLE Y SUS REGLAS DE NEGOCIO ---


--- ALTERAR TABLA JUGADOR ---
ALTER TABLE jugador ADD fecha_registro DATE DEFAULT SYSDATE NOT NULL;

--- ALTERAR TABLA JUGADOR ---
ALTER TABLE jugador ADD nivel_cuenta NUMBER(3) DEFAULT 1 NOT NULL CHECK(nivel_cuenta BETWEEN 1 AND 99);

--- MODIFICAR TABLA ACCESORIO PRUEBA ---
ALTER TABLE accesorio_prueba MODIFY nombre_accesorio VARCHAR2(100);

--- AGREGAR COLUMNA A ACCESORIO PRUEBA ---
ALTER TABLE accesorio_prueba ADD color_edicion VARCHAR2(25);

--- ELIMINAR COLUMNA A ACCESORIO PRUEBA ---
ALTER TABLE accesorio_prueba DROP COLUMN color_edicion;

--- ELIMINAR POR COMPLETO LA TABLA ACCESORIO_PRUEBA ---
DROP TABLE accesorio_prueba;

--- MODIFICAR TABLA VIDEOJUEGO ---
ALTER TABLE videojuego ADD descuento_porcentaje NUMBER(3) DEFAULT 0 NOT NULL CHECK(descuento_porcentaje BETWEEN 0 AND 80);


--- LOS INSERT INTO --- 


--- INSERTAR DATOS EN CONSOLA ---
INSERT INTO consola(nombre_consola, tipo_consola, anio_lanzamiento, precio_referencia_usd, estado_fabricacion)
VALUES ('Nintendo Switch', 'HIBRIDA', 2017, 299.99, 'ACTIVA');
COMMIT;

--- INSERTAR DATOS EN CONSOLA 2, 3 Y 4 ---
INSERT INTO consola(nombre_consola, tipo_consola, anio_lanzamiento, precio_referencia_usd)
VALUES ('Nintendo Switch 2', 'HIBRIDA', 2025, 449.99);
COMMIT;

INSERT INTO consola(nombre_consola, tipo_consola, anio_lanzamiento, precio_referencia_usd, estado_fabricacion)
VALUES ('Nintendo 3DS', 'PORTATIL', 2011, 169.99, 'DESCONTINUADA');
COMMIT;

INSERT INTO consola(nombre_consola, tipo_consola, anio_lanzamiento, precio_referencia_usd, estado_fabricacion)
VALUES ('Nintendo GameCube', 'SOBREMESA', 2001, 199.99, 'DESCONTINUADA');
COMMIT;

--- INSERTAR DATOS EN FRANQUICIA DEL ID 1---
INSERT INTO franquicia(nombre_franquicia, creador_principal, anio_debut)
VALUES ('Super Mario', 'Shigeru Miyamoto', 1985);
COMMIT;

--- ID 2 ---
INSERT INTO franquicia(nombre_franquicia, creador_principal, anio_debut)
VALUES ('The Legend of Zelda', 'Shigeru Miyamoto', 1986);
COMMIT;

--- ID 3 ---
INSERT INTO franquicia(nombre_franquicia, creador_principal, anio_debut, estudio_principal)
VALUES ('Pokemon', 'Satoshi Tajiri', 1996, 'Game Freak');
COMMIT;

--- ID 4 ---
INSERT INTO franquicia(nombre_franquicia, creador_principal, anio_debut, estudio_principal)
VALUES ('Metroid', 'Gunpei Yokoi', 1986, 'MercurySteam');
COMMIT;

--- ID 5 ---
INSERT INTO franquicia(nombre_franquicia, creador_principal, anio_debut, estudio_principal)
VALUES ('Super Smash Bros', 'Masahiro Sakurai', 1999, 'Bandai Namco / Sora');
COMMIT;

--- ID 6 ---
INSERT INTO franquicia(nombre_franquicia, creador_principal, anio_debut)
VALUES ('Splatoon', NULL, 2015);
COMMIT;


--- INSERTAR DATOS EN VIDEOJUEGO ID 1 ---
INSERT INTO videojuego(codigo_catalogo, titulo, id_franquincia, id_consola, clasificacion_esrb, precio_clp, puntaje_metacritic, stock_fisico, fecha_lanzamiento)
VALUES ('NSW-001', 'The Legend of Zelda: Breath of the Wild', 2, 1, 'E10+', 54990, 97, 45, TO_DATE('2017-03-03', 'YYYY-MM-DD'));
COMMIT;

--- ID 2 ---
INSERT INTO videojuego(codigo_catalogo, titulo, id_franquincia, id_consola, clasificacion_esrb, precio_clp, puntaje_metacritic, stock_fisico, fecha_lanzamiento)
VALUES ('NSW-002', 'Super Mario Odyssey', 1, 1, 'E10+', 49990, 97, 60, TO_DATE('2017-10-27', 'YYYY-MM-DD'));
COMMIT;

--- ID 3 ---
INSERT INTO videojuego(codigo_catalogo, titulo, id_franquincia, id_consola, clasificacion_esrb, precio_clp, puntaje_metacritic, stock_fisico, fecha_lanzamiento)
VALUES ('NSW-003', 'Metroid Dread', 4, 1, 'T', 44990, 88, 15, TO_DATE('2025-06-05', 'YYYY-MM-DD'));
COMMIT;

--- ID 4 ---
INSERT INTO videojuego(codigo_catalogo, titulo, id_franquincia, id_consola, clasificacion_esrb, precio_clp, puntaje_metacritic, stock_fisico, fecha_lanzamiento)
VALUES ('NSW-004', 'Super Smash Bros. Ultimate', 5, 1, 'E10+', 59990, 93, 80, TO_DATE('2018-12-07', 'YYYY-MM-DD'));
COMMIT;

--- ID 5 ---
INSERT INTO videojuego(codigo_catalogo, titulo, id_franquincia, id_consola, clasificacion_esrb, precio_clp, puntaje_metacritic, stock_fisico, fecha_lanzamiento)
VALUES ('NSW-005', 'Pokemon Escarlata', 3, 1, 'E', 49990, 72, 30, TO_DATE('2022-11-18', 'YYYY-MM-DD'));
COMMIT;

--- ID 6 ---
INSERT INTO videojuego(codigo_catalogo, titulo, id_franquincia, id_consola, clasificacion_esrb, precio_clp, puntaje_metacritic, fecha_lanzamiento)
VALUES ('NS2-001', 'Mario Kart World', 1, 2, 'E', 69990, NULL, TO_DATE('2025-06-05', 'YYYY-MM-DD'));
COMMIT;

--- ID 7 ---
INSERT INTO videojuego(codigo_catalogo, titulo, id_franquincia, id_consola, clasificacion_esrb, precio_clp, puntaje_metacritic, stock_fisico, fecha_lanzamiento)
VALUES ('3DS-001', 'Pokemon Sol', 3, 3, 'E', 29990, 87, 5, TO_DATE('2016-11-18', 'YYYY-MM-DD'));
COMMIT;



--- INSERTAR DATOS EN JUGADOR ID 1 ---
INSERT INTO jugador(nickname, email, monedas_oro, suscripcion_online, id_juego_favorito)
VALUES ('LinkHyrule99', 'link@hyrule.cl', 1200, 'EXPANSION', 1);
COMMIT;

--- ID 2 ---
INSERT INTO jugador(nickname, email, pais, monedas_oro, suscripcion_online, id_juego_favorito)
VALUES ('SamusHunter', 'samus@zebes.cl', 'Chile', 450, 'INDIVIDUAL', 3);
COMMIT;

--- ID 3 ---
INSERT INTO jugador(nickname, email, pais, id_juego_favorito)
VALUES ('PikaTrainer', 'ash@kanto.pe', 'Peru', NULL);
COMMIT;

--- ID 4 ---
INSERT INTO jugador(nickname, email, pais, monedas_oro, suscripcion_online, id_juego_favorito)
VALUES ('MarioSpeedrun', 'mario@champinon.ar', 'Argentina', 3500, 'FAMILIAR', 2);
COMMIT;



--- FALLOS 1 ---
INSERT INTO videojuego(codigo_catalogo, titulo, id_franquincia, id_consola, clasificacion_esrb, precio_clp, puntaje_metacritic, stock_fisico, fecha_lanzamiento)
VALUES ('NSW-008', 'The Legend of Zelda: Tears of the Kingdom', 2, 1, 'E10+', 64990, 96, 50, TO_DATE('2023-05-12', 'YYYY-MM-DD'));
COMMIT;

--- FALLOS 2 ---
INSERT INTO videojuego(codigo_catalogo, titulo, id_franquincia, id_consola, clasificacion_esrb, precio_clp, puntaje_metacritic, stock_fisico, fecha_lanzamiento)
VALUES ('GCN-001', 'Super Smash Bros. Melee', 5, 4, 'T', 39990, 92, 0, TO_DATE('2001-11-21', 'YYYY-MM-DD'));
COMMIT;

--- FALLOS 3 ---
INSERT INTO jugador(nickname, email, pais, monedas_oro, suscripcion_online, id_juego_favorito)
VALUES ('ZeldaWisdom', 'zelda@hyrule.cl', 'Chile', 800, 'EXPANSION', 9);
COMMIT;

INSERT INTO jugador(nickname, email, pais, monedas_oro, suscripcion_online, id_juego_favorito)
VALUES ('KirbyGourmet', 'kirby@dreamland.mx', 'Mexico', 150, 'GRATUITA', NULL);
COMMIT;

--- INSERCIONES DE REGISTRO TEMPORALES ---
INSERT INTO videojuego(codigo_catalogo, titulo, id_franquincia, id_consola, clasificacion_esrb, precio_clp, puntaje_metacritic, stock_fisico, fecha_lanzamiento)
VALUES ('NSW-999', 'Proyecto Secreto Cancelado', 6, 1, 'T', 10000, NULL, 0, SYSDATE);
COMMIT;

INSERT INTO jugador(nickname, email, pais, monedas_oro, suscripcion_online, id_juego_favorito)
VALUES ('BotSpam01', 'spam@bot.com', 'Desconocido', 0, 'GRATUITA', 13);
COMMIT;


--- LOS UPDATE ---
UPDATE videojuego SET STOCK_FISICO = 75 WHERE id_juego = 5;
COMMIT;

UPDATE jugador SET SUSCRIPCION_ONLINE = 'INDIVIDUAL' WHERE ID_JUGADOR = 3;
COMMIT;

UPDATE videojuego SET PUNTAJE_METACRITIC = 94, stock_fisico = 120 WHERE ID_JUEGO = 6;
COMMIT;

UPDATE jugador SET monedas_oro = monedas_oro + 250 WHERE pais = 'Chile';
COMMIT;

UPDATE videojuego SET precio_clp = ROUND(precio_clp * 0.85) WHERE id_consola = 1 AND precio_clp > 50000;
COMMIT;

UPDATE franquicia SET ESTUDIO_PRINCIPAL = 'Nintendo EPD Kyoto' WHERE id_franquicia IN (1, 2);
COMMIT;

UPDATE videojuego SET stock_fisico = stock_fisico + 30 WHERE ID_CONSOLA = 1 AND STOCK_FISICO BETWEEN 1 AND 20;
COMMIT;


--- PONIENDO A PRUEBA EL CHECK EN UN UPDATE (Evitando Saldo Negativo) ---
UPDATE jugador SET MONEDAS_ORO = MONEDAS_ORO - 150 WHERE id_jugador = 7;
COMMIT;

--- Desvincular Clave Foránea (Preparación para Borrado) ---
UPDATE jugador SET id_juego_favorito = NULL WHERE ID_JUEGO_FAVORITO = 13;
COMMIT;

--- Bonificación Premium con OR, Paréntesis e IS NOT NULL  DATO = SE PUEDE HACER CON OR = WHERE (suscripcion_online = 'EXPANSION' OR suscripcion_online = 'FAMILIAR') Y EL IS NOT NULL QUIERE DECIR QUE NO TENGA NULL EN ESE CAMPO CONCRETO ---
UPDATE jugador SET monedas_oro = monedas_oro + 500 WHERE SUSCRIPCION_ONLINE IN ('EXPANSION', 'FAMILIAR') AND ID_JUEGO_FAVORITO IS NOT NULL;
COMMIT;



--- LOS DELETE ---

DELETE FROM jugador WHERE id_jugador = 10;
COMMIT;

--- Eliminar Videojuego Cancelado por su Código de Catálogo ---
DELETE FROM videojuego WHERE codigo_catalogo = 'NSW-999';
COMMIT;

--- Eliminar Franquicia sin Videojuegos Asociados ---
DELETE FROM franquicia WHERE id_franquicia = 6; 
COMMIT;


--- Experimento de Bloqueo Referencial (ORA-02292) y Borrado de Consola --- 
DELETE FROM consola WHERE id_consola = 1;

INSERT INTO consola(nombre_consola, tipo_consola, anio_lanzamiento, precio_referencia_usd, estado_fabricacion)
VALUES ('Virtual Boy', 'PORTATIL', 1995, 179.99, 'DESCONTINUADA');
COMMIT;

DELETE FROM consola WHERE id_consola = 21;
COMMIT;

--- Limpieza de Catálogo Retro Sin Stock (Condición AND) ---
DELETE FROM videojuego WHERE id_consola = 4 AND stock_fisico = 0;
COMMIT; 

--- Depuración de Cuentas Inactivas (Múltiples Condiciones e IS NULL) ---
DELETE FROM jugador WHERE suscripcion_online = 'GRATUITA' AND monedas_oro = 0 AND id_juego_favorito IS NULL;
COMMIT;

--- Eliminar Videojuegos Antiguos por Fecha (TO_DATE) ---
DELETE FROM videojuego WHERE fecha_lanzamiento < TO_DATE('2017-01-01', 'YYYY-MM-DD') AND stock_fisico < 10;
COMMIT;

--- Eliminación de Consolas Descontinuadas Liberadas ---
DELETE FROM consola WHERE estado_fabricacion = 'DESCONTINUADA' AND anio_lanzamiento < 2015;
COMMIT;


--- Simulacro de Emergencia: Rescate con ROLLBACK ---
COMMIT;

DELETE FROM jugador;
SELECT * FROM jugador;
ROLLBACK;
SELECT * FROM jugador;

--- Purga por Patrón de Texto (LIKE) y Clasificación ESRB ---
INSERT INTO videojuego(codigo_catalogo, titulo, id_franquincia, id_consola, clasificacion_esrb, precio_clp, stock_fisico, fecha_lanzamiento)
VALUES ('NSW-120', 'DEMO: Metroid Prime 4', 4, 1, 'M', 0, 0, SYSDATE);
COMMIT;

DELETE FROM videojuego WHERE titulo LIKE 'DEMO:%' AND precio_clp = 0;
COMMIT;
SELECT * FROM videojuego;




--- Catálogo Básico con Proyección y Alias (AS) ---
SELECT codigo_catalogo AS codigo, titulo AS nombre_videojuego, clasificacion_esrb AS esrb, precio_clp AS precio_actual FROM VIDEOJUEGO;


--- Columnas Calculadas: Precio con IVA y Conversión a Dólares ---
SELECT titulo, precio_clp, ROUND(precio_clp * 1.19) AS precio_con_iva, ROUND(precio_clp / 950, 2) AS precio_estimado_usd FROM videojuego;

--- Ranking de Obras Maestras (WHERE + ORDER BY Múltiple) ---
SELECT titulo, puntaje_metacritic, precio_clp FROM videojuego WHERE puntaje_metacritic >= 90 ORDER BY puntaje_metacritic DESC, titulo ASC;

--- Filtro de Inventario Familiar (IN + BETWEEN) ---
SELECT titulo, clasificacion_esrb, stock_fisico FROM videojuego WHERE clasificacion_esrb IN('E', 'E10+') AND stock_fisico BETWEEN 40 AND 150; 

--- Buscador de Sagas con LIKE y Condiciones Agrupadas ---
SELECT codigo_catalogo, titulo, precio_clp FROM videojuego WHERE (titulo LIKE '%Zelda%' OR titulo LIKE '%Mario%') AND precio_clp < 60000;

--- Reporte Estadístico Global (Funciones de Agregación) --- 
SELECT COUNT(*) AS total_juegos, ROUND(AVG(puntaje_metacritic), 1) AS promedio_metacritic, MIN(precio_clp) AS precio_minimo, MAX(precio_clp) AS precio_maximo, SUM(stock_fisico) AS total_stock_fisico FROM videojuego;



--- INNER JOIN: Videojuegos con el Nombre de su Franquicia ---
SELECT v.titulo, f.nombre_franquicia, f.creador_principal, v.precio_clp
FROM videojuego v
INNER JOIN franquicia f ON id_franquincia = f.id_franquicia
ORDER BY f.nombre_franquicia ASC;


--- INNER JOIN de 3 Tablas: Catálogo Completo (Juego + Franquicia + Consola) ---
SELECT v.codigo_catalogo, v.titulo, f.nombre_franquicia, c.nombre_consola, v.puntaje_metacritic
FROM videojuego v
INNER JOIN franquicia f ON id_franquincia = f.id_franquicia
INNER JOIN consola c ON v.id_consola = c.id_consola
WHERE c.nombre_consola = 'Nintendo Switch';

--- INNER JOIN: Jugadores de My Nintendo y su Videojuego Favorito ---
SELECT j.nickname, j.pais, j.suscripcion_online, j.monedas_oro, v.titulo
FROM jugador j
INNER JOIN videojuego v ON j.id_juego_favorito = v.id_juego
ORDER BY j.monedas_oro;



--- El Jefe Final: INNER JOIN + GROUP BY + Funciones de Agregación ---
SELECT f.nombre_franquicia, COUNT(v.id_juego) AS cantidad_juegos, ROUND(AVG(v.puntaje_metacritic), 1) AS promedio_metacritic, SUM(v.stock_fisico) AS stock_total
FROM franquicia f
INNER JOIN videojuego v ON id_franquincia = f.id_franquicia
GROUP BY f.nombre_franquicia
ORDER BY stock_total DESC;