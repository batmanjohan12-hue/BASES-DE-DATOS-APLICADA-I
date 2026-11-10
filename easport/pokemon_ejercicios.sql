-- 19
SELECT * FROM regiones;

-- 20
SELECT num_pokedex, nombre, es_legendario FROM ESPECIES;

-- 21
SELECT alias_entrenador, rango, medallas, pokedolares, region_id FROM entrenadores;

-- 22
SELECT nombre AS estadio_oficial, ciudad AS ubicacion FROM ARENAS;

-- 24
SELECT apodo AS paciente_pokemon, nivel AS nivel_actual, puntos_salud AS hp_maximo, es_shiny AS variocolor, fecha_captura AS fecha_registro FROM POKEMONES_CAPTURADOS;

-- 27 
SELECT combate_id AS nro_combate, pokemon_id AS id_combatiente, dano_infligido AS ataque_total, debilitados_rivales AS kos_logrados, gano AS resultados_final FROM PARTICIPACIONES_COMBATE;

-- INSERCIONES

-- 84

SELECT c.fase_torneo , c.fecha_combate, premio_pokedolares, a.nombre, a.ciudad FROM combates c INNER JOIN arenas a ON c.arena_id = a.id WHERE c.asistencia_publico > 15000 ORDER BY c.PREMIO_POKEDOLARES DESC;

-- 87 

SELECT pk.apodo, pk.nivel, es.nombre, e.alias_entrenador FROM POKEMONES_CAPTURADOS pk INNER JOIN ENTRENADORES e ON pk.ENTRENADOR_ID = e.id INNER JOIN ESPECIES es ON pk.ESPECIE_ID = es.id WHERE pk.nivel >= 75 ORDER BY pk.nivel DESC;

-- 90

SELECT pk.apodo, es.nombre, es.tipo_primario_id, t.clima_favorable FROM POKEMONES_CAPTURADOS pk INNER JOIN ESPECIES es ON pk.ESPECIE_ID = es.ID INNER JOIN tipos t ON es.TIPO_PRIMARIO_ID = t.id WHERE pk.ES_SHINY = 'S' OR es.ES_LEGENDARIO = 'S';

select * from entrenadores;
select * FROM OBJETOS;
select * from INVENTARIO_ENTRENADOR;
-- 93
SELECT e.alias_entrenador, o.nombre, o.precio_tienda, (inv.cantidad * o.precio_tienda) AS valor_lote FROM inventario_entrenador inv INNER JOIN OBJETOS o ON inv.objeto_id = o.id INNER JOIN ENTRENADORES e ON inv.entrenador_id = e.id ORDER BY valor_lote DESC;





