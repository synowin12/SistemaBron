-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema t2_bron
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema t2_bron
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `t2_bron` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `t2_bron` ;

-- -----------------------------------------------------
-- Table `t2_bron`.`almacenes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `t2_bron`.`almacenes` (
  `idalmacenes` INT NOT NULL AUTO_INCREMENT,
  `nombrealmacen` VARCHAR(45) NOT NULL,
  `direccionalmacen` VARCHAR(150) NOT NULL,
  `telefono` VARCHAR(9) NOT NULL,
  PRIMARY KEY (`idalmacenes`))
ENGINE = InnoDB
AUTO_INCREMENT = 29
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `t2_bron`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `t2_bron`.`categoria` (
  `idcategoria` INT NOT NULL AUTO_INCREMENT,
  `categorianombre` VARCHAR(45) NOT NULL,
  `comentario_categoria` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idcategoria`))
ENGINE = InnoDB
AUTO_INCREMENT = 20
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `t2_bron`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `t2_bron`.`cliente` (
  `idcliente` INT NOT NULL AUTO_INCREMENT,
  `dnicliente` VARCHAR(8) NOT NULL,
  `nombres` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(9) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  PRIMARY KEY (`idcliente`),
  UNIQUE INDEX `dnicliente_UNIQUE` (`dnicliente` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 18
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `t2_bron`.`productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `t2_bron`.`productos` (
  `idproductos` INT NOT NULL AUTO_INCREMENT,
  `marca` VARCHAR(45) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `modelo` VARCHAR(45) NOT NULL,
  `genero` VARCHAR(45) NOT NULL,
  `precio` DECIMAL(10,2) NOT NULL,
  `descripcion` VARCHAR(400) NOT NULL,
  `id_categoria` INT NOT NULL,
  PRIMARY KEY (`idproductos`),
  INDEX `fk_Productos_Categoria1_idx` (`id_categoria` ASC) VISIBLE,
  CONSTRAINT `fk_Productos_Categoria1`
    FOREIGN KEY (`id_categoria`)
    REFERENCES `t2_bron`.`categoria` (`idcategoria`))
ENGINE = InnoDB
AUTO_INCREMENT = 33
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `t2_bron`.`productos_asignados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `t2_bron`.`productos_asignados` (
  `idasignados` INT NOT NULL AUTO_INCREMENT,
  `cantidad_asignada` INT NOT NULL,
  `almacenes_idalmacenes` INT NOT NULL,
  `productos_idproductos` INT NOT NULL,
  PRIMARY KEY (`idasignados`),
  INDEX `fk_productos_asignados_almacenes_idx` (`almacenes_idalmacenes` ASC) VISIBLE,
  INDEX `fk_productos_asignados_productos1_idx` (`productos_idproductos` ASC) VISIBLE,
  CONSTRAINT `fk_productos_asignados_almacenes`
    FOREIGN KEY (`almacenes_idalmacenes`)
    REFERENCES `t2_bron`.`almacenes` (`idalmacenes`),
  CONSTRAINT `fk_productos_asignados_productos1`
    FOREIGN KEY (`productos_idproductos`)
    REFERENCES `t2_bron`.`productos` (`idproductos`))
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `t2_bron`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `t2_bron`.`usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `enabled` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 31
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `t2_bron`.`roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `t2_bron`.`roles` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `usuario_id` INT NOT NULL,
  `authority` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_roles_usuarios_idx` (`usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_roles_usuarios`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `t2_bron`.`usuario` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 32
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `t2_bron`.`t_proveedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `t2_bron`.`t_proveedor` (
  `id_proveedor` INT NOT NULL AUTO_INCREMENT,
  `ruc` VARCHAR(11) NOT NULL,
  `razon_social` VARCHAR(100) NOT NULL,
  `direccion` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(15) NOT NULL,
  `mail` VARCHAR(80) NOT NULL,
  `observacion` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`id_proveedor`),
  UNIQUE INDEX `ruc_UNIQUE` (`ruc` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 9
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `t2_bron`.`t_entrada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `t2_bron`.`t_entrada` (
  `id_entrada` INT NOT NULL AUTO_INCREMENT,
  `fecha_entrada` DATE NOT NULL,
  `observacion` VARCHAR(100) NOT NULL,
  `id_proveedor` INT NOT NULL,
  PRIMARY KEY (`id_entrada`),
  INDEX `fk_t_entrada_t_proveedor_idx` (`id_proveedor` ASC) VISIBLE,
  CONSTRAINT `fk_t_entrada_t_proveedor`
    FOREIGN KEY (`id_proveedor`)
    REFERENCES `t2_bron`.`t_proveedor` (`id_proveedor`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `t2_bron`.`t_detalle_entrada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `t2_bron`.`t_detalle_entrada` (
  `id_detalle_entrada` INT NOT NULL AUTO_INCREMENT,
  `id_entrada` INT NOT NULL,
  `cantidad` INT NOT NULL,
  `id_productos` INT NOT NULL,
  `id_almacenes` INT NOT NULL,
  PRIMARY KEY (`id_detalle_entrada`),
  INDEX `fk_t_detalle_entrada_t_entrada1_idx` (`id_entrada` ASC) VISIBLE,
  INDEX `fk_t_detalle_entrada_productos1_idx` (`id_productos` ASC) VISIBLE,
  INDEX `fk_t_detalle_entrada_almacenes1_idx` (`id_almacenes` ASC) VISIBLE,
  CONSTRAINT `fk_t_detalle_entrada_almacenes1`
    FOREIGN KEY (`id_almacenes`)
    REFERENCES `t2_bron`.`almacenes` (`idalmacenes`),
  CONSTRAINT `fk_t_detalle_entrada_productos1`
    FOREIGN KEY (`id_productos`)
    REFERENCES `t2_bron`.`productos` (`idproductos`),
  CONSTRAINT `fk_t_detalle_entrada_t_entrada1`
    FOREIGN KEY (`id_entrada`)
    REFERENCES `t2_bron`.`t_entrada` (`id_entrada`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `t2_bron`.`t_salida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `t2_bron`.`t_salida` (
  `id_salida` INT NOT NULL AUTO_INCREMENT,
  `fecha_registro` DATE NOT NULL,
  `observacion` VARCHAR(100) NOT NULL,
  `idcliente` INT NOT NULL,
  PRIMARY KEY (`id_salida`),
  INDEX `fk_t_salida_cliente1_idx` (`idcliente` ASC) VISIBLE,
  CONSTRAINT `fk_t_salida_cliente1`
    FOREIGN KEY (`idcliente`)
    REFERENCES `t2_bron`.`cliente` (`idcliente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `t2_bron`.`t_detalle_salida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `t2_bron`.`t_detalle_salida` (
  `id_detalle_salida` INT NOT NULL AUTO_INCREMENT,
  `id_salida` INT NOT NULL,
  `idproductos` INT NOT NULL,
  `cantidad` VARCHAR(45) NOT NULL,
  `idalmacenes` INT NOT NULL,
  PRIMARY KEY (`id_detalle_salida`),
  INDEX `fk_t_detalle_salida_t_salida1_idx` (`id_salida` ASC) VISIBLE,
  INDEX `fk_t_detalle_salida_productos1_idx` (`idproductos` ASC) VISIBLE,
  INDEX `fk_t_detalle_salida_almacenes1_idx` (`idalmacenes` ASC) VISIBLE,
  CONSTRAINT `fk_t_detalle_salida_almacenes1`
    FOREIGN KEY (`idalmacenes`)
    REFERENCES `t2_bron`.`almacenes` (`idalmacenes`),
  CONSTRAINT `fk_t_detalle_salida_productos1`
    FOREIGN KEY (`idproductos`)
    REFERENCES `t2_bron`.`productos` (`idproductos`),
  CONSTRAINT `fk_t_detalle_salida_t_salida1`
    FOREIGN KEY (`id_salida`)
    REFERENCES `t2_bron`.`t_salida` (`id_salida`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
