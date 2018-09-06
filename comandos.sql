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

-- Platillo más gustado por semestre
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





INSERT INTO RatingPlatillo(idPlatillo, idEstudiante, idTiempoComida, puntaje, fecha)
VALUES (1, 3, 2, 4.5, datetime("now"));