-- -----------------------------------------------------
-- Add register into pais table
-- -----------------------------------------------------
INSERT INTO pais(idpais, nombre, abreviacion)
VALUES (1, 'México', 'MX');

-- -----------------------------------------------------
-- Add register into estado table
-- -----------------------------------------------------
INSERT INTO estado(idestado, nombre, abreviacion, pais_idpais)
VALUES (1,'Jalisco', 'JAL', 1);

-- -----------------------------------------------------
-- Add register into ciudad table
-- -----------------------------------------------------
INSERT INTO ciudad(idciudad, nombre, abreviacion, estado_idestado)
VALUES (1, 'Ciudad Guzmán', 'GZMN', 1);

-- -----------------------------------------------------
-- Add register into direccion table
-- -----------------------------------------------------
INSERT INTO direccion(iddireccion, calle, entrecalle1, entrecalle2, lat, lng, numext, numint, colonia, cp, ciudad_idciudad, principal)
VALUES (1, 'Ramón corona # 34', 'Primero de mayo', 'Pascual galindo', 134, -9993, 1, 2, 'Centro', 49900, 1, true);

-- -----------------------------------------------------
-- Add register into telefono table
-- -----------------------------------------------------
INSERT INTO telefono(idtelefono, numero, lada, compania)
VALUES (1,'3416789087', '+51', 'Telcel');

-- -----------------------------------------------------
-- Add register into image table
-- -----------------------------------------------------
INSERT INTO image(idimage, src, title, description)
VALUES (1,'imagen-default.jpg', 'Imagen Defualt', 'Imagen por default');

-- -----------------------------------------------------
-- Add registers into rol table
-- -----------------------------------------------------
INSERT INTO rol(idrol, descripcion)
VALUES (1,'CLIENTE');
INSERT INTO rol(idrol, descripcion)
VALUES (2,'EMPRESA');

-- -----------------------------------------------------
-- Add registers into tipoComida table
-- -----------------------------------------------------
INSERT INTO tipoComida(idtipoComida, nombre, descripcion, region)
VALUES (1,'Mexicana', 'Comida tradicional mexicana', 'México');
INSERT INTO tipoComida(idtipoComida, nombre, descripcion, region)
VALUES (2,'Italiana', 'Comida tradicional italiana', 'Italia');
INSERT INTO tipoComida(idtipoComida, nombre, descripcion, region)
VALUES (3,'China', 'Comida tradicional china', 'China');

-- -----------------------------------------------------
-- Add registers into semana table
-- -----------------------------------------------------
INSERT INTO semana(idsemana) VALUES('LUNES');
INSERT INTO semana(idsemana) VALUES('MARTES');
INSERT INTO semana(idsemana) VALUES('MIÉRCOLES');
INSERT INTO semana(idsemana) VALUES('JUEVES');
INSERT INTO semana(idsemana) VALUES('VIERNES');
INSERT INTO semana(idsemana) VALUES('SÁBADO');
INSERT INTO semana(idsemana) VALUES('DOMINGO');