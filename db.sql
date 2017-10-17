-- MySQL Script generated by MySQL Workbench
-- Mon Oct 16 15:56:00 2017
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`restaurante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`restaurante` (
  `idrestaurante` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `razon` VARCHAR(45) NULL,
  `rfc` VARCHAR(13) NULL,
  `direccion` VARCHAR(45) NULL,
  `descripcion` VARCHAR(145) NULL,
  PRIMARY KEY (`idrestaurante`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`platillo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`platillo` (
  `idplatillo` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`idplatillo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`ingrediente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`ingrediente` (
  `idingrediente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `calorias` FLOAT NULL,
  `carbohidratos` FLOAT NULL,
  `proteinas` FLOAT NULL,
  PRIMARY KEY (`idingrediente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`rol` (
  `idrol` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(25) NULL,
  PRIMARY KEY (`idrol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `iduser` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `direccion` VARCHAR(45) NULL,
  `sexo` VARCHAR(10) NULL,
  `email` VARCHAR(45) NULL,
  `password` VARCHAR(85) NULL,
  `rol_idrol` INT NOT NULL,
  PRIMARY KEY (`iduser`),
  INDEX `fk_user_rol_idx` (`rol_idrol` ASC),
  CONSTRAINT `fk_user_rol`
    FOREIGN KEY (`rol_idrol`)
    REFERENCES `mydb`.`rol` (`idrol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user_has_restaurante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user_has_restaurante` (
  `user_iduser` INT NOT NULL,
  `restaurante_idrestaurante` INT NOT NULL,
  `precio` FLOAT NULL,
  `descripcion` VARCHAR(245) NULL,
  `tiempoPreparacion` FLOAT NULL,
  PRIMARY KEY (`user_iduser`, `restaurante_idrestaurante`),
  INDEX `fk_user_has_restaurante_restaurante1_idx` (`restaurante_idrestaurante` ASC),
  INDEX `fk_user_has_restaurante_user1_idx` (`user_iduser` ASC),
  CONSTRAINT `fk_user_has_restaurante_user1`
    FOREIGN KEY (`user_iduser`)
    REFERENCES `mydb`.`user` (`iduser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_restaurante_restaurante1`
    FOREIGN KEY (`restaurante_idrestaurante`)
    REFERENCES `mydb`.`restaurante` (`idrestaurante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user_has_restaurante_has_platillo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user_has_restaurante_has_platillo` (
  `user_has_restaurante_user_iduser` INT NOT NULL,
  `user_has_restaurante_restaurante_idrestaurante` INT NOT NULL,
  `platillo_idplatillo` INT NOT NULL,
  `precio` INT NULL,
  `descripcion` VARCHAR(145) NULL,
  `direccion` VARCHAR(145) NULL,
  PRIMARY KEY (`user_has_restaurante_user_iduser`, `user_has_restaurante_restaurante_idrestaurante`, `platillo_idplatillo`),
  INDEX `fk_user_has_restaurante_has_platillo_platillo1_idx` (`platillo_idplatillo` ASC),
  INDEX `fk_user_has_restaurante_has_platillo_user_has_restaurante1_idx` (`user_has_restaurante_user_iduser` ASC, `user_has_restaurante_restaurante_idrestaurante` ASC),
  CONSTRAINT `fk_user_has_restaurante_has_platillo_user_has_restaurante1`
    FOREIGN KEY (`user_has_restaurante_user_iduser` , `user_has_restaurante_restaurante_idrestaurante`)
    REFERENCES `mydb`.`user_has_restaurante` (`user_iduser` , `restaurante_idrestaurante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_restaurante_has_platillo_platillo1`
    FOREIGN KEY (`platillo_idplatillo`)
    REFERENCES `mydb`.`platillo` (`idplatillo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user_has_restaurante_has_ingrediente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user_has_restaurante_has_ingrediente` (
  `user_has_restaurante_user_iduser` INT NOT NULL,
  `user_has_restaurante_restaurante_idrestaurante` INT NOT NULL,
  `ingrediente_idingrediente` INT NOT NULL,
  `precio` FLOAT NULL,
  `enventa` TINYINT(1) NULL,
  PRIMARY KEY (`user_has_restaurante_user_iduser`, `user_has_restaurante_restaurante_idrestaurante`, `ingrediente_idingrediente`),
  INDEX `fk_user_has_restaurante_has_ingrediente_ingrediente1_idx` (`ingrediente_idingrediente` ASC),
  INDEX `fk_user_has_restaurante_has_ingrediente_user_has_restaurant_idx` (`user_has_restaurante_user_iduser` ASC, `user_has_restaurante_restaurante_idrestaurante` ASC),
  CONSTRAINT `fk_user_has_restaurante_has_ingrediente_user_has_restaurante1`
    FOREIGN KEY (`user_has_restaurante_user_iduser` , `user_has_restaurante_restaurante_idrestaurante`)
    REFERENCES `mydb`.`user_has_restaurante` (`user_iduser` , `restaurante_idrestaurante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_restaurante_has_ingrediente_ingrediente1`
    FOREIGN KEY (`ingrediente_idingrediente`)
    REFERENCES `mydb`.`ingrediente` (`idingrediente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user_has_restaurante_has_platillo_has_user_has_restaurante_has_ingrediente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`user_has_restaurante_has_platillo_has_user_has_restaurante_has_ingrediente` (
  `user_has_restaurante_has_platillo_user_has_restaurante_user_iduser` INT NOT NULL,
  `user_has_restaurante_has_platillo_user_has_restaurante_restaurante_idrestaurante` INT NOT NULL,
  `user_has_restaurante_has_platillo_platillo_idplatillo` INT NOT NULL,
  `user_has_restaurante_has_ingrediente_user_has_restaurante_user_iduser` INT NOT NULL,
  `user_has_restaurante_has_ingrediente_user_has_restaurante_restaurante_idrestaurante` INT NOT NULL,
  `user_has_restaurante_has_ingrediente_ingrediente_idingrediente` INT NOT NULL,
  `default` TINYINT(1) NULL,
  PRIMARY KEY (`user_has_restaurante_has_platillo_user_has_restaurante_user_iduser`, `user_has_restaurante_has_platillo_user_has_restaurante_restaurante_idrestaurante`, `user_has_restaurante_has_platillo_platillo_idplatillo`, `user_has_restaurante_has_ingrediente_user_has_restaurante_user_iduser`, `user_has_restaurante_has_ingrediente_user_has_restaurante_restaurante_idrestaurante`, `user_has_restaurante_has_ingrediente_ingrediente_idingrediente`),
  INDEX `fk_user_has_restaurante_has_platillo_has_user_has_restauran_idx` (`user_has_restaurante_has_ingrediente_user_has_restaurante_user_iduser` ASC, `user_has_restaurante_has_ingrediente_user_has_restaurante_restaurante_idrestaurante` ASC, `user_has_restaurante_has_ingrediente_ingrediente_idingrediente` ASC),
  INDEX `fk_user_has_restaurante_has_platillo_has_user_has_restauran_idx1` (`user_has_restaurante_has_platillo_user_has_restaurante_user_iduser` ASC, `user_has_restaurante_has_platillo_user_has_restaurante_restaurante_idrestaurante` ASC, `user_has_restaurante_has_platillo_platillo_idplatillo` ASC),
  CONSTRAINT `fk_user_has_restaurante_has_platillo_has_user_has_restaurante1`
    FOREIGN KEY (`user_has_restaurante_has_platillo_user_has_restaurante_user_iduser` , `user_has_restaurante_has_platillo_user_has_restaurante_restaurante_idrestaurante` , `user_has_restaurante_has_platillo_platillo_idplatillo`)
    REFERENCES `mydb`.`user_has_restaurante_has_platillo` (`user_has_restaurante_user_iduser` , `user_has_restaurante_restaurante_idrestaurante` , `platillo_idplatillo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_restaurante_has_platillo_has_user_has_restaurante2`
    FOREIGN KEY (`user_has_restaurante_has_ingrediente_user_has_restaurante_user_iduser` , `user_has_restaurante_has_ingrediente_user_has_restaurante_restaurante_idrestaurante` , `user_has_restaurante_has_ingrediente_ingrediente_idingrediente`)
    REFERENCES `mydb`.`user_has_restaurante_has_ingrediente` (`user_has_restaurante_user_iduser` , `user_has_restaurante_restaurante_idrestaurante` , `ingrediente_idingrediente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
