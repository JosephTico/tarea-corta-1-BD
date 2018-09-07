BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS `Universidad` (
	`idUniversidad`	INTEGER NOT NULL,
	`nombre`	TEXT NOT NULL,
	PRIMARY KEY(`idUniversidad`)
);
INSERT INTO `Universidad` VALUES (1,'TEC');
INSERT INTO `Universidad` VALUES (2,'UCR');
CREATE TABLE IF NOT EXISTS `TiempoComida` (
	`idTiempoComida`	INTEGER NOT NULL,
	`idRestaurante`	INTEGER NOT NULL,
	`nombre`	TEXT NOT NULL,
	`horaInicio`	TEXT NOT NULL,
	`horaFinal`	TEXT NOT NULL,
	`descripcion`	TEXT,
	PRIMARY KEY(`idTiempoComida`),
	FOREIGN KEY(`idRestaurante`) REFERENCES `Restaurante`(`idRestaurante`)
);
INSERT INTO `TiempoComida` VALUES (1,1,'Almuerzo','11:00 AM','1:00 PM','Deliciosos y económicos almuerzos');
INSERT INTO `TiempoComida` VALUES (2,1,'Cena','6:00 PM','7:30 PM','Deliciosos y económicas cenas');
INSERT INTO `TiempoComida` VALUES (3,2,'Desayuno','8:00 AM','9:30 AM','Deliciosos y económicos desaynos');
INSERT INTO `TiempoComida` VALUES (4,2,'Almuerzo','11:00 AM','1:30 PM','Deliciosos y económicos almuerzos');
INSERT INTO `TiempoComida` VALUES (5,2,'Cena','5:30 PM','7:30 PM','Deliciosos y económicas cenas');
CREATE TABLE IF NOT EXISTS `Semestre` (
	`idSemestre`	INTEGER NOT NULL,
	`nombre`	TEXT NOT NULL,
	`fechaInicio`	TEXT NOT NULL,
	`fechaFinal`	TEXT NOT NULL,
	PRIMARY KEY(`idSemestre`)
);
INSERT INTO `Semestre` VALUES (1,'IS-2018','2018-02-01','2018-06-30');
INSERT INTO `Semestre` VALUES (2,'IIS-2018','2018-07-22','2018-11-30');
CREATE TABLE IF NOT EXISTS `Sede` (
	`idSede`	INTEGER NOT NULL,
	`idUniversidad`	INTEGER NOT NULL,
	`nombre`	TEXT NOT NULL,
	PRIMARY KEY(`idSede`),
	FOREIGN KEY(`idUniversidad`) REFERENCES `Universidad`(`idUniversidad`)
);
INSERT INTO `Sede` VALUES (1,1,'TEC Cartago');
INSERT INTO `Sede` VALUES (2,1,'TEC San Jose');
INSERT INTO `Sede` VALUES (3,2,'UCR Rodrigo Facio');
CREATE TABLE IF NOT EXISTS `Restaurante` (
	`idRestaurante`	INTEGER NOT NULL,
	`nombre`	TEXT NOT NULL,
	`descripcion`	TEXT,
	`foto`	TEXT,
	`telefono`	INTEGER,
	`ubicacion`	TEXT,
	`idSede`	INTEGER NOT NULL,
	PRIMARY KEY(`idRestaurante`),
	FOREIGN KEY(`idSede`) REFERENCES `Sede`(`idSede`)
);
INSERT INTO `Restaurante` VALUES (1,'Restaurante El Chef Milton','Delicias deliciosas','https://dummy.com/image.png',25500000,'En el TEC',1);
INSERT INTO `Restaurante` VALUES (2,'Soda ASETEC','100% precios reales','https://dummy.com/image.png',25500001,'Por la biblioteca',1);
INSERT INTO `Restaurante` VALUES (3,'Soda El Laguito','Delicias tropicales','https://dummy.com/image.png',25500002,'Por el lago',1);
INSERT INTO `Restaurante` VALUES (4,'El Furgón','A toda velocidad','https://dummy.com/image.png',25500003,'Por el gimnasio',1);
INSERT INTO `Restaurante` VALUES (5,'Popusas Raúl','Calientitas','https://dummy.com/image.png',25500004,'Edificio F2',1);
CREATE TABLE IF NOT EXISTS `RatingPlatillo` (
	`idRatingPlatillo`	INTEGER NOT NULL,
	`idPlatillo`	INTEGER NOT NULL,
	`idTiempoComida`	INTEGER NOT NULL,
	`idEstudiante`	INTEGER NOT NULL,
	`puntaje`	REAL NOT NULL,
	`fecha`	TEXT NOT NULL,
	`comentario`	TEXT,
	PRIMARY KEY(`idRatingPlatillo`),
	FOREIGN KEY(`idPlatillo`) REFERENCES `Platillo`(`idPlatillo`),
	FOREIGN KEY(`idTiempoComida`) REFERENCES `TiempoComida`(`idTiempoComida`),
	FOREIGN KEY(`idEstudiante`) REFERENCES `Restaurante`(`idRestaurante`)
);
INSERT INTO `RatingPlatillo` VALUES (1,1,1,1,4.5,'2018-09-06T21:41:21+00:00','Muy bueno');
INSERT INTO `RatingPlatillo` VALUES (2,2,1,1,3.0,'2018-09-06T21:41:21+00:00','Muy bueno');
INSERT INTO `RatingPlatillo` VALUES (3,2,1,2,3.0,'2018-09-06T21:41:21+00:00','
');
INSERT INTO `RatingPlatillo` VALUES (4,2,1,2,2.0,'2018-09-06T21:41:21+00:00','No estaba bueno');
INSERT INTO `RatingPlatillo` VALUES (5,1,2,2,4.6,'2018-09-06 22:04:09',NULL);
INSERT INTO `RatingPlatillo` VALUES (6,1,2,3,4.5,'2018-09-06 22:04:49',NULL);
INSERT INTO `RatingPlatillo` VALUES (7,1,4,2,4.2,'2018-09-06 22:18:55',NULL);
INSERT INTO `RatingPlatillo` VALUES (8,1,4,3,3.5,'2018-09-06 22:19:01',NULL);
INSERT INTO `RatingPlatillo` VALUES (9,1,1,3,4.0,'2018-04-03 20:00:01',NULL);
INSERT INTO `RatingPlatillo` VALUES (10,1,1,1,4.5,'2018-04-03 20:00:01',NULL);
INSERT INTO `RatingPlatillo` VALUES (11,1,1,2,3.7,'2018-04-03 20:00:01',NULL);
INSERT INTO `RatingPlatillo` VALUES (12,2,1,2,3.0,'2018-04-03 20:00:01',NULL);
INSERT INTO `RatingPlatillo` VALUES (13,2,1,1,3.2,'2018-04-03 20:00:01',NULL);
INSERT INTO `RatingPlatillo` VALUES (14,2,1,3,2.8,'2018-04-03 20:00:01',NULL);
INSERT INTO `RatingPlatillo` VALUES (15,3,1,3,4.5,'2018-10-06 22:18:55',NULL);
CREATE TABLE IF NOT EXISTS `Platillo` (
	`idPlatillo`	INTEGER NOT NULL,
	`nombre`	TEXT NOT NULL,
	`descripcion`	TEXT,
	`foto`	TEXT,
	`precio`	INTEGER NOT NULL,
	PRIMARY KEY(`idPlatillo`)
);
INSERT INTO `Platillo` VALUES (1,'Sopa Azteca','Deliciosa sopa mexicana a base de tomate con trocitos de pollito','https://dummy.com/dummy.png',2500);
INSERT INTO `Platillo` VALUES (2,'Gallo Pinto',NULL,NULL,1500);
INSERT INTO `Platillo` VALUES (3,'Cereal de aguacate',NULL,NULL,1200);
INSERT INTO `Platillo` VALUES (4,'Molde de carne',NULL,NULL,1000);
CREATE TABLE IF NOT EXISTS `Horario` (
	`idHorario`	INTEGER NOT NULL,
	`idPlatillo`	INTEGER NOT NULL,
	`idTiempoComida`	INTEGER NOT NULL,
	`dia`	TEXT NOT NULL,
	PRIMARY KEY(`idHorario`),
	FOREIGN KEY(`idPlatillo`) REFERENCES `Platillo`(`idPlatillo`),
	FOREIGN KEY(`idTiempoComida`) REFERENCES `TiempoComida`(`idTiempoComida`)
);
INSERT INTO `Horario` VALUES (1,1,1,'2018-09-06');
INSERT INTO `Horario` VALUES (2,2,1,'2018-09-06');
INSERT INTO `Horario` VALUES (3,3,1,'2018-09-06');
INSERT INTO `Horario` VALUES (4,3,2,'2018-09-06');
INSERT INTO `Horario` VALUES (5,1,2,'2018-09-06');
INSERT INTO `Horario` VALUES (6,2,3,'2018-09-06');
INSERT INTO `Horario` VALUES (7,1,4,'2018-09-06');
INSERT INTO `Horario` VALUES (8,3,5,'2018-09-06');
INSERT INTO `Horario` VALUES (9,1,1,'2018-09-07');
INSERT INTO `Horario` VALUES (10,2,1,'2018-09-07');
INSERT INTO `Horario` VALUES (11,3,1,'2018-09-07');
INSERT INTO `Horario` VALUES (12,3,2,'2018-09-07');
INSERT INTO `Horario` VALUES (13,1,2,'2018-09-07');
INSERT INTO `Horario` VALUES (14,2,3,'2018-09-07');
INSERT INTO `Horario` VALUES (15,1,4,'2018-09-07');
INSERT INTO `Horario` VALUES (16,3,5,'2018-09-07');
INSERT INTO `Horario` VALUES (17,1,1,'2018-09-16');
INSERT INTO `Horario` VALUES (18,2,1,'2018-09-16');
INSERT INTO `Horario` VALUES (19,3,1,'2018-09-16');
INSERT INTO `Horario` VALUES (20,3,2,'2018-09-16');
INSERT INTO `Horario` VALUES (21,1,2,'2018-09-16');
INSERT INTO `Horario` VALUES (22,2,3,'2018-09-16');
INSERT INTO `Horario` VALUES (23,1,4,'2018-09-16');
INSERT INTO `Horario` VALUES (24,3,5,'2018-09-16');
INSERT INTO `Horario` VALUES (25,1,1,'2018-10-16');
INSERT INTO `Horario` VALUES (26,2,1,'2018-10-16');
INSERT INTO `Horario` VALUES (27,3,1,'2018-10-16');
INSERT INTO `Horario` VALUES (28,3,2,'2018-10-16');
INSERT INTO `Horario` VALUES (29,1,2,'2018-10-16');
INSERT INTO `Horario` VALUES (30,2,3,'2018-10-16');
INSERT INTO `Horario` VALUES (31,1,4,'2018-10-16');
INSERT INTO `Horario` VALUES (32,3,5,'2018-10-16');
CREATE TABLE IF NOT EXISTS `Estudiante` (
	`idEstudiante`	INTEGER NOT NULL,
	`nombre`	TEXT NOT NULL,
	`apellidos`	TEXT NOT NULL,
	`idCarrera`	INTEGER NOT NULL,
	`email`	TEXT NOT NULL,
	`contrasena`	TEXT NOT NULL,
	FOREIGN KEY(`idCarrera`) REFERENCES `Carrera`(`idCarrera`),
	PRIMARY KEY(`idEstudiante`)
);
INSERT INTO `Estudiante` VALUES (1,'Daniel
','Castro',1,'aasa@dds.com','michaelgutierritos23');
INSERT INTO `Estudiante` VALUES (2,'Ximena','Carranza',2,'xicarran98@gmail.com','karraXi128');
INSERT INTO `Estudiante` VALUES (3,'Nacho','Bell',1,'nashobelin1211@gmail.com','nar12@13');
INSERT INTO `Estudiante` VALUES (4,'Yose','Vargas',1,'joseph@centropokemon.com','yosepe126$');
INSERT INTO `Estudiante` VALUES (5,'Tavo','Segura',3,'tsegura32@gmail.com','af4G@83HB');
INSERT INTO `Estudiante` VALUES (6,'Alondra','Morales',4,'alosehz@hotmail.com','aonHZ1999');
CREATE TABLE IF NOT EXISTS `Carrera` (
	`idCarrera`	INTEGER NOT NULL,
	`idUniversidad`	INTEGER NOT NULL,
	`nombre`	TEXT NOT NULL,
	FOREIGN KEY(`idUniversidad`) REFERENCES `Universidad`(`idUniversidad`),
	PRIMARY KEY(`idCarrera`)
);
INSERT INTO `Carrera` VALUES (1,1,'Ingeniería en Computación');
INSERT INTO `Carrera` VALUES (2,1,'Ingeniería en Computadores');
INSERT INTO `Carrera` VALUES (3,1,'Administración');
INSERT INTO `Carrera` VALUES (4,1,'Ingeniería Ambiental');
COMMIT;
