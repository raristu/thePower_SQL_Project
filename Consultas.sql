
-- DataProject: LógicaConsultasSQL 1

--1. Crea el esquema de la BBDD. Hecho
--2. Muestra los nombres de todas las películas con una clasificación por edades de ‘R’.

SELECT f.TITLE AS "Title"
FROM FILM AS f 
WHERE f.RATING = 'R';

--3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30 y 40.

SELECT a.FIRST_NAME AS "Name", 
		A.ACTOR_ID 
FROM ACTOR AS a
WHERE a.ACTOR_ID BETWEEN 30 AND 40;

--4. Obtén las películas cuyo idioma coincide con el idioma original.

SELECT f.TITLE AS "Title", 
		f.LANGUAGE_ID, 
		f.ORIGINAL_LANGUAGE_ID
FROM FILM AS f 
WHERE f.LANGUAGE_ID = f.ORIGINAL_LANGUAGE_ID;

--5. Ordena las películas por duración de forma ascendente.

SELECT f.TITLE AS "Title", 
		f.LENGTH AS "Duración"
FROM FILM AS f
ORDER BY f.LENGTH ASC;

--6. Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su apellido.

SELECT a.FIRST_NAME AS "Nombre", 
		a.LAST_NAME AS "Apellido"
FROM ACTOR AS a
WHERE a.LAST_NAME ILIKE '%Allen%';

--7. Encuentra la cantidad total de películas en cada clasificación de la tabla “film” y
--   muestra la clasificación junto con el recuento.

SELECT f.RATING, 
		COUNT(f.RATING) AS "Cantidad_películas"
FROM FILM AS f
GROUP BY f.RATING
ORDER BY "Cantidad_películas" DESC;

--8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen 
--   una duración mayor a 3 horas en la tabla film.

SELECT f.TITLE AS "Title", 
		f.RATING, 
		f.LENGTH
FROM FILM AS f
WHERE f.RATING = 'PG-13' OR f.LENGTH > 180;

--9. Encuentra la variabilidad de lo que costaría reemplazar las películas.

SELECT variance(f.REPLACEMENT_COST) AS "Variabilidad"
FROM FILM AS f;

--10. Encuentra la mayor y menor duración de una película de nuestra BBDD.

SELECT MAX(f.LENGTH) AS "Máxima_duración", 
		MIN(f.LENGTH) AS "Mínima_duración"
FROM film AS f;

--11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.

SELECT p.RENTAL_ID, 
		p.AMOUNT, 
		p.PAYMENT_DATE
FROM PAYMENT AS p
WHERE p.RENTAL_ID = (
	SELECT r.RENTAL_ID
	FROM RENTAL AS r
	ORDER BY r.RENTAL_DATE DESC 
	OFFSET 2
	LIMIT 1
);

--12. Encuentra el título de las películas en la tabla “film” que no sean
--     ni ‘NC-17’ ni ‘G’ en cuanto a su clasificación.

SELECT f.TITLE AS "Título", 
		f.RATING
FROM FILM AS f
WHERE f.RATING NOT IN ('NC-17','G');

--13. Encuentra el promedio de duración de las películas para cada clasificación
--  de la tabla film y muestra la clasificación junto con elpromedio de duración.

SELECT f.RATING AS "Clasificación", 
		AVG(f.LENGTH) AS "Promedio_duración"
FROM FILM AS f
GROUP BY f.RATING;

--14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.

SELECT f.TITLE AS "Título", 
		f.LENGTH AS "Duración"
FROM FILM AS f
WHERE f.LENGTH > 180;

--15. ¿Cuánto dinero ha generado en total la empresa?

SELECT SUM(p.AMOUNT) AS "Total"
FROM PAYMENT AS p;

--16. Muestra los 10 clientes con mayor valor de id.

SELECT c.CUSTOMER_ID, 
		concat(c.FIRST_NAME,' ',c.LAST_NAME ) AS "Cliente"
FROM CUSTOMER AS c
ORDER BY c.CUSTOMER_ID DESC 
LIMIT 10;

