-- MySQL Script generated by MySQL Workbench
-- Thu Jun 20 01:25:32 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bf_easy_bd
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bf_easy_bd
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bf_easy_bd` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `bf_easy_bd` ;

-- -----------------------------------------------------
-- Table `bf_easy_bd`.`administradores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bf_easy_bd`.`administradores` (
  `cod_admin` CHAR(8) NOT NULL,
  `nombres` VARCHAR(45) NULL DEFAULT NULL,
  `apellidos` VARCHAR(45) NULL DEFAULT NULL,
  `cargo` VARCHAR(45) NULL,
  PRIMARY KEY (`cod_admin`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bf_easy_bd`.`alumnos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bf_easy_bd`.`alumnos` (
  `cod_alumno` CHAR(8) NOT NULL,
  `nombres` VARCHAR(45) NULL DEFAULT NULL,
  `apellidos` VARCHAR(45) NULL DEFAULT NULL,
  `escuela_prof` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`cod_alumno`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bf_easy_bd`.`carnets`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bf_easy_bd`.`carnets` (
  `id_carnet` INT NOT NULL AUTO_INCREMENT COMMENT 'autoinc',
  `fecha_listo` DATE NULL DEFAULT NULL,
  `fecha_entrega` DATE NULL DEFAULT NULL,
  `fecha_venc` DATE NULL DEFAULT NULL,
  `estado` VARCHAR(45) NULL DEFAULT NULL COMMENT 'no solicitado, solicitado, aceptado, denegado, en espera, listo',
  PRIMARY KEY (`id_carnet`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bf_easy_bd`.`solicitudes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bf_easy_bd`.`solicitudes` (
  `id_solicitud` INT NOT NULL AUTO_INCREMENT COMMENT 'autoinc',
  `cod_alumno` CHAR(8) NOT NULL,
  `tipo_solic` CHAR(1) NULL DEFAULT NULL COMMENT 'L, P, C',
  `fecha_solicitud` DATE NULL DEFAULT NULL,
  `justif_solic` VARCHAR(360) NULL DEFAULT NULL,
  `estado_solic` VARCHAR(20) NULL DEFAULT NULL COMMENT 'aceptado, denegado',
  `admin_encargado` CHAR(8) NOT NULL,
  `observ_solic` VARCHAR(360) NULL DEFAULT NULL,
  PRIMARY KEY (`id_solicitud`),
  INDEX `cod_alumno` (`cod_alumno` ASC) VISIBLE,
  INDEX `admin_encargado` (`admin_encargado` ASC) VISIBLE,
  CONSTRAINT `solicitudes_ibfk_1`
    FOREIGN KEY (`cod_alumno`)
    REFERENCES `bf_easy_bd`.`alumnos` (`cod_alumno`),
  CONSTRAINT `solicitudes_ibfk_2`
    FOREIGN KEY (`admin_encargado`)
    REFERENCES `bf_easy_bd`.`administradores` (`cod_admin`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bf_easy_bd`.`carnet_solicitud`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bf_easy_bd`.`carnet_solicitud` (
  `id_carn_sol` INT NOT NULL AUTO_INCREMENT COMMENT 'autoinc',
  `id_solicitud` INT NOT NULL,
  `id_carnet` INT NOT NULL,
  PRIMARY KEY (`id_carn_sol`),
  INDEX `id_carnet` (`id_carnet` ASC) VISIBLE,
  INDEX `fk_carnet_solicitud_solicitudes1_idx` (`id_solicitud` ASC) VISIBLE,
  CONSTRAINT `carnet_solicitud_ibfk_1`
    FOREIGN KEY (`id_carnet`)
    REFERENCES `bf_easy_bd`.`carnets` (`id_carnet`),
  CONSTRAINT `fk_carnet_solicitud_solicitudes1`
    FOREIGN KEY (`id_solicitud`)
    REFERENCES `bf_easy_bd`.`solicitudes` (`id_solicitud`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bf_easy_bd`.`libros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bf_easy_bd`.`libros` (
  `id_libro` INT NOT NULL AUTO_INCREMENT COMMENT 'autoinc',
  `isbn` VARCHAR(25) NULL DEFAULT NULL,
  `titulo` VARCHAR(180) NULL,
  `descrip` VARCHAR(360) NULL DEFAULT NULL,
  `autor` VARCHAR(90) NULL DEFAULT NULL,
  `editorial` VARCHAR(180) NULL DEFAULT NULL,
  `anio_publicacion` INT NULL DEFAULT NULL,
  `estado` VARCHAR(25) NULL DEFAULT NULL COMMENT 'disponible, reservado',
  PRIMARY KEY (`id_libro`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bf_easy_bd`.`libros_solicitudes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bf_easy_bd`.`libros_solicitudes` (
  `id_lib_sol` INT NOT NULL AUTO_INCREMENT COMMENT 'autoinc',
  `id_solicitud` INT NOT NULL,
  `id_libro` INT NOT NULL,
  PRIMARY KEY (`id_lib_sol`),
  INDEX `id_libro` (`id_libro` ASC) VISIBLE,
  INDEX `id_solicitud` (`id_solicitud` ASC) VISIBLE,
  CONSTRAINT `libros_solicitudes_ibfk_1`
    FOREIGN KEY (`id_libro`)
    REFERENCES `bf_easy_bd`.`libros` (`id_libro`),
  CONSTRAINT `libros_solicitudes_ibfk_2`
    FOREIGN KEY (`id_solicitud`)
    REFERENCES `bf_easy_bd`.`solicitudes` (`id_solicitud`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bf_easy_bd`.`tematicas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bf_easy_bd`.`tematicas` (
  `id_tematica` INT NOT NULL AUTO_INCREMENT COMMENT 'autoinc',
  `nombre_tematica` VARCHAR(90) NULL DEFAULT NULL,
  PRIMARY KEY (`id_tematica`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bf_easy_bd`.`libros_tematicas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bf_easy_bd`.`libros_tematicas` (
  `id_lib_tem` INT NOT NULL AUTO_INCREMENT COMMENT 'autoinc',
  `id_libro` INT NOT NULL,
  `id_tematica` INT NOT NULL,
  PRIMARY KEY (`id_lib_tem`),
  INDEX `id_libro` (`id_libro` ASC) VISIBLE,
  INDEX `id_tematica` (`id_tematica` ASC) VISIBLE,
  CONSTRAINT `libros_tematicas_ibfk_1`
    FOREIGN KEY (`id_libro`)
    REFERENCES `bf_easy_bd`.`libros` (`id_libro`),
  CONSTRAINT `libros_tematicas_ibfk_2`
    FOREIGN KEY (`id_tematica`)
    REFERENCES `bf_easy_bd`.`tematicas` (`id_tematica`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bf_easy_bd`.`pupitres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bf_easy_bd`.`pupitres` (
  `id_pupitre` INT NOT NULL AUTO_INCREMENT COMMENT 'autoinc',
  `ubicacion` CHAR(6) NULL DEFAULT NULL COMMENT 'ej. F01C02',
  `estado` VARCHAR(45) NULL DEFAULT NULL COMMENT 'disponible, reservado, en uso, inhabilitado',
  PRIMARY KEY (`id_pupitre`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bf_easy_bd`.`pupitre_solicitud`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bf_easy_bd`.`pupitre_solicitud` (
  `id_pup_sol` INT NOT NULL AUTO_INCREMENT COMMENT 'autoinc',
  `id_solicitud` INT NOT NULL,
  `id_pupitre` INT NOT NULL,
  PRIMARY KEY (`id_pup_sol`),
  INDEX `id_pupitre` (`id_pupitre` ASC) VISIBLE,
  INDEX `fk_pupitre_solicitud_solicitudes1_idx` (`id_solicitud` ASC) VISIBLE,
  CONSTRAINT `pupitre_solicitud_ibfk_1`
    FOREIGN KEY (`id_pupitre`)
    REFERENCES `bf_easy_bd`.`pupitres` (`id_pupitre`),
  CONSTRAINT `fk_pupitre_solicitud_solicitudes1`
    FOREIGN KEY (`id_solicitud`)
    REFERENCES `bf_easy_bd`.`solicitudes` (`id_solicitud`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bf_easy_bd`.`reservas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bf_easy_bd`.`reservas` (
  `id_reserva` INT NOT NULL AUTO_INCREMENT COMMENT 'autoinc',
  `id_solicitud` INT NOT NULL,
  `fecha_reserva` DATE NULL DEFAULT NULL,
  `fecha_entrega` DATE NULL DEFAULT NULL,
  `estado_reser` VARCHAR(20) NULL DEFAULT NULL COMMENT 'pendiente, entregado, sancionado',
  PRIMARY KEY (`id_reserva`),
  INDEX `fk_reservas_solicitudes1_idx` (`id_solicitud` ASC) VISIBLE,
  CONSTRAINT `fk_reservas_solicitudes1`
    FOREIGN KEY (`id_solicitud`)
    REFERENCES `bf_easy_bd`.`solicitudes` (`id_solicitud`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bf_easy_bd`.`sanciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bf_easy_bd`.`sanciones` (
  `id_sanc` INT NOT NULL AUTO_INCREMENT COMMENT 'autoinc',
  `id_reserva` INT NOT NULL,
  `fecha_sanc` DATE NULL DEFAULT NULL,
  `descrip_sanc` VARCHAR(360) NULL DEFAULT NULL,
  `estado_sanc` VARCHAR(20) NULL DEFAULT NULL COMMENT 'pendiente, saldado',
  PRIMARY KEY (`id_sanc`),
  INDEX `fk_sanciones_reservas1_idx` (`id_reserva` ASC) VISIBLE,
  CONSTRAINT `fk_sanciones_reservas1`
    FOREIGN KEY (`id_reserva`)
    REFERENCES `bf_easy_bd`.`reservas` (`id_reserva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bf_easy_bd`.`usuarios_sist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bf_easy_bd`.`usuarios_sist` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT COMMENT 'autoinc',
  `cod_admin` CHAR(8) NULL DEFAULT NULL,
  `cod_alumno` CHAR(8) NULL DEFAULT NULL,
  `username` VARCHAR(50) NULL DEFAULT NULL,
  `password` VARCHAR(255) NULL DEFAULT NULL,
  `rol` VARCHAR(50) NULL DEFAULT NULL COMMENT 'admin, user, etc.',
  PRIMARY KEY (`id_usuario`),
  UNIQUE INDEX `username` (`username` ASC) VISIBLE,
  INDEX `fk_usuarios_sist_alumnos1_idx` (`cod_alumno` ASC) VISIBLE,
  INDEX `fk_usuarios_sist_administradores1_idx` (`cod_admin` ASC) VISIBLE,
  CONSTRAINT `fk_usuarios_sist_alumnos1`
    FOREIGN KEY (`cod_alumno`)
    REFERENCES `bf_easy_bd`.`alumnos` (`cod_alumno`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_sist_administradores1`
    FOREIGN KEY (`cod_admin`)
    REFERENCES `bf_easy_bd`.`administradores` (`cod_admin`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
