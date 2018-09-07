-- PUNTO 1 VERSIÓN 1

-- Platillo más gustado por día específico
SELECT Platillo.idPlatillo, Platillo.nombre, AVG(RatingPlatillo.puntaje) AS puntajePromedio FROM Platillo
INNER JOIN RatingPlatillo ON RatingPlatillo.idPlatillo = Platillo.idPlatillo
WHERE strftime('%d', RatingPlatillo.fecha) = "06"
AND strftime('%m', RatingPlatillo.fecha) = "09"
AND strftime('%Y', RatingPlatillo.fecha) = "2018"
GROUP BY Platillo.idPlatillo
ORDER BY puntajePromedio DESC LIMIT 1;

-- PARA EL MENOS GUSTADO CAMBIAR 'DESC' POR 'ASC'

-- Platillo más gustado por mes específico
SELECT Platillo.idPlatillo, Platillo.nombre, AVG(RatingPlatillo.puntaje) AS puntajePromedio FROM Platillo
INNER JOIN RatingPlatillo ON RatingPlatillo.idPlatillo = Platillo.idPlatillo
AND strftime('%m', RatingPlatillo.fecha) = "09"
AND strftime('%Y', RatingPlatillo.fecha) = "2018"
GROUP BY Platillo.idPlatillo
ORDER BY puntajePromedio DESC LIMIT 1;

-- Platillo más gustado por semestre (verison 1)
SELECT Platillo.idPlatillo, Platillo.nombre, AVG(RatingPlatillo.puntaje) AS puntajePromedio FROM Platillo
INNER JOIN RatingPlatillo ON RatingPlatillo.idPlatillo = Platillo.idPlatillo
AND strftime('%m', RatingPlatillo.fecha) >= "07" -- Primer mes del semestre
AND strftime('%m', RatingPlatillo.fecha) <= "11" -- Último mes del semestre
AND strftime('%Y', RatingPlatillo.fecha) = "2018"
GROUP BY Platillo.idPlatillo
ORDER BY puntajePromedio DESC LIMIT 1;



-- Platilo más gustado de un restaurante específico en un día específico
SELECT Platillo.idPlatillo, Platillo.nombre, AVG(RatingPlatillo.puntaje) AS puntajePromedio FROM Restaurante
INNER JOIN TiempoComida ON TiempoComida.idRestaurante = Restaurante.idRestaurante
INNER JOIN RatingPlatillo ON RatingPlatillo.idTiempoComida = TiempoComida.idTiempoComida
INNER JOIN Platillo ON RatingPlatillo.idPlatillo = Platillo.idPlatillo
WHERE strftime('%d', RatingPlatillo.fecha) = "06"
AND strftime('%m', RatingPlatillo.fecha) = "09"
AND strftime('%Y', RatingPlatillo.fecha) = "2018"
AND Restaurante.idRestaurante = 2
-- AND Restaurante.nombre = "Restaurante El Chef Milton" -- O por nombre
GROUP BY Platillo.idPlatillo
ORDER BY puntajePromedio DESC LIMIT 1;

-- Mismos cambios de arriba para seleccionar por semestre, año, etc


-- Platilo más gustado de TODO
SELECT Platillo.idPlatillo, Platillo.nombre, AVG(RatingPlatillo.puntaje) AS puntajePromedio FROM Platillo
INNER JOIN RatingPlatillo ON RatingPlatillo.idPlatillo = Platillo.idPlatillo
GROUP BY Platillo.idPlatillo
ORDER BY puntajePromedio DESC LIMIT 1;


-- PUNTO 1 VERSIÓN 2
-- CON REPORTES PARA CADA ELEMENTO

-- Platillo más gustado de cada dia
SELECT dia, idPlatillo, nombre, MAX(puntajePromedio) AS puntajePromedio
FROM (
	SELECT strftime('%m-%Y-%d', RatingPlatillo.fecha) AS dia, Platillo.idPlatillo, Platillo.nombre, AVG(RatingPlatillo.puntaje) AS puntajePromedio FROM Platillo
	INNER JOIN RatingPlatillo ON RatingPlatillo.idPlatillo = Platillo.idPlatillo
	GROUP BY strftime('%m-%Y-%d', RatingPlatillo.fecha), Platillo.idPlatillo
	ORDER BY puntajePromedio DESC
	)
GROUP BY dia;

-- Platillo más gustado de cada mes
SELECT mes, idPlatillo, nombre, MAX(puntajePromedio) AS puntajePromedio
FROM (
	SELECT strftime('%m-%Y', RatingPlatillo.fecha) AS mes, Platillo.idPlatillo, Platillo.nombre, AVG(RatingPlatillo.puntaje) AS puntajePromedio FROM Platillo
	INNER JOIN RatingPlatillo ON RatingPlatillo.idPlatillo = Platillo.idPlatillo
	GROUP BY strftime('%m-%Y', RatingPlatillo.fecha), Platillo.idPlatillo
	ORDER BY puntajePromedio DESC
	)
GROUP BY mes;

-- Plato más gustado de cada semestre
SELECT semestre, idPlatillo, nombrePlatillo, MAX(puntajePromedio) AS puntajePromedio
FROM (
	SELECT Semestre.nombre as semestre, Platillo.idPlatillo, Platillo.nombre AS nombrePlatillo, AVG(RatingPlatillo.puntaje) AS puntajePromedio FROM Semestre
	INNER JOIN RatingPlatillo ON 
		strftime('%s', RatingPlatillo.fecha) BETWEEN strftime('%s', Semestre.fechaInicio) AND strftime('%s', Semestre.fechaFinal)
	INNER JOIN Platillo on Platillo.idPlatillo = RatingPlatillo.idPlatillo
	GROUP BY Semestre.idSemestre, Platillo.idPlatillo
	ORDER BY puntajePromedio DESC
)
GROUP BY semestre;