--17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby’.

SELECT a.FIRST_NAME AS "Nombre", 
		a.LAST_NAME AS "Apellido", 
		f.title AS "Título"
FROM ACTOR AS a
JOIN FILM_ACTOR AS fa ON a.ACTOR_ID = fa.ACTOR_ID
JOIN FILM AS f ON fa.FILM_ID = f.FILM_ID
WHERE f.TITLE ILIKE 'Egg Igby';

-- DataProject: LógicaConsultasSQL 2

--18. Selecciona todos los nombres de las películas únicos.

SELECT DISTINCT(f.TITLE) AS "Títulos_distintos"
FROM FILM AS f;

--19. Encuentra el título de las películas que son comedias y tienen una duración mayor
--    a 180 minutos en la tabla “film”.

SELECT f.TITLE AS "Título",
		c."name" AS "Categoría", 
		f.LENGTH AS "Duración"
FROM FILM AS f
JOIN FILM_CATEGORY AS fc ON f.FILM_ID = fc.FILM_ID
JOIN CATEGORY AS c ON fc.CATEGORY_ID = c.CATEGORY_ID
WHERE c."name" ILIKE 'Comedy' AND f.LENGTH > 180;

--20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos
--    y muestra el nombre de la categoría junto con el promedio de duración.

SELECT c."name" AS "Categoría", 
		round(AVG(f.LENGTH),2) AS "Duración"
FROM FILM AS f
JOIN FILM_CATEGORY AS fc ON f.FILM_ID = fc.FILM_ID
JOIN CATEGORY AS c ON fc.CATEGORY_ID = c.CATEGORY_ID
GROUP BY c."name"  
HAVING AVG(f.LENGTH) > 110;

--21. ¿Cuál es la media de duración del alquiler de las películas?

SELECT AVG(r.RETURN_DATE - r.RENTAL_DATE) AS "Duración_media"
FROM RENTAL AS r;

--22. Crea una columna con el nombre y apellidos de todos los actores y actrices.

SELECT concat(a.FIRST_NAME,' ',a.LAST_NAME) AS "Nombre_completo"
FROM ACTOR AS a;

--23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.

SELECT DATE(r.RENTAL_DATE) AS "Día", 
	COUNT(r.rental_id) AS "Número_alquiler_por_día"
FROM RENTAL AS r
GROUP BY  "Día"
ORDER BY "Número_alquiler_por_día" DESC;

--24. Encuentra las películas con una duración superior al promedio.

SELECT f.TITLE AS "Título", 
	f.LENGTH AS "Duración"
FROM FILM AS f
WHERE f.LENGTH > (
		SELECT AVG(f2.LENGTH) AS "Duración_Promedio"
		FROM FILM AS f2 
);

--25. Averigua el número de alquileres registrados por mes.

SELECT 
	EXTRACT(YEAR FROM r.RENTAL_DATE) AS "Año", 
	EXTRACT(MONTH FROM r.RENTAL_DATE) AS "Mes", 
	COUNT(r.RENTAL_ID) AS "Número_alquileres"
FROM RENTAL AS r
GROUP BY "Año","Mes"
ORDER BY "Año", "Mes";

--26. Encuentra el promedio, la desviación estándar y varianza del total pagado.

SELECT AVG(p.AMOUNT) AS "Promedio", 
	stddev(p.AMOUNT) AS "Desviación_estándar", 
	variance(p.AMOUNT) AS "Desviación_estándar" 
FROM PAYMENT AS p;

--27. ¿Qué películas se alquilan por encima del precio medio?

SELECT f.TITLE AS "Título", 
		f.RENTAL_RATE AS "Precio",
		(SELECT AVG(RENTAL_RATE)
		FROM film) AS "Precio_medio"
FROM FILM AS f
WHERE f.RENTAL_RATE > (
		SELECT AVG(RENTAL_RATE) AS "Precio_medio"
		FROM film 
);

--28. Muestra el id de los actores que hayan participado en más de 40 películas.

