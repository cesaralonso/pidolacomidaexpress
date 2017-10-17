-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema pidolacomida
-- -----------------------------------------------------
-- versión para utilizarse en express, 17 de oct 2017

-- -----------------------------------------------------
-- Schema pidolacomida
--
-- versión para utilizarse en express, 17 de oct 2017
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pidolacomida` DEFAULT CHARACTER SET utf8 ;
USE `pidolacomida` ;

-- -----------------------------------------------------
-- Table `pidolacomida`.`pais`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pidolacomida`.`pais` (
  `idpais` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `abreviacion` VARCHAR(15) NULL,
  PRIMARY KEY (`idpais`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pidolacomida`.`estado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pidolacomida`.`estado` (
  `idestado` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `abreviacion` VARCHAR(15) NULL,
  `pais_idpais` INT NOT NULL,
  PRIMARY KEY (`idestado`),
  INDEX `fk_estado_pais1_idx` (`pais_idpais` ASC),
  CONSTRAINT `fk_estado_pais1`
    FOREIGN KEY (`pais_idpais`)
    REFERENCES `pidolacomida`.`pais` (`idpais`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pidolacomida`.`ciudad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pidolacomida`.`ciudad` (
  `idciudad` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `abreviacion` VARCHAR(15) NULL,
  `estado_idestado` INT NOT NULL,
  PRIMARY KEY (`idciudad`),
  INDEX `fk_ciudad_estado1_idx` (`estado_idestado` ASC),
  CONSTRAINT `fk_ciudad_estado1`
    FOREIGN KEY (`estado_idestado`)
    REFERENCES `pidolacomida`.`estado` (`idestado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pidolacomida`.`direccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pidolacomida`.`direccion` (
  `iddireccion` INT NOT NULL,
  `calle` VARCHAR(45) NOT NULL,
  `entrecalle1` VARCHAR(45) NULL,
  `entrecalle2` VARCHAR(45) NULL,
  `lat` VARCHAR(45) NULL,
  `lng` VARCHAR(45) NULL,
  `numext` INT(6) NOT NULL,
  `numint` VARCHAR(1) NULL,
  `colonia` VARCHAR(45) NOT NULL,
  `cp` VARCHAR(6) NOT NULL,
  `ciudad_idciudad` INT NOT NULL,
  `principal` TINYINT(1) NULL,
  `baja` TINYINT(1) NULL,
  `created_by` INT NULL,
  `created_at` TIMESTAMP NULL,
  PRIMARY KEY (`iddireccion`),
  INDEX `fk_direccion_ciudad1_idx` (`ciudad_idciudad` ASC),
  INDEX `calle` (`calle` ASC),
  INDEX `entrecalles` (`entrecalle1` ASC, `entrecalle2` ASC),
  INDEX `colonia` (`colonia` ASC),
  INDEX `cp` (`cp` ASC),
  CONSTRAINT `fk_direccion_ciudad1`
    FOREIGN KEY (`ciudad_idciudad`)
    REFERENCES `pidolacomida`.`ciudad` (`idciudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pidolacomida`.`telefono`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pidolacomida`.`telefono` (
  `idtelefono` INT NOT NULL AUTO_INCREMENT,
  `created_by` INT NULL,
  `numero` VARCHAR(15) NOT NULL,
  `lada` VARCHAR(5) NOT NULL,
  `compania` VARCHAR(15) NULL,
  `baja` TINYINT(1) NULL,
  `created_at` TIMESTAMP NULL,
  PRIMARY KEY (`idtelefono`),
  INDEX `numero` (`numero` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pidolacomida`.`rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pidolacomida`.`rol` (
  `idrol` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(145) NULL,
  PRIMARY KEY (`idrol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pidolacomida`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pidolacomida`.`user` (
  `iduser` INT NOT NULL,
  `nombres` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `telefono_idtelefono` INT NOT NULL,
  `rol_idrol` VARCHAR(45) NOT NULL,
  `baja` TINYINT(1) NULL,
  `created_at` TIMESTAMP NULL,
  `created_by` INT NULL,
  PRIMARY KEY (`iduser`, `rol_idrol`),
  INDEX `fk_user_telefono1_idx` (`telefono_idtelefono` ASC),
  INDEX `fk_user_rol1_idx` (`rol_idrol` ASC),
  CONSTRAINT `fk_user_telefono1`
    FOREIGN KEY (`telefono_idtelefono`)
    REFERENCES `pidolacomida`.`telefono` (`idtelefono`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_rol1`
    FOREIGN KEY (`rol_idrol`)
    REFERENCES `pidolacomida`.`rol` (`idrol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pidolacomida`.`restaurante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pidolacomida`.`restaurante` (
  `idrestaurante` INT NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) NOT NULL,
  `direccion_iddireccion` INT NOT NULL,
  `restaurante_matriz_idrestaurante_matriz` INT NOT NULL,
  `user_iduser` INT NOT NULL,
  `razon` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `restaurante_idrestaurante` INT NOT NULL,
  `baja` TINYINT(1) NULL,
  `created_by` INT NULL,
  `created_at` TIMESTAMP NULL,
  PRIMARY KEY (`idrestaurante`),
  INDEX `fk_restaurante_direccion1_idx` (`direccion_iddireccion` ASC),
  INDEX `fk_restaurante_user1_idx` (`user_iduser` ASC),
  INDEX `fk_restaurante_restaurante1_idx` (`restaurante_idrestaurante` ASC),
  INDEX `nombre` (`nombre` ASC),
  INDEX `descripcion` (`descripcion` ASC),
  CONSTRAINT `fk_restaurante_direccion1`
    FOREIGN KEY (`direccion_iddireccion`)
    REFERENCES `pidolacomida`.`direccion` (`iddireccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_restaurante_user1`
    FOREIGN KEY (`user_iduser`)
    REFERENCES `pidolacomida`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_restaurante_restaurante1`
    FOREIGN KEY (`restaurante_idrestaurante`)
    REFERENCES `pidolacomida`.`restaurante` (`idrestaurante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pidolacomida`.`email`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pidolacomida`.`email` (
  `idemail` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NOT NULL,
  `tipo` VARCHAR(25) CHARACTER SET 'big5' NULL,
  `descripcion` VARCHAR(45) NULL,
  `baja` TINYINT(1) NULL,
  `created_at` TIMESTAMP NULL,
  `created_by` INT NULL,
  PRIMARY KEY (`idemail`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pidolacomida`.`restaurante_has_telefono`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pidolacomida`.`restaurante_has_telefono` (
  `restaurante_idrestaurante` INT NOT NULL,
  `telefono_idtelefono` INT NOT NULL,
  PRIMARY KEY (`restaurante_idrestaurante`, `telefono_idtelefono`),
  INDEX `fk_restaurante_has_telefono_telefono1_idx` (`telefono_idtelefono` ASC),
  INDEX `fk_restaurante_has_telefono_restaurante_idx` (`restaurante_idrestaurante` ASC),
  CONSTRAINT `fk_restaurante_has_telefono_restaurante`
    FOREIGN KEY (`restaurante_idrestaurante`)
    REFERENCES `pidolacomida`.`restaurante` (`idrestaurante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_restaurante_has_telefono_telefono1`
    FOREIGN KEY (`telefono_idtelefono`)
    REFERENCES `pidolacomida`.`telefono` (`idtelefono`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pidolacomida`.`restaurante_has_email`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pidolacomida`.`restaurante_has_email` (
  `restaurante_idrestaurante` INT NOT NULL,
  `email_idemail` INT NOT NULL,
  PRIMARY KEY (`restaurante_idrestaurante`, `email_idemail`),
  INDEX `fk_restaurante_has_email_email1_idx` (`email_idemail` ASC),
  INDEX `fk_restaurante_has_email_restaurante1_idx` (`restaurante_idrestaurante` ASC),
  CONSTRAINT `fk_restaurante_has_email_restaurante1`
    FOREIGN KEY (`restaurante_idrestaurante`)
    REFERENCES `pidolacomida`.`restaurante` (`idrestaurante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_restaurante_has_email_email1`
    FOREIGN KEY (`email_idemail`)
    REFERENCES `pidolacomida`.`email` (`idemail`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pidolacomida`.`user_has_direccion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pidolacomida`.`user_has_direccion` (
  `user_iduser` INT NOT NULL,
  `direccion_iddireccion` INT NOT NULL,
  PRIMARY KEY (`user_iduser`, `direccion_iddireccion`),
  INDEX `fk_user_has_direccion_direccion1_idx` (`direccion_iddireccion` ASC),
  INDEX `fk_user_has_direccion_user1_idx` (`user_iduser` ASC),
  CONSTRAINT `fk_user_has_direccion_user1`
    FOREIGN KEY (`user_iduser`)
    REFERENCES `pidolacomida`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_direccion_direccion1`
    FOREIGN KEY (`direccion_iddireccion`)
    REFERENCES `pidolacomida`.`direccion` (`iddireccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pidolacomida`.`tipoComida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pidolacomida`.`tipoComida` (
  `idtipoComida` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(25) NOT NULL,
  `descripcion` VARCHAR(145) NULL,
  `region` VARCHAR(45) NOT NULL,
  `baja` TINYINT(1) NULL,
  `created_at` TIMESTAMP NULL,
  `created_by` INT NULL,
  PRIMARY KEY (`idtipoComida`),
  INDEX `nombre` (`nombre` ASC),
  INDEX `region` (`region` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pidolacomida`.`platillo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pidolacomida`.`platillo` (
  `idplatillo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  `tipoComida_idtipoComida` INT NOT NULL,
  `baja` TINYINT(1) NULL,
  `created_by` INT NULL,
  `created_at` TIMESTAMP NULL,
  PRIMARY KEY (`idplatillo`, `tipoComida_idtipoComida`),
  INDEX `nombre` (`nombre` ASC),
  INDEX `descripcion` (`descripcion` ASC),
  INDEX `fk_platillo_tipoComida1_idx` (`tipoComida_idtipoComida` ASC),
  CONSTRAINT `fk_platillo_tipoComida1`
    FOREIGN KEY (`tipoComida_idtipoComida`)
    REFERENCES `pidolacomida`.`tipoComida` (`idtipoComida`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pidolacomida`.`restaurante_has_platillo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pidolacomida`.`restaurante_has_platillo` (
  `restaurante_idrestaurante` INT NOT NULL,
  `platillo_idplatillo` INT NOT NULL,
  `precio` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  `tiempopreparacion` TIME NULL,
  `baja` TINYINT(1) NULL,
  `created_at` TIMESTAMP NULL,
  PRIMARY KEY (`restaurante_idrestaurante`, `platillo_idplatillo`),
  INDEX `fk_restaurante_has_platillo_platillo1_idx` (`platillo_idplatillo` ASC),
  INDEX `fk_restaurante_has_platillo_restaurante1_idx` (`restaurante_idrestaurante` ASC),
  CONSTRAINT `fk_restaurante_has_platillo_restaurante1`
    FOREIGN KEY (`restaurante_idrestaurante`)
    REFERENCES `pidolacomida`.`restaurante` (`idrestaurante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_restaurante_has_platillo_platillo1`
    FOREIGN KEY (`platillo_idplatillo`)
    REFERENCES `pidolacomida`.`platillo` (`idplatillo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pidolacomida`.`ingrediente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pidolacomida`.`ingrediente` (
  `idingrediente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `proteinas` FLOAT NULL,
  `calorias` FLOAT NULL,
  `carbohidratos` FLOAT NULL,
  `grasas` FLOAT NULL,
  `baja` TINYINT(1) NULL,
  `created_by` INT NULL,
  `created_at` TIMESTAMP NULL,
  PRIMARY KEY (`idingrediente`),
  INDEX `calorias` (`calorias` ASC),
  INDEX `proteinas` (`proteinas` ASC),
  INDEX `carbohidratos` (`carbohidratos` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pidolacomida`.`restaurante_platillo_ingrediente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pidolacomida`.`restaurante_platillo_ingrediente` (
  `idrest_plat_ing` INT NOT NULL AUTO_INCREMENT,
  `res_has_pla_restaurante_idrestaurante` INT NOT NULL,
  `res_has_pla_platillo_idplatillo` INT NOT NULL,
  `ingrediente_idingrediente` INT NOT NULL,
  `precio` FLOAT NOT NULL,
  `default` TINYINT(1) NULL,
  PRIMARY KEY (`idrest_plat_ing`, `res_has_pla_restaurante_idrestaurante`, `res_has_pla_platillo_idplatillo`, `ingrediente_idingrediente`),
  INDEX `fk_restaurante_has_platillo_has_ingrediente_ingrediente1_idx` (`ingrediente_idingrediente` ASC),
  INDEX `fk_restaurante_has_platillo_has_ingrediente_restaurante_has_idx` (`res_has_pla_restaurante_idrestaurante` ASC, `res_has_pla_platillo_idplatillo` ASC),
  CONSTRAINT `fk_restaurante_has_platillo_has_ingrediente_restaurante_has_p1`
    FOREIGN KEY (`res_has_pla_restaurante_idrestaurante` , `res_has_pla_platillo_idplatillo`)
    REFERENCES `pidolacomida`.`restaurante_has_platillo` (`restaurante_idrestaurante` , `platillo_idplatillo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_restaurante_has_platillo_has_ingrediente_ingrediente1`
    FOREIGN KEY (`ingrediente_idingrediente`)
    REFERENCES `pidolacomida`.`ingrediente` (`idingrediente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pidolacomida`.`combo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pidolacomida`.`combo` (
  `idcombo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `descripcion` VARCHAR(205) NOT NULL,
  `precio` FLOAT NULL,
  `fecha_ini` DATETIME NULL,
  `fecha_fin` DATETIME NULL,
  `baja` TINYINT(1) NULL,
  `created_at` TIMESTAMP NULL,
  `created_by` INT NULL,
  PRIMARY KEY (`idcombo`),
  INDEX `nombre` (`nombre` ASC),
  INDEX `descripcion` (`descripcion` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = cp850;


-- -----------------------------------------------------
-- Table `pidolacomida`.`combo_has_restaurante_has_platillo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pidolacomida`.`combo_has_restaurante_has_platillo` (
  `combo_idcombo` INT NOT NULL,
  `res_has_platillo_res_idrestaurante` INT NOT NULL,
  `res_has_pla_platillo_idplatillo` INT NOT NULL,
  PRIMARY KEY (`combo_idcombo`, `res_has_platillo_res_idrestaurante`, `res_has_pla_platillo_idplatillo`),
  INDEX `fk_combo_has_restaurante_has_platillo_restaurante_has_plati_idx` (`res_has_platillo_res_idrestaurante` ASC, `res_has_pla_platillo_idplatillo` ASC),
  INDEX `fk_combo_has_restaurante_has_platillo_combo1_idx` (`combo_idcombo` ASC),
  CONSTRAINT `fk_combo_has_restaurante_has_platillo_combo1`
    FOREIGN KEY (`combo_idcombo`)
    REFERENCES `pidolacomida`.`combo` (`idcombo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_combo_has_restaurante_has_platillo_restaurante_has_platillo1`
    FOREIGN KEY (`res_has_platillo_res_idrestaurante` , `res_has_pla_platillo_idplatillo`)
    REFERENCES `pidolacomida`.`restaurante_has_platillo` (`restaurante_idrestaurante` , `platillo_idplatillo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = cp850;


-- -----------------------------------------------------
-- Table `pidolacomida`.`enfermedad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pidolacomida`.`enfermedad` (
  `idenfermedad` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idenfermedad`),
  INDEX `nombre` (`nombre` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pidolacomida`.`ingrediente_has_enfermedad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pidolacomida`.`ingrediente_has_enfermedad` (
  `ingrediente_idingrediente` INT NOT NULL,
  `enfermedad_idenfermedad` INT NOT NULL,
  `descripcion` VARCHAR(245) NULL,
  PRIMARY KEY (`ingrediente_idingrediente`, `enfermedad_idenfermedad`),
  INDEX `fk_ingrediente_has_enfermedad_enfermedad1_idx` (`enfermedad_idenfermedad` ASC),
  INDEX `fk_ingrediente_has_enfermedad_ingrediente1_idx` (`ingrediente_idingrediente` ASC),
  CONSTRAINT `fk_ingrediente_has_enfermedad_ingrediente1`
    FOREIGN KEY (`ingrediente_idingrediente`)
    REFERENCES `pidolacomida`.`ingrediente` (`idingrediente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ingrediente_has_enfermedad_enfermedad1`
    FOREIGN KEY (`enfermedad_idenfermedad`)
    REFERENCES `pidolacomida`.`enfermedad` (`idenfermedad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pidolacomida`.`oferta`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pidolacomida`.`oferta` (
  `idoferta` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(145) NOT NULL,
  `descripcion` VARCHAR(245) NOT NULL,
  `tipo` VARCHAR(25) NOT NULL,
  `fecha_ini` DATETIME NOT NULL,
  `fecha_fin` DATETIME NOT NULL,
  `precio` FLOAT NULL,
  `ofertacol` VARCHAR(45) NULL,
  `res_has_pla_restaurante_idrestaurante` INT NOT NULL,
  `res_has_pla_platillo_idplatillo` INT NOT NULL,
  `baja` TINYINT(1) NULL,
  `created_at` TIMESTAMP NULL,
  `created_by` INT NULL,
  PRIMARY KEY (`idoferta`),
  INDEX `fk_oferta_restaurante_has_platillo1_idx` (`res_has_pla_restaurante_idrestaurante` ASC, `res_has_pla_platillo_idplatillo` ASC),
  INDEX `nombre` (`nombre` ASC),
  INDEX `descripcion` (`descripcion` ASC),
  CONSTRAINT `fk_oferta_restaurante_has_platillo1`
    FOREIGN KEY (`res_has_pla_restaurante_idrestaurante` , `res_has_pla_platillo_idplatillo`)
    REFERENCES `pidolacomida`.`restaurante_has_platillo` (`restaurante_idrestaurante` , `platillo_idplatillo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pidolacomida`.`semana`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pidolacomida`.`semana` (
  `idsemana` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idsemana`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pidolacomida`.`horario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pidolacomida`.`horario` (
  `idhorario` INT NOT NULL AUTO_INCREMENT,
  `hora_ini` TIME NOT NULL,
  `hora_fin` TIME NOT NULL,
  `semana_idsemana` VARCHAR(10) NOT NULL,
  `baja` TINYINT(1) NULL,
  `created_at` TIMESTAMP NULL,
  `created_by` INT NULL,
  PRIMARY KEY (`idhorario`, `semana_idsemana`),
  INDEX `fk_horario_semana1_idx` (`semana_idsemana` ASC),
  CONSTRAINT `fk_horario_semana1`
    FOREIGN KEY (`semana_idsemana`)
    REFERENCES `pidolacomida`.`semana` (`idsemana`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pidolacomida`.`restaurante_has_platillo_has_horario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pidolacomida`.`restaurante_has_platillo_has_horario` (
  `res_has_pla_restaurante_idrestaurante` INT NOT NULL,
  `res_has_pla_platillo_idplatillo` INT NOT NULL,
  `horario_idhorario` INT NOT NULL,
  `horario_semana_idsemana` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`res_has_pla_restaurante_idrestaurante`, `res_has_pla_platillo_idplatillo`, `horario_idhorario`, `horario_semana_idsemana`),
  INDEX `fk_restaurante_has_platillo_has_horario_horario1_idx` (`horario_idhorario` ASC, `horario_semana_idsemana` ASC),
  INDEX `fk_restaurante_has_platillo_has_horario_restaurante_has_pla_idx` (`res_has_pla_restaurante_idrestaurante` ASC, `res_has_pla_platillo_idplatillo` ASC),
  CONSTRAINT `fk_restaurante_has_platillo_has_horario_restaurante_has_plati1`
    FOREIGN KEY (`res_has_pla_restaurante_idrestaurante` , `res_has_pla_platillo_idplatillo`)
    REFERENCES `pidolacomida`.`restaurante_has_platillo` (`restaurante_idrestaurante` , `platillo_idplatillo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_restaurante_has_platillo_has_horario_horario1`
    FOREIGN KEY (`horario_idhorario` , `horario_semana_idsemana`)
    REFERENCES `pidolacomida`.`horario` (`idhorario` , `semana_idsemana`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pidolacomida`.`restaurante_has_horario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pidolacomida`.`restaurante_has_horario` (
  `restaurante_idrestaurante` INT NOT NULL,
  `horario_idhorario` INT NOT NULL,
  `horario_semana_idsemana` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`restaurante_idrestaurante`, `horario_idhorario`, `horario_semana_idsemana`),
  INDEX `fk_restaurante_has_horario_horario1_idx` (`horario_idhorario` ASC, `horario_semana_idsemana` ASC),
  INDEX `fk_restaurante_has_horario_restaurante1_idx` (`restaurante_idrestaurante` ASC),
  CONSTRAINT `fk_restaurante_has_horario_restaurante1`
    FOREIGN KEY (`restaurante_idrestaurante`)
    REFERENCES `pidolacomida`.`restaurante` (`idrestaurante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_restaurante_has_horario_horario1`
    FOREIGN KEY (`horario_idhorario` , `horario_semana_idsemana`)
    REFERENCES `pidolacomida`.`horario` (`idhorario` , `semana_idsemana`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pidolacomida`.`orden`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pidolacomida`.`orden` (
  `idorden` INT NOT NULL AUTO_INCREMENT,
  `user_iduser` INT NOT NULL,
  `horaSolicitado` DATETIME NOT NULL,
  `direccion_iddireccion` INT NOT NULL,
  `status` VARCHAR(25) NOT NULL,
  `baja` TINYINT(1) NULL,
  `created_at` TIMESTAMP NULL,
  `created_by` INT NULL,
  PRIMARY KEY (`idorden`),
  INDEX `fk_orden_user1_idx` (`user_iduser` ASC),
  INDEX `fk_orden_direccion1_idx` (`direccion_iddireccion` ASC),
  INDEX `status` (`status` ASC),
  INDEX `horaSolicitado` (`horaSolicitado` ASC),
  CONSTRAINT `fk_orden_user1`
    FOREIGN KEY (`user_iduser`)
    REFERENCES `pidolacomida`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orden_direccion1`
    FOREIGN KEY (`direccion_iddireccion`)
    REFERENCES `pidolacomida`.`direccion` (`iddireccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pidolacomida`.`pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pidolacomida`.`pago` (
  `idpago` INT NOT NULL AUTO_INCREMENT,
  `subtotal` FLOAT NOT NULL,
  `total` FLOAT NOT NULL,
  `iva` FLOAT NOT NULL,
  `orden_idorden` INT NOT NULL,
  `facturar` TINYINT(1) NOT NULL,
  `baja` TINYINT(1) NULL,
  `created_by` INT NULL,
  `created_at` TIMESTAMP NULL,
  PRIMARY KEY (`idpago`),
  INDEX `fk_pago_orden1_idx` (`orden_idorden` ASC),
  CONSTRAINT `fk_pago_orden1`
    FOREIGN KEY (`orden_idorden`)
    REFERENCES `pidolacomida`.`orden` (`idorden`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pidolacomida`.`platilloOrdenado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pidolacomida`.`platilloOrdenado` (
  `idplatilloOrdenado` INT NOT NULL AUTO_INCREMENT,
  `user_iduser` INT NOT NULL,
  `res_has_pla_restaurante_idrestaurante` INT NOT NULL,
  `res_has_pla_platillo_idplatillo` INT NOT NULL,
  `horaSale` DATETIME NOT NULL,
  `horaEntregado` DATETIME NOT NULL,
  `horaPreparacion` DATETIME NOT NULL,
  `horaSolicitado` DATETIME NOT NULL,
  `status` VARCHAR(25) NOT NULL,
  `baja` TINYINT(1) NULL,
  `created_at` TIMESTAMP NULL,
  `created_by` INT NULL,
  PRIMARY KEY (`idplatilloOrdenado`),
  INDEX `fk_platilloOrdenado_user1_idx` (`user_iduser` ASC),
  INDEX `fk_platilloOrdenado_restaurante_has_platillo1_idx` (`res_has_pla_restaurante_idrestaurante` ASC, `res_has_pla_platillo_idplatillo` ASC),
  INDEX `status` (`status` ASC),
  INDEX `horaSale` (`horaSale` ASC),
  INDEX `horaPreparacion` (`horaPreparacion` ASC),
  INDEX `horaSolicitado` (`horaSolicitado` ASC),
  INDEX `horaEntregado` (`horaEntregado` ASC),
  CONSTRAINT `fk_platilloOrdenado_user1`
    FOREIGN KEY (`user_iduser`)
    REFERENCES `pidolacomida`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_platilloOrdenado_restaurante_has_platillo1`
    FOREIGN KEY (`res_has_pla_restaurante_idrestaurante` , `res_has_pla_platillo_idplatillo`)
    REFERENCES `pidolacomida`.`restaurante_has_platillo` (`restaurante_idrestaurante` , `platillo_idplatillo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pidolacomida`.`orden_has_platilloOrdenado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pidolacomida`.`orden_has_platilloOrdenado` (
  `orden_idorden` INT NOT NULL,
  `platilloOrdenado_idplatilloOrdenado` INT NOT NULL,
  PRIMARY KEY (`orden_idorden`, `platilloOrdenado_idplatilloOrdenado`),
  INDEX `fk_orden_has_platilloOrdenado_platilloOrdenado1_idx` (`platilloOrdenado_idplatilloOrdenado` ASC),
  INDEX `fk_orden_has_platilloOrdenado_orden1_idx` (`orden_idorden` ASC),
  CONSTRAINT `fk_orden_has_platilloOrdenado_orden1`
    FOREIGN KEY (`orden_idorden`)
    REFERENCES `pidolacomida`.`orden` (`idorden`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orden_has_platilloOrdenado_platilloOrdenado1`
    FOREIGN KEY (`platilloOrdenado_idplatilloOrdenado`)
    REFERENCES `pidolacomida`.`platilloOrdenado` (`idplatilloOrdenado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pidolacomida`.`platilloOrdenado_has_rest_plat_ing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pidolacomida`.`platilloOrdenado_has_rest_plat_ing` (
  `platilloOrdenado_idplatilloOrdenado` INT NOT NULL,
  `res_pla_ing_idrest_plat_ing` INT NOT NULL,
  PRIMARY KEY (`platilloOrdenado_idplatilloOrdenado`, `res_pla_ing_idrest_plat_ing`),
  INDEX `fk_platilloOrdenado_has_restaurante_platillo_ingrediente_re_idx` (`res_pla_ing_idrest_plat_ing` ASC),
  INDEX `fk_platilloOrdenado_has_restaurante_platillo_ingrediente_pl_idx` (`platilloOrdenado_idplatilloOrdenado` ASC),
  CONSTRAINT `fk_platilloOrdenado_has_restaurante_platillo_ingrediente_plat1`
    FOREIGN KEY (`platilloOrdenado_idplatilloOrdenado`)
    REFERENCES `pidolacomida`.`platilloOrdenado` (`idplatilloOrdenado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_platilloOrdenado_has_restaurante_platillo_ingrediente_rest1`
    FOREIGN KEY (`res_pla_ing_idrest_plat_ing`)
    REFERENCES `pidolacomida`.`restaurante_platillo_ingrediente` (`idrest_plat_ing`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pidolacomida`.`factura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pidolacomida`.`factura` (
  `idfactura` INT NOT NULL AUTO_INCREMENT,
  `rfc` VARCHAR(45) NOT NULL,
  `cadena` VARCHAR(345) NULL,
  `fecha` DATETIME NOT NULL,
  `direccion_iddireccion` INT NOT NULL,
  `pago_idpago` INT NOT NULL,
  `baja` TINYINT(1) NULL,
  `created_at` TIMESTAMP NULL,
  `created_by` INT NULL,
  PRIMARY KEY (`idfactura`),
  INDEX `fk_factura_direccion1_idx` (`direccion_iddireccion` ASC),
  INDEX `fk_factura_pago1_idx` (`pago_idpago` ASC),
  INDEX `rfc` (`rfc` ASC),
  CONSTRAINT `fk_factura_direccion1`
    FOREIGN KEY (`direccion_iddireccion`)
    REFERENCES `pidolacomida`.`direccion` (`iddireccion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_factura_pago1`
    FOREIGN KEY (`pago_idpago`)
    REFERENCES `pidolacomida`.`pago` (`idpago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