-- Plato más gustado de cada restaurante
SELECT idRestaurante, nombreRestaurante, idPlatillo, nombrePlatillo, MAX(puntajePromedio) AS puntajePromedio
FROM (
	SELECT Restaurante.idRestaurante, Restaurante.nombre as nombreRestaurante, Platillo.idPlatillo, Platillo.nombre as nombrePlatillo, AVG(RatingPlatillo.puntaje) AS puntajePromedio FROM Restaurante
	INNER JOIN TiempoComida ON TiempoComida.idRestaurante = Restaurante.idRestaurante
	INNER JOIN RatingPlatillo ON RatingPlatillo.idTiempoComida = TiempoComida.idTiempoComida
	INNER JOIN Platillo ON RatingPlatillo.idPlatillo = Platillo.idPlatillo
	GROUP BY Restaurante.idRestaurante, Platillo.idPlatillo
)
GROUP BY idRestaurante


-- PUNTO 2

-- Horario más popular en un restaurante en específico
SELECT TiempoComida.idTiempoComida, TiempoComida.nombre, COUNT(TiempoComida.idTiempoComida) AS cantidadDeRatings FROM Restaurante
INNER JOIN TiempoComida ON TiempoComida.idRestaurante = Restaurante.idRestaurante
INNER JOIN RatingPlatillo ON RatingPlatillo.idTiempoComida = TiempoComida.idTiempoComida
INNER JOIN Platillo ON RatingPlatillo.idPlatillo = Platillo.idPlatillo
AND strftime('%d', RatingPlatillo.fecha) = "06"
AND strftime('%m', RatingPlatillo.fecha) = "09"
AND strftime('%Y', RatingPlatillo.fecha) = "2018"
AND Restaurante.nombre = "Restaurante El Chef Milton"
GROUP BY TiempoComida.idTiempoComida
ORDER BY cantidadDeRatings DESC LIMIT 4;


-- Horario más popular de TODOS los restaurantes
SELECT TiempoComida.idTiempoComida, TiempoComida.nombre, COUNT(TiempoComida.idTiempoComida) AS cantidadDeRatings FROM Platillo
INNER JOIN RatingPlatillo ON RatingPlatillo.idPlatillo = Platillo.idPlatillo
INNER JOIN TiempoComida ON TiempoComida.idTiempoComida = RatingPlatillo.idTiempoComida
WHERE strftime('%d', RatingPlatillo.fecha) = "06"
AND strftime('%m', RatingPlatillo.fecha) = "09"
AND strftime('%Y', RatingPlatillo.fecha) = "2018"
GROUP BY TiempoComida.nombre
ORDER BY cantidadDeRatings DESC LIMIT 4;


-- PUNTO 3
-- Carrera más participativa de TODOS  los restaurantes
SELECT idRestaurante, nombreRestaurante, idCarrera, nombreCarrera, MAX(cantidadDeRatings) AS ratingsPorLaCarrera FROM(
	SELECT Restaurante.idRestaurante, Restaurante.nombre as nombreRestaurante, Carrera.idCarrera, Carrera.nombre AS nombreCarrera, COUNT(Carrera.idCarrera) AS cantidadDeRatings FROM Restaurante
	INNER JOIN TiempoComida ON TiempoComida.idRestaurante = Restaurante.idRestaurante
	INNER JOIN RatingPlatillo ON RatingPlatillo.idTiempoComida = TiempoComida.idTiempoComida
	INNER JOIN Estudiante ON Estudiante.idEstudiante = RatingPlatillo.idEstudiante
	INNER JOIN Carrera ON Carrera.idCarrera = Estudiante.idEstudiante
	GROUP BY Restaurante.idRestaurante, Carrera.idCarrera
	ORDER BY cantidadDeRatings DESC
)
GROUP BY idRestaurante

-- PUNTO 4
-- ESTUDIANTE MÁS PARTICIPATIVO
SELECT Estudiante.idEstudiante, Estudiante.nombre, Estudiante.apellidos, COUNT(RatingPlatillo.idRatingPlatillo) AS totalDeRatings FROM Estudiante
INNER JOIN RatingPlatillo ON RatingPlatillo.idEstudiante = Estudiante.idEstudiante
GROUP BY RatingPlatillo.idEstudiante
ORDER BY totalDeRatings DESC LIMIT 1;

-- PUNTO 5
-- RATING PROMEDIO PARA CADA RESTAURANTE
SELECT Restaurante.idRestaurante, Restaurante.nombre, AVG(RatingPlatillo.puntaje) AS puntajePromedio FROM Restaurante
INNER JOIN TiempoComida ON  TiempoComida.idRestaurante = Restaurante.idRestaurante
INNER JOIN RatingPlatillo ON RatingPlatillo.idTiempoComida = TiempoComida.idTiempoComida
GROUP BY Restaurante.idRestaurante
ORDER BY puntajePromedio DESC;






-- Ignorar esto
/*INSERT INTO RatingPlatillo(idPlatillo, idEstudiante, idTiempoComida, puntaje, fecha)
VALUES (1, 3, 2, 4.5, datetime("now"));*/