SELECT a.ACTOR_ID, 
	concat(a.FIRST_NAME,' ',a.LAST_NAME) AS "Actor/Actriz",
	COUNT(fa.FILM_ID) AS "Número_películas"
FROM ACTOR AS a
JOIN FILM_ACTOR AS fa ON a.ACTOR_ID = fa.ACTOR_ID
GROUP BY a.ACTOR_ID
HAVING COUNT(fa.FILM_ID) > 40;

--29. Obtener todas las películas y, si están disponibles en el inventario, 
--    mostrar la cantidad disponible.

SELECT f.FILM_ID,
		f.TITLE AS "Título",
		COUNT(i.INVENTORY_ID) AS "Cantidad_disponible"
FROM FILM AS f
LEFT JOIN INVENTORY AS i ON f.FILM_ID = i.FILM_ID
GROUP BY f.FILM_ID, "Título"
ORDER BY "Cantidad_disponible" DESC;

--30. Obtener los actores y el número de películas en las que ha actuado.

SELECT a.ACTOR_ID,
		concat(a.FIRST_NAME,' ',a.LAST_NAME) AS "Actor/Actriz",
		COUNT(fa.FILM_ID) AS "Número_películas"
FROM ACTOR AS a
LEFT JOIN FILM_ACTOR AS fa ON a.ACTOR_ID = fa.ACTOR_ID
GROUP BY a.ACTOR_ID,"Actor/Actriz"
ORDER BY "Número_películas" DESC;

--31. Obtener todas las películas y mostrar los actores que han actuado en ellas, 
--    incluso si algunas películas no tienen actores asociados.

SELECT f.title AS "Título",
		fa.actor_id,
		concat(a.FIRST_NAME,' ',a.LAST_NAME) AS "Actor/Actriz"
FROM FILM AS f
LEFT JOIN FILM_ACTOR AS fa ON f.FILM_ID = fa.FILM_ID
LEFT JOIN ACTOR AS a ON fa.ACTOR_ID = a.ACTOR_ID
ORDER by f.TITLE;

--32. Obtener todos los actores y mostrar las películas en las que han actuado, 
--    incluso si algunos actores no han actuado en ninguna película.

SELECT a.ACTOR_ID, 
		concat(a.FIRST_NAME,' ',a.LAST_NAME) AS "Actor/Actriz", 
		f.TITLE AS "Título"
FROM ACTOR AS a
LEFT JOIN FILM_ACTOR AS fa ON a.ACTOR_ID = fa.ACTOR_ID
LEFT JOIN FILM AS f ON fa.FILM_ID = f.FILM_ID
ORDER BY a.ACTOR_ID;

--33. Obtener todas las películas que tenemos y todos los registros de alquiler.

SELECT f.FILM_ID, 
		f.TITLE AS "Título", 
		r.RENTAL_ID, r.RENTAL_DATE AS "Fecha_alquiler"
FROM FILM AS f
FULL JOIN INVENTORY AS i ON f.FILM_ID = i.FILM_ID 
FULL JOIN RENTAL AS r ON i.INVENTORY_ID = r.INVENTORY_ID;

--34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.

SELECT p.CUSTOMER_ID, 
		concat(c.FIRST_NAME,' ',c.LAST_NAME) AS "Cliente",
		SUM(p.amount) AS "Cantidad_gastada"
FROM PAYMENT AS p
LEFT JOIN CUSTOMER AS c ON p.CUSTOMER_ID = c.CUSTOMER_ID
GROUP BY p.CUSTOMER_ID, "Cliente" 
ORDER BY "Cantidad_gastada" DESC 
LIMIT 5;

--35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.

SELECT a.ACTOR_ID,
		concat(a.FIRST_NAME,' ',a.LAST_NAME) AS "Actor/Actriz"
FROM ACTOR AS a
WHERE a.FIRST_NAME ILIKE 'Johnny';

--36. Renombra la columna “first_name” como Nombre y “last_name” como Apellido.

SELECT a.FIRST_NAME AS "Nombre",
		a.LAST_NAME AS "Apellido"
