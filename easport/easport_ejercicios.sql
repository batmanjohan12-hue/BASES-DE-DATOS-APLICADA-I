-- #1 Mostrar todas las columnas y filas de la tabla regiones.
SELECT * FROM REGIONES;

-- #2 Mostrar únicamente el nombre, el rol y el origen_lore de todos los agentes.
SELECT nombre, rol, origen_lore FROM agentes;

-- #3 Mostrar el nickname, nombre_real y sueldo_mensual de los jugadores con los alias jugador, nombre_completo y salario_usd.
SELECT nickname AS Alias_jugador, nombre_real AS nombre_completo, sueldo_mensual AS salario_usd FROM JUGADORES;

-- #4 Mostrar el nickname, el sueldo_mensual y una columna calculada llamada sueldo_anual (sueldo_mensual * 12).
SELECT nickname, sueldo_mensual * 12 AS sueldo_anual FROM JUGADORES;

-- #5 Mostrar el nombre del equipo, su tag y su presupuesto_anual dividido entre 1000000 con el alias presupuesto_millones.
SELECT nombre, tag, presupuesto_anual / 1000000 AS presupuesto_millones FROM EQUIPOS;

-- #6 En participaciones, mostrar id, kills, assists, deaths y la suma de kills + assists bajo el alias participacion_ofensiva.
SELECT id, kills, assists, deaths, kills + assists AS participacion_ofensiva FROM PARTICIPACIONES;

-- #7 Mostrar el nickname, pais_natal y sueldo_mensual de los jugadores de 'Chile'.
SELECT NICKNAME, PAIS_NATAL, sueldo_mensual FROM JUGADORES WHERE PAIS_NATAL = 'Chile';

-- #8 Mostrar el nickname, edad y sueldo_mensual de los jugadores que ganen más de 25000 mensuales.
SELECT nickname, edad, sueldo_mensual FROM JUGADORES WHERE sueldo_mensual > 25000;

-- #9 Mostrar el nombre y ambientacion de los mapas que tengan 3 sitios de bomba.
SELECT nombre, ambientacion FROM Mapas WHERE sitios_bomba = 3;