FROM ACTOR AS a;

-- DataProject: LógicaConsultasSQL 3

--37. Encuentra el ID del actor más bajo y más alto en la tabla actor.

SELECT MIN(a.ACTOR_ID) AS "ID_más_bajo",
		MAX(a.ACTOR_ID) AS "ID_más_alto"
FROM ACTOR AS a;

--38. Cuenta cuántos actores hay en la tabla “actor”.

SELECT COUNT(a.ACTOR_ID)
FROM ACTOR AS a;

--39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.

SELECT a.LAST_NAME AS "Apellido"
FROM ACTOR AS a
ORDER BY a.LAST_NAME;

--40. Selecciona las primeras 5 películas de la tabla “film”.

SELECT f.FILM_ID,
		f.TITLE AS "Título"
FROM FILM AS f
LIMIT 5;

--41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre.
--    ¿Cuál es el nombre más repetido?

SELECT a.FIRST_NAME AS "Nombre",
		COUNT(a.FIRST_NAME) AS "Cantidad"
FROM ACTOR AS a
GROUP BY "Nombre"
ORDER BY "Cantidad" DESC;

--42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.

SELECT r.RENTAL_ID,
		concat(c.FIRST_NAME,' ',c.LAST_NAME) AS "Cliente"
FROM RENTAL AS r
JOIN CUSTOMER AS c ON r.CUSTOMER_ID = c.CUSTOMER_ID; 

--43. Muestra todos los clientes y sus alquileres si existen, 
--    incluyendo aquellos que no tienen alquileres.

SELECT concat(c.FIRST_NAME,' ',c.LAST_NAME) AS "Cliente",
		r.RENTAL_ID
FROM CUSTOMER AS c
LEFT JOIN RENTAL AS r ON c.CUSTOMER_ID = r.CUSTOMER_ID;

--44. Realiza un CROSS JOIN entre las tablas film y category. 
--    ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.

SELECT f.TITLE,
		c."name"
FROM FILM AS f
CROSS JOIN CATEGORY AS c;

-- En mi opinión, esta consulta no aporta valor. No le veo la utilidad a, en este caso, unir todas
-- las películas con todas las categorías.

--45. Encuentra los actores que han participado en películas de la categoría 'Action'.

SELECT concat(a.FIRST_NAME,' ',a.LAST_NAME) AS "Actor/Actriz"
FROM ACTOR AS a
LEFT JOIN FILM_ACTOR AS fa ON a.ACTOR_ID = fa.ACTOR_ID
LEFT JOIN FILM AS f ON fa.FILM_ID = f.FILM_ID
WHERE f.FILM_ID IN (
					SELECT f.FILM_ID
					FROM FILM AS f
					JOIN FILM_CATEGORY AS fc ON f.FILM_ID = fc.FILM_ID
					JOIN CATEGORY AS c ON fc.CATEGORY_ID = c.CATEGORY_ID
					WHERE c."name" ILIKE 'Action')
ORDER BY "Actor/Actriz";

--46. Encuentra todos los actores que no han participado en películas.

SELECT concat(a.FIRST_NAME ,' ',a.LAST_NAME) AS "Actor/Actriz"
FROM ACTOR AS a
LEFT JOIN FILM_ACTOR AS fa ON a.ACTOR_ID = fa.ACTOR_ID
WHERE fa.FILM_ID IS NULL;

--47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.

SELECT concat(a.FIRST_NAME,' ',a.LAST_NAME) AS "Actor/Actriz",
		COUNT(fa.FILM_ID) AS "Cantidad_películas"
FROM ACTOR AS a
JOIN FILM_ACTOR AS fa ON a.ACTOR_ID = fa.ACTOR_ID
GROUP BY "Actor/Actriz"
ORDER BY "Cantidad_películas" DESC;

--48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres de los actores 
--    y el número de películas en las que han participado.

CREATE VIEW actor_num_peliculas AS 
SELECT concat(a.FIRST_NAME,' ',a.LAST_NAME) AS "Actor/Actriz",
		COUNT(fa.FILM_ID) AS "Cantidad películas"
FROM ACTOR AS a
JOIN FILM_ACTOR AS fa ON a.ACTOR_ID = fa.ACTOR_ID
GROUP BY "Actor/Actriz"
ORDER BY "Cantidad películas" DESC;

--49. Calcula el número total de alquileres realizados por cada cliente.

SELECT p.CUSTOMER_ID,
		COUNT(p.RENTAL_ID) AS "Número_Total_Alquileres"
FROM PAYMENT AS p
GROUP BY p.CUSTOMER_ID
ORDER BY "Número_Total_Alquileres" DESC;

--50. Calcula la duración total de las películas en la categoría 'Action'.

SELECT SUM(f.LENGTH) AS "Duración_total"
FROM FILM AS f
JOIN FILM_CATEGORY AS fc ON f.FILM_ID = fc.FILM_ID
JOIN CATEGORY AS c ON fc.CATEGORY_ID = c.CATEGORY_ID
WHERE c."name" ILIKE 'Action';

--51. Crea una tabla temporal llamada “cliente_rentas_temporal” para almacenar 
--    el total de alquileres por cliente.

CREATE TEMPORARY TABLE cliente_rentas_temporal AS 
SELECT p.CUSTOMER_ID,
		COUNT(p.RENTAL_ID) AS "Número Total Alquileres"
FROM PAYMENT AS p
GROUP BY p.CUSTOMER_ID
ORDER BY "Número Total Alquileres" DESC;

--52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene
--    las películas que han sido alquiladas al menos 10 veces.

CREATE TEMPORARY TABLE peliculas_alquiladas AS
SELECT f.FILM_ID,
		f.TITLE AS "Título",
		COUNT(r.RENTAL_ID) AS "Veces alquilada"
FROM FILM AS f
JOIN INVENTORY AS i ON f.FILM_ID = i.FILM_ID
JOIN RENTAL AS r ON i.INVENTORY_ID = r.INVENTORY_ID
GROUP BY f.FILM_ID, "Título"
HAVING COUNT(r.RENTAL_ID) >= 10
ORDER BY "Veces alquilada" DESC;

--53. Encuentra el título de las películas que han sido alquiladas por el cliente con el 
--    nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena los resultados alfabéticamente 
--    por título de película.

SELECT f.TITLE AS "Título"
FROM FILM AS f
JOIN INVENTORY AS i ON f.FILM_ID = i.FILM_ID
JOIN RENTAL AS r ON i.INVENTORY_ID = r.INVENTORY_ID 
JOIN CUSTOMER AS c ON r.CUSTOMER_ID = c.CUSTOMER_ID
WHERE concat(c.FIRST_NAME,' ',c.LAST_NAME) ILIKE 'Tammy Sanders' AND r.RETURN_DATE IS NULL 
ORDER BY f.FILM_ID;

--54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece 
--    a la categoría ‘Sci-Fi’. Ordena los resultados alfabéticamente por apellido.

SELECT DISTINCT a.FIRST_NAME AS "Nombre",
		a.LAST_NAME AS "Apellido",
		COUNT(fa.FILM_ID) AS "Número_películas"
FROM ACTOR AS a
JOIN FILM_ACTOR AS fa ON a.ACTOR_ID = fa.ACTOR_ID
JOIN FILM AS f ON fa.FILM_ID = f.FILM_ID
JOIN FILM_CATEGORY AS fc ON f.FILM_ID = fc.FILM_ID
JOIN CATEGORY AS c ON fc.CATEGORY_ID = c.CATEGORY_ID
WHERE c."name" = 'Sci-Fi'
GROUP BY "Nombre", "Apellido" 
ORDER BY "Apellido";

-- DataProject: LógicaConsultasSQL 4

--55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron
--    después de que la película ‘Spartacus Cheaper’ se alquilara por primera vez. 
--    Ordena los resultados alfabéticamente por apellido.

SELECT DISTINCT a.FIRST_NAME AS "Nombre",
		a.LAST_NAME AS "Apellido"
FROM ACTOR AS a
JOIN FILM_ACTOR AS fa ON a.ACTOR_ID = fa.ACTOR_ID 
JOIN FILM AS f ON fa.FILM_ID = f.FILM_ID
JOIN INVENTORY AS i ON f.FILM_ID = i.FILM_ID
JOIN RENTAL AS r ON i.INVENTORY_ID = r.INVENTORY_ID
WHERE r.RENTAL_DATE > (
					SELECT min(r2.RENTAL_DATE)
					FROM rental AS r2
					JOIN INVENTORY AS i2 ON r2.INVENTORY_ID = i2.INVENTORY_ID 
					JOIN FILM AS f2 ON i2.FILM_ID =f2.FILM_ID 
					WHERE f2.TITLE ILIKE 'Spartacus Cheaper'
)
ORDER BY "Apellido","Nombre";

-- He intentado hacerlo con una CTE pero me parece más largo y menos claro en este caso.

WITH primer_alquiler_Spartacus_Cheaper AS (
	SELECT MIN(r.RENTAL_DATE) AS "Primera_fecha"
	FROM RENTAL AS r
	JOIN INVENTORY AS i ON r.INVENTORY_ID = i.INVENTORY_ID
	JOIN FILM AS f ON i.FILM_ID = f.FILM_ID
	WHERE f.TITLE ILIKE 'Spartacus Cheaper'
)
SELECT DISTINCT a.FIRST_NAME AS "Nombre",
		a.LAST_NAME AS "Apellido"
FROM ACTOR AS a
JOIN FILM_ACTOR AS fa ON a.ACTOR_ID = fa.ACTOR_ID 
JOIN FILM AS f ON fa.FILM_ID = f.FILM_ID
JOIN INVENTORY AS i ON f.FILM_ID = i.FILM_ID
JOIN RENTAL AS r ON i.INVENTORY_ID = r.INVENTORY_ID
JOIN primer_alquiler_Spartacus_Cheaper AS pasc ON r.RENTAL_DATE > pasc."Primera_fecha" 
ORDER BY "Apellido","Nombre";

--56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna 
--    película de la categoría ‘Music’.

WITH peliculas_categoria_Music AS (
	SELECT f.FILM_ID
	FROM FILM AS f
	JOIN FILM_CATEGORY AS fc ON f.FILM_ID = fc.FILM_ID
	JOIN CATEGORY AS c ON fc.CATEGORY_ID = c.CATEGORY_ID
	WHERE c.name = 'Music'
)
SELECT DISTINCT concat(a.FIRST_NAME,' ',a.LAST_NAME) AS "Actor/Actriz",
				fa.FILM_ID
FROM ACTOR AS a 
LEFT JOIN FILM_ACTOR AS fa ON a.ACTOR_ID = fa.ACTOR_ID 
WHERE fa.FILM_ID NOT IN ( 
						SELECT *
						FROM peliculas_categoria_Music
);

--57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.

SELECT f.title AS "Título", 
		f.RENTAL_DURATION
FROM FILM AS f
WHERE f.RENTAL_DURATION > 8;

-- Al hacer esta primera consulta, no recibo ningún resultado, así que intento 
-- la siguiente consulta (he buscado en Google como restar fechas timestamp):

SELECT DISTINCT f.title, 
				r.RENTAL_ID, 
				f.RENTAL_DURATION AS "Duración", 
				r.RENTAL_DATE AS "Rental_date",
				r.RETURN_DATE AS "Return_date"
FROM FILM AS f
JOIN INVENTORY AS i ON f.FILM_ID = i.FILM_ID
JOIN RENTAL AS r ON i.INVENTORY_ID = r.INVENTORY_ID
WHERE r.return_date IS NOT NULL
  AND date_part('day', r.return_date - r.rental_date) > 8
ORDER BY r.RENTAL_ID;

-- En mi opinión, puede que la columna "rental_duration" de la tabla film contenga datos erróneos.

--58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animation’.

SELECT f.TITLE AS "Título",
		c."name"
FROM FILM AS f
JOIN FILM_CATEGORY AS fc ON f.FILM_ID = fc.FILM_ID
JOIN CATEGORY AS c ON fc.CATEGORY_ID = c.CATEGORY_ID
WHERE c."name" = 'Animation';

--59. Encuentra los nombres de las películas que tienen la misma duración que la película con
--    el título ‘Dancing Fever’. Ordena los resultados alfabéticamente por título de película.

SELECT f.TITLE AS "Título",
		f.LENGTH AS "Duración"
FROM FILM AS f
WHERE f.LENGTH = (SELECT f2.LENGTH
					FROM FILM AS f2
					WHERE f2.TITLE ILIKE 'Dancing Fever'			
)
ORDER BY f.TITLE;

--60. Encuentra los nombres de los clientes que han alquilado al menos 7 películas distintas. 
--    Ordena los resultados alfabéticamente por apellido.

SELECT c.CUSTOMER_ID,
		c.FIRST_NAME AS "Nombre",
		c.LAST_NAME AS "Apellido",
		COUNT(DISTINCT i.FILM_ID) AS "Películas_distintas"
FROM CUSTOMER AS c
JOIN RENTAL AS r ON c.CUSTOMER_ID = r.CUSTOMER_ID
JOIN INVENTORY AS i ON r.INVENTORY_ID = i.INVENTORY_ID 
GROUP BY c.CUSTOMER_ID, "Nombre", "Apellido"
HAVING COUNT(DISTINCT i.FILM_ID) >= 7
ORDER BY "Apellido", "Nombre";

--61. Encuentra la cantidad total de películas alquiladas por categoría y muestra 
--    el nombre de la categoría junto con el recuento de alquileres.

WITH peliculas_con_categoria AS (
		SELECT f.FILM_ID,
				f.TITLE AS "Título",
				c."name" AS "Categoría"
		FROM FILM AS f
		JOIN FILM_CATEGORY AS fc ON f.FILM_ID = fc.FILM_ID
		JOIN CATEGORY AS c ON fc.CATEGORY_ID = c.CATEGORY_ID
)
SELECT pc."Categoría" AS "Categoría",
		COUNT(r.RENTAL_ID) AS "Recuento_alquileres"
FROM RENTAL AS r
JOIN INVENTORY AS i ON r.INVENTORY_ID = i.INVENTORY_ID
JOIN peliculas_con_categoria AS pc ON i.FILM_ID = pc.FILM_ID
GROUP BY "Categoría";

--62. Encuentra el número de películas por categoría estrenadas en 2006.

SELECT c."name" AS "Categoría",
		COUNT(f.FILM_ID) AS "Total_películas"
FROM FILM AS f
JOIN FILM_CATEGORY AS fc ON f.FILM_ID = fc.FILM_ID
JOIN CATEGORY AS c ON fc.CATEGORY_ID = c.CATEGORY_ID
WHERE f.RELEASE_YEAR = 2006
GROUP BY "Categoría";

--63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.

SELECT s.STAFF_ID,
		s2.STORE_ID
FROM STAFF AS s
CROSS JOIN STORE AS s2; 

--64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra 
--    el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.

-- El enunciado me ha causado dudas. Entiendo que la pregunta es encontrar el número de películas
-- distintas alquiladas por cada cliente.

SELECT c.CUSTOMER_ID,
		c.FIRST_NAME AS "Nombre",
		c.LAST_NAME AS "Apellido",
		COUNT(DISTINCT i.FILM_ID) AS "Número_películas_alquiladas"
FROM CUSTOMER AS c
JOIN RENTAL AS r ON c.CUSTOMER_ID = r.CUSTOMER_ID
JOIN INVENTORY AS i ON r.INVENTORY_ID = i.INVENTORY_ID
GROUP BY c.CUSTOMER_ID, "Nombre", "Apellido"
ORDER BY c.CUSTOMER_ID;







