SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `proyecto_001` ;
CREATE SCHEMA IF NOT EXISTS `proyecto_001` DEFAULT CHARACTER SET utf8 ;
USE `proyecto_001` ;

-- -----------------------------------------------------
-- Table `proyecto_001`.`almacen`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_001`.`almacen` ;

CREATE TABLE IF NOT EXISTS `proyecto_001`.`almacen` (
  `cod_almacen` INT(11) NOT NULL AUTO_INCREMENT,
  `almacen` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `direccion` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `detalle` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `registro` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  PRIMARY KEY (`cod_almacen`))
ENGINE = InnoDB
AUTO_INCREMENT = 2;


-- -----------------------------------------------------
-- Table `proyecto_001`.`area`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_001`.`area` ;

CREATE TABLE IF NOT EXISTS `proyecto_001`.`area` (
  `cod_area` INT(11) NOT NULL AUTO_INCREMENT,
  `area` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `detalle` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `registro` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  PRIMARY KEY (`cod_area`))
ENGINE = InnoDB
AUTO_INCREMENT = 8;


-- -----------------------------------------------------
-- Table `proyecto_001`.`marca`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_001`.`marca` ;

CREATE TABLE IF NOT EXISTS `proyecto_001`.`marca` (
  `cod_marca` INT(11) NOT NULL AUTO_INCREMENT,
  `descripcion` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `registro` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  PRIMARY KEY (`cod_marca`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_001`.`familia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_001`.`familia` ;

CREATE TABLE IF NOT EXISTS `proyecto_001`.`familia` (
  `cod_familia` INT(11) NOT NULL AUTO_INCREMENT,
  `familia` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `observacion` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `registro` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  PRIMARY KEY (`cod_familia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_001`.`articulo_producto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_001`.`articulo_producto` ;

CREATE TABLE IF NOT EXISTS `proyecto_001`.`articulo_producto` (
  `cod_articulo_producto` INT(11) NOT NULL AUTO_INCREMENT,
  `cod_referencia` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `descripcion` VARCHAR(500) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `precio_venta` DOUBLE(10,2) NOT NULL DEFAULT '0.00',
  `precio_venta_rango` INT(11) NOT NULL DEFAULT '0',
  `precio_cash` DOUBLE(10,2) NULL DEFAULT 0.00,
  `unidad_medida` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT 'UNIDAD',
  `usar_serie_numero` BIT(1) NULL DEFAULT b'0',
  `reintegro_tributario` BIT(1) NULL DEFAULT b'0',
  `observaciones` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `foto` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `familia_cod_familia` INT(11) NOT NULL,
  `marca_cod_marca` INT(11) NOT NULL,
  `registro` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  PRIMARY KEY (`cod_articulo_producto`),
  INDEX `fk_articulo_producto_marca1_idx` (`marca_cod_marca` ASC),
  INDEX `fk_articulo_producto_familia1_idx` (`familia_cod_familia` ASC),
  CONSTRAINT `fk_articulo_producto_marca1`
    FOREIGN KEY (`marca_cod_marca`)
    REFERENCES `proyecto_001`.`marca` (`cod_marca`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_articulo_producto_familia1`
    FOREIGN KEY (`familia_cod_familia`)
    REFERENCES `proyecto_001`.`familia` (`cod_familia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_001`.`zona`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_001`.`zona` ;

CREATE TABLE IF NOT EXISTS `proyecto_001`.`zona` (
  `cod_zona` INT(11) NOT NULL AUTO_INCREMENT,
  `zona` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `descripcion` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `registro` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  PRIMARY KEY (`cod_zona`))
ENGINE = InnoDB
AUTO_INCREMENT = 2;


-- -----------------------------------------------------
-- Table `proyecto_001`.`persona`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_001`.`persona` ;

CREATE TABLE IF NOT EXISTS `proyecto_001`.`persona` (
  `cod_persona` INT(11) NOT NULL AUTO_INCREMENT,
  `nombres` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `nombresC` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `direccion` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `dni_pasaporte` VARCHAR(15) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `telefono1` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `telefono2` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `ruc` VARCHAR(15) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `email` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `foto` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `estado` BIT(1) NULL DEFAULT b'1',
  `fecha_nacimiento` DATE NULL DEFAULT NULL,
  `pagina_web` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `observaciones` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `logo` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `zona_cod_zona` INT(11) NOT NULL DEFAULT '6',
  `registro` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  PRIMARY KEY (`cod_persona`),
  INDEX `fk_persona_zona1` (`zona_cod_zona` ASC),
  CONSTRAINT `fk_persona_zona1`
    FOREIGN KEY (`zona_cod_zona`)
    REFERENCES `proyecto_001`.`zona` (`cod_zona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2;


-- -----------------------------------------------------
-- Table `proyecto_001`.`cobranza`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_001`.`cobranza` ;

CREATE TABLE IF NOT EXISTS `proyecto_001`.`cobranza` (
  `cod_cobranza` INT(11) NOT NULL AUTO_INCREMENT,
  `persona_cod_persona` INT(11) NOT NULL,
  `fecha_cobranza` DATETIME NULL DEFAULT NULL,
  `doc_serie_numero` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `saldo_anterior` DOUBLE(10,2) NOT NULL DEFAULT '0.00',
  `importe` DOUBLE(10,4) NOT NULL DEFAULT '0.0000',
  `saldo` DOUBLE(10,2) NOT NULL DEFAULT '0.00',
  `monto_pagado` DOUBLE(10,2) NULL DEFAULT 0.00,
  `observacion` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `registro` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  PRIMARY KEY (`cod_cobranza`),
  INDEX `fk_cobranza_persona1_idx` (`persona_cod_persona` ASC),
  CONSTRAINT `fk_cobranza_persona1`
    FOREIGN KEY (`persona_cod_persona`)
    REFERENCES `proyecto_001`.`persona` (`cod_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_001`.`ventas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_001`.`ventas` ;

CREATE TABLE IF NOT EXISTS `proyecto_001`.`ventas` (
  `cod_ventas` INT(11) NOT NULL AUTO_INCREMENT,
  `persona_cod_persona` INT(11) NOT NULL,
  `item_cantidad` INT(11) NULL DEFAULT NULL,
  `doc_serie_numero` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `tipo` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL DEFAULT 'CONTADO',
  `fecha` DATETIME NULL DEFAULT NULL,
  `moneda` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `sub_total` DOUBLE(10,2) NOT NULL,
  `descuento` DOUBLE(10,2) NOT NULL DEFAULT '0.00',
  `total` DOUBLE(10,2) NOT NULL,
  `valor_igv` DOUBLE(10,2) NOT NULL DEFAULT '0.00',
  `neto` DOUBLE(10,2) NOT NULL,
  `son` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `persona_cod_vendedor` INT(11) NOT NULL,
  `estado` BIT(1) NULL DEFAULT b'0',
  `observacion` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `cod_cliente` INT NOT NULL,
  `cliente` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `identificacion` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `direccion` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `doc_serie_numero_guia` VARCHAR(45) NULL,
  `direccion2` TEXT NULL,
  `direccion3` TEXT NULL,
  `duracion` VARCHAR(45) NULL DEFAULT '',
  `monto_inicial` DOUBLE(10,2) NOT NULL DEFAULT '0.00',
  `fecha_inicial_vencimiento` DATE NULL DEFAULT NULL,
  `cantidad_letras` INT(11) NOT NULL DEFAULT '0',
  `monto_letra` DOUBLE(10,2) NOT NULL DEFAULT '0.00',
  `fecha_vencimiento_letra_deuda` DATE NULL,
  `interes` DOUBLE(10,2) NOT NULL DEFAULT 0.00,
  `amortizado` DOUBLE(10,2) NOT NULL DEFAULT '0.00',
  `interes_pagado` DOUBLE(10,2) NOT NULL DEFAULT '0.00',
  `saldo` DOUBLE(10,2) NOT NULL DEFAULT '0.00',
  `registro` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  PRIMARY KEY (`cod_ventas`),
  INDEX `fk_ventas_persona1` (`persona_cod_persona` ASC),
  CONSTRAINT `fk_ventas_persona1`
    FOREIGN KEY (`persona_cod_persona`)
    REFERENCES `proyecto_001`.`persona` (`cod_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_001`.`venta_credito_letra`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_001`.`venta_credito_letra` ;

CREATE TABLE IF NOT EXISTS `proyecto_001`.`venta_credito_letra` (
  `cod_venta_credito_letra` INT(11) NOT NULL AUTO_INCREMENT,
  `ventas_cod_ventas` INT(11) NOT NULL,
  `moneda` INT(11) NULL,
  `numero_letra` INT(11) NULL DEFAULT NULL,
  `detalle_letra` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `fecha_vencimiento` DATETIME NULL DEFAULT NULL,
  `monto` DOUBLE(10,2) NULL DEFAULT '0.00',
  `interes` DOUBLE(10,2) NULL DEFAULT 0.00,
  `fecha_pago` DATETIME NULL DEFAULT NULL,
  `total_pago` DOUBLE(10,2) NULL DEFAULT 0.00,
  `interes_pagado` DOUBLE(10,2) NULL DEFAULT 0.00,
  `interes_pendiente` DOUBLE(10,2) NULL DEFAULT 0.00,
  `interes_ultimo_calculo` DATE NULL,
  `registro` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  PRIMARY KEY (`cod_venta_credito_letra`),
  INDEX `fk_venta_credito_letra_ventas1_idx` (`ventas_cod_ventas` ASC),
  CONSTRAINT `fk_venta_credito_letra_ventas1`
    FOREIGN KEY (`ventas_cod_ventas`)
    REFERENCES `proyecto_001`.`ventas` (`cod_ventas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_001`.`cobranza_detalle`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_001`.`cobranza_detalle` ;

CREATE TABLE IF NOT EXISTS `proyecto_001`.`cobranza_detalle` (
  `cod_cobranza_detalle` INT(11) NOT NULL AUTO_INCREMENT,
  `cobranza_cod_cobranza` INT(11) NOT NULL,
  `importe` DOUBLE(10,2) NULL DEFAULT 0.00,
  `interes` DOUBLE(10,2) NULL DEFAULT 0.00,
  `observacion` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `venta_credito_letra_cod_venta_credito_letra` INT(11) NOT NULL,
  `registro` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  PRIMARY KEY (`cod_cobranza_detalle`),
  INDEX `fk_cobranza_detalle_cobranza2` (`cobranza_cod_cobranza` ASC),
  INDEX `fk_cobranza_detalle_venta_credito_letra1_idx` (`venta_credito_letra_cod_venta_credito_letra` ASC),
  CONSTRAINT `fk_cobranza_detalle_cobranza2`
    FOREIGN KEY (`cobranza_cod_cobranza`)
    REFERENCES `proyecto_001`.`cobranza` (`cod_cobranza`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cobranza_detalle_venta_credito_letra1`
    FOREIGN KEY (`venta_credito_letra_cod_venta_credito_letra`)
    REFERENCES `proyecto_001`.`venta_credito_letra` (`cod_venta_credito_letra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_001`.`proveedor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_001`.`proveedor` ;

CREATE TABLE IF NOT EXISTS `proyecto_001`.`proveedor` (
  `cod_proveedor` INT(11) NOT NULL AUTO_INCREMENT,
  `ruc` VARCHAR(11) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `razon_social` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `direccion` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `telefono` VARCHAR(15) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `email` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `pagina_web` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `observaciones` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `logo` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `registro` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  PRIMARY KEY (`cod_proveedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_001`.`compra`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_001`.`compra` ;

CREATE TABLE IF NOT EXISTS `proyecto_001`.`compra` (
  `cod_compra` INT(11) NOT NULL AUTO_INCREMENT,
  `proveedor_cod_proveedor` INT(11) NOT NULL,
  `tipo` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `item_cantidad` INT(11) NOT NULL,
  `doc_serie_numero` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `fecha_factura` DATETIME NULL DEFAULT NULL,
  `fecha_vencimiento` DATETIME NULL DEFAULT NULL,
  `fecha_llegada` DATETIME NULL DEFAULT NULL,
  `sub_total` DOUBLE(10,4) NOT NULL,
  `total` DOUBLE(10,4) NOT NULL,
  `monto_igv` DOUBLE(10,4) NULL DEFAULT '0.0000',
  `neto` DOUBLE(10,4) NULL DEFAULT NULL,
  `son` VARCHAR(200) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `moneda` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `observacion` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `registro` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  PRIMARY KEY (`cod_compra`),
  INDEX `fk_compra_proveedor1` (`proveedor_cod_proveedor` ASC),
  CONSTRAINT `fk_compra_proveedor1`
    FOREIGN KEY (`proveedor_cod_proveedor`)
    REFERENCES `proyecto_001`.`proveedor` (`cod_proveedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_001`.`compra_detalle`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_001`.`compra_detalle` ;

CREATE TABLE IF NOT EXISTS `proyecto_001`.`compra_detalle` (
  `cod_compra_detalle` INT(11) NOT NULL AUTO_INCREMENT,
  `compra_cod_compra` INT(11) NOT NULL,
  `articulo_producto_cod_articulo_producto` INT(11) NOT NULL,
  `cantidad` INT(11) NOT NULL,
  `descripcion` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `precio_unitario` DOUBLE(10,4) NULL DEFAULT NULL,
  `precio_total` DOUBLE(10,4) NULL DEFAULT NULL,
  `item` INT(11) NULL DEFAULT NULL,
  `detalle` VARCHAR(200) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `almacen_cod_almacen` INT(11) NOT NULL,
  `registro` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  PRIMARY KEY (`cod_compra_detalle`),
  INDEX `fk_compra_detalle_compra1` (`compra_cod_compra` ASC),
  INDEX `fk_compra_detalle_articulo_producto1` (`articulo_producto_cod_articulo_producto` ASC),
  INDEX `fk_compra_detalle_almacen1_idx` (`almacen_cod_almacen` ASC),
  CONSTRAINT `fk_compra_detalle_almacen1`
    FOREIGN KEY (`almacen_cod_almacen`)
    REFERENCES `proyecto_001`.`almacen` (`cod_almacen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_compra_detalle_articulo_producto1`
    FOREIGN KEY (`articulo_producto_cod_articulo_producto`)
    REFERENCES `proyecto_001`.`articulo_producto` (`cod_articulo_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_compra_detalle_compra1`
    FOREIGN KEY (`compra_cod_compra`)
    REFERENCES `proyecto_001`.`compra` (`cod_compra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_001`.`compra_serie_numero`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_001`.`compra_serie_numero` ;

CREATE TABLE IF NOT EXISTS `proyecto_001`.`compra_serie_numero` (
  `cod_compra_serie_numero` INT(11) NOT NULL AUTO_INCREMENT,
  `compra_detalle_cod_compra_detalle` INT(11) NOT NULL,
  `serie_numero` TEXT CHARACTER SET 'latin1' NULL DEFAULT NULL,
  `observacion` TEXT CHARACTER SET 'latin1' NULL,
  `registro` TEXT CHARACTER SET 'latin1' NOT NULL,
  PRIMARY KEY (`cod_compra_serie_numero`),
  INDEX `fk_compra_serie_numero_compra_detalle1` (`compra_detalle_cod_compra_detalle` ASC),
  CONSTRAINT `fk_compra_serie_numero_compra_detalle1`
    FOREIGN KEY (`compra_detalle_cod_compra_detalle`)
    REFERENCES `proyecto_001`.`compra_detalle` (`cod_compra_detalle`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_001`.`comprobante_pago`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_001`.`comprobante_pago` ;

CREATE TABLE IF NOT EXISTS `proyecto_001`.`comprobante_pago` (
  `cod_comprobante_pago` INT(11) NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `serie` VARCHAR(10) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `registro` TEXT NOT NULL,
  PRIMARY KEY (`cod_comprobante_pago`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_001`.`empresa_convenio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_001`.`empresa_convenio` ;

CREATE TABLE IF NOT EXISTS `proyecto_001`.`empresa_convenio` (
  `cod_empresa_convenio` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `abreviatura` VARCHAR(10) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `cod_cobranza` VARCHAR(10) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `interes_asigando` BIT NOT NULL DEFAULT 0,
  `interes_automatico` BIT NOT NULL DEFAULT 0,
  `registro` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  PRIMARY KEY (`cod_empresa_convenio`))
ENGINE = InnoDB
AUTO_INCREMENT = 2;


-- -----------------------------------------------------
-- Table `proyecto_001`.`datos_cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_001`.`datos_cliente` ;

CREATE TABLE IF NOT EXISTS `proyecto_001`.`datos_cliente` (
  `cod_datos_cliente` INT(11) NOT NULL AUTO_INCREMENT,
  `tipo_cliente` INT(11) NULL DEFAULT '0',
  `persona_cod_persona` INT(11) NOT NULL,
  `empresa_convenio_cod_empresa_convenio` INT(11) NOT NULL,
  `centro_trabajo` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `telefono` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `tipo` INT(5) NOT NULL,
  `condicion` INT(5) NULL DEFAULT NULL,
  `credito_max` DOUBLE(10,2) NOT NULL DEFAULT '0.00',
  `saldo_favor` DOUBLE(10,2) NOT NULL DEFAULT '0.00',
  `interes_evitar` DATE NULL,
  `interes_evitar_permanente` BIT NOT NULL DEFAULT 0,
  `observaciones` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL,
  `cod_cobrador` INT(11) NOT NULL DEFAULT 0,
  `persona_cod_garante` INT(11) NOT NULL DEFAULT 0,
  `registro` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  PRIMARY KEY (`cod_datos_cliente`),
  INDEX `fk_datos_laborales_empresa_convenio1` (`empresa_convenio_cod_empresa_convenio` ASC),
  INDEX `fk_datos_laborales_persona1` (`persona_cod_persona` ASC),
  CONSTRAINT `fk_datos_laborales_empresa_convenio1`
    FOREIGN KEY (`empresa_convenio_cod_empresa_convenio`)
    REFERENCES `proyecto_001`.`empresa_convenio` (`cod_empresa_convenio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_datos_laborales_persona1`
    FOREIGN KEY (`persona_cod_persona`)
    REFERENCES `proyecto_001`.`persona` (`cod_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_001`.`datos_extras`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_001`.`datos_extras` ;

CREATE TABLE IF NOT EXISTS `proyecto_001`.`datos_extras` (
  `cod_datos_extras` INT(11) NOT NULL AUTO_INCREMENT,
  `cod_seguimiento` VARCHAR(45) NULL,
  `descripcion_dato` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL,
  `letras` TEXT NULL,
  `abreviatura` VARCHAR(45) NULL,
  `entero` INT(11) NULL DEFAULT '0',
  `decimal_dato` DOUBLE(10,4) NULL DEFAULT '0.0000',
  `registro` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  PRIMARY KEY (`cod_datos_extras`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_001`.`detalle_descripcion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_001`.`detalle_descripcion` ;

CREATE TABLE IF NOT EXISTS `proyecto_001`.`detalle_descripcion` (
  `cod_detalle_descripcion` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre_descripcion` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `detalle_descripcion` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `compra_detalle_cod_compra_detalle` INT(11) NOT NULL,
  `estado` BIT(1) NULL DEFAULT b'0',
  `registro` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  PRIMARY KEY (`cod_detalle_descripcion`),
  INDEX `fk_compra_serie_compra_detalle1` (`compra_detalle_cod_compra_detalle` ASC),
  CONSTRAINT `fk_compra_serie_compra_detalle1`
    FOREIGN KEY (`compra_detalle_cod_compra_detalle`)
    REFERENCES `proyecto_001`.`compra_detalle` (`cod_compra_detalle`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'para registra, numero de serie, numero de motor, numero de c /* comment truncated */ /* /* comment truncated */ /*hasis...*/*/';


-- -----------------------------------------------------
-- Table `proyecto_001`.`estado_documento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_001`.`estado_documento` ;

CREATE TABLE IF NOT EXISTS `proyecto_001`.`estado_documento` (
  `cod_estado_documento` INT(11) NOT NULL AUTO_INCREMENT,
  `estado_documento` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `detalle` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `registro` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  PRIMARY KEY (`cod_estado_documento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_001`.`kardex_articulo_producto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_001`.`kardex_articulo_producto` ;

CREATE TABLE IF NOT EXISTS `proyecto_001`.`kardex_articulo_producto` (
  `cod_kardex_articulo_producto` INT(11) NOT NULL AUTO_INCREMENT,
  `articulo_producto_cod_articulo_producto` INT(11) NOT NULL,
  `cod_operacion` INT(11) NOT NULL,
  `cod_operacion_detalle` INT(11) NOT NULL DEFAULT '0',
  `tipo_operacion` INT(11) NOT NULL,
  `detalle` VARCHAR(250) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `entrada` INT(11) NULL DEFAULT NULL,
  `salida` INT(11) NULL DEFAULT NULL,
  `stock` INT(11) NULL DEFAULT NULL,
  `precio` DOUBLE(10,4) NULL DEFAULT NULL,
  `precio_ponderado` DOUBLE(10,4) NULL DEFAULT NULL,
  `total` DOUBLE(10,4) NULL DEFAULT NULL,
  `almacen_cod_almacen` INT(11) NOT NULL,
  `observacion` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `registro` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  PRIMARY KEY (`cod_kardex_articulo_producto`),
  INDEX `fk_kardex_articulo_producto_articulo_producto1` (`articulo_producto_cod_articulo_producto` ASC),
  INDEX `fk_kardex_articulo_producto_almacen1_idx` (`almacen_cod_almacen` ASC),
  CONSTRAINT `fk_kardex_articulo_producto_almacen1`
    FOREIGN KEY (`almacen_cod_almacen`)
    REFERENCES `proyecto_001`.`almacen` (`cod_almacen`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_kardex_articulo_producto_articulo_producto1`
    FOREIGN KEY (`articulo_producto_cod_articulo_producto`)
    REFERENCES `proyecto_001`.`articulo_producto` (`cod_articulo_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = '	total=precio_ponderado*stocken caso se compre	precio_pond / /* comment truncated */ /** comment truncated */ /*erado= (total_anterior+(cantidad_comprada*precio_unitario))/stocken venta	precio_ponderado=precio_ponderado_anterior*/*/';


-- -----------------------------------------------------
-- Table `proyecto_001`.`kardex_serie_numero`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_001`.`kardex_serie_numero` ;

CREATE TABLE IF NOT EXISTS `proyecto_001`.`kardex_serie_numero` (
  `cod_kardex_serie_numero` INT(11) NOT NULL AUTO_INCREMENT,
  `kardex_articulo_producto_cod_kardex_articulo_producto` INT(11) NOT NULL,
  `serie_numero` TEXT CHARACTER SET 'latin1' NULL DEFAULT NULL,
  `observacion` TEXT CHARACTER SET 'latin1' NULL,
  `compra_serie_numero_cod_compra_serie_numero` INT(11) NOT NULL DEFAULT 0,
  `registro` TEXT CHARACTER SET 'latin1' NOT NULL,
  PRIMARY KEY (`cod_kardex_serie_numero`),
  INDEX `fk_kardex_serie_numero_kardex_articulo_producto1_idx` (`kardex_articulo_producto_cod_kardex_articulo_producto` ASC),
  CONSTRAINT `fk_kardex_serie_numero_kardex_articulo_producto1`
    FOREIGN KEY (`kardex_articulo_producto_cod_kardex_articulo_producto`)
    REFERENCES `proyecto_001`.`kardex_articulo_producto` (`cod_kardex_articulo_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_001`.`p_natural`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_001`.`p_natural` ;

CREATE TABLE IF NOT EXISTS `proyecto_001`.`p_natural` (
  `cod_natural` INT(11) NOT NULL AUTO_INCREMENT,
  `cod_modular` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `cargo` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `carben` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `ape_paterno` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `ape_materno` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `sexo` BIT(1) NULL DEFAULT NULL,
  `persona_cod_persona` INT(11) NOT NULL,
  `estado_civil` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `detalle` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `registro` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  PRIMARY KEY (`cod_natural`),
  INDEX `fk_natural_persona1_idx` (`persona_cod_persona` ASC),
  CONSTRAINT `fk_natural_persona1`
    FOREIGN KEY (`persona_cod_persona`)
    REFERENCES `proyecto_001`.`persona` (`cod_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 1904;


-- -----------------------------------------------------
-- Table `proyecto_001`.`cargo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_001`.`cargo` ;

CREATE TABLE IF NOT EXISTS `proyecto_001`.`cargo` (
  `cod_cargo` INT(11) NOT NULL AUTO_INCREMENT,
  `cargo` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `detalle` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `registro` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  PRIMARY KEY (`cod_cargo`))
ENGINE = InnoDB
AUTO_INCREMENT = 8;


-- -----------------------------------------------------
-- Table `proyecto_001`.`personal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_001`.`personal` ;

CREATE TABLE IF NOT EXISTS `proyecto_001`.`personal` (
  `cod_personal` INT(11) NOT NULL AUTO_INCREMENT,
  `fecha_inicio_actividades` DATE NULL DEFAULT NULL,
  `fecha_fin_actividades` DATE NULL DEFAULT NULL,
  `estado` BIT(1) NULL DEFAULT NULL,
  `observacion` TEXT NULL DEFAULT NULL,
  `persona_cod_persona` INT(11) NOT NULL,
  `cargo_cod_cargo` INT(11) NOT NULL,
  `area_cod_area` INT(11) NOT NULL,
  `registro` TEXT NOT NULL,
  PRIMARY KEY (`cod_personal`),
  INDEX `fk_personal_persona_idx` (`persona_cod_persona` ASC),
  INDEX `fk_personal_cargo1_idx` (`cargo_cod_cargo` ASC),
  INDEX `fk_personal_area1_idx` (`area_cod_area` ASC),
  CONSTRAINT `fk_personal_persona`
    FOREIGN KEY (`persona_cod_persona`)
    REFERENCES `proyecto_001`.`persona` (`cod_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_personal_cargo1`
    FOREIGN KEY (`cargo_cod_cargo`)
    REFERENCES `proyecto_001`.`cargo` (`cod_cargo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_personal_area1`
    FOREIGN KEY (`area_cod_area`)
    REFERENCES `proyecto_001`.`area` (`cod_area`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_001`.`precio_venta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_001`.`precio_venta` ;

CREATE TABLE IF NOT EXISTS `proyecto_001`.`precio_venta` (
  `cod_precio_venta` INT(11) NOT NULL AUTO_INCREMENT,
  `precio_venta` DOUBLE(10,2) NOT NULL DEFAULT '0.00',
  `observacion` TEXT CHARACTER SET 'latin1' NULL DEFAULT NULL,
  `articulo_producto_cod_articulo_producto` INT(11) NOT NULL,
  `cod_compra_detalle` INT(11) NOT NULL DEFAULT '0',
  `registro` TEXT CHARACTER SET 'latin1' NOT NULL,
  PRIMARY KEY (`cod_precio_venta`),
  INDEX `fk_precio_venta_articulo_producto1_idx` (`articulo_producto_cod_articulo_producto` ASC),
  CONSTRAINT `fk_precio_venta_articulo_producto1`
    FOREIGN KEY (`articulo_producto_cod_articulo_producto`)
    REFERENCES `proyecto_001`.`articulo_producto` (`cod_articulo_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_001`.`tipo_documento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_001`.`tipo_documento` ;

CREATE TABLE IF NOT EXISTS `proyecto_001`.`tipo_documento` (
  `cod_tipo_documento` INT(11) NOT NULL AUTO_INCREMENT,
  `tipo_documeto` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `detalle` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `registro` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  PRIMARY KEY (`cod_tipo_documento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_001`.`tramite_documentario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_001`.`tramite_documentario` ;

CREATE TABLE IF NOT EXISTS `proyecto_001`.`tramite_documentario` (
  `cod_tramite_documentario` INT(11) NOT NULL AUTO_INCREMENT,
  `ventas_cod_ventas` INT(11) NOT NULL,
  `tipo_documento_cod_tipo_documento` INT(11) NOT NULL,
  `estado_documento_cod_estado_documento` INT(11) NOT NULL,
  `fecha_solicitud` DATETIME NOT NULL,
  `fecha_probable_entrega` DATETIME NOT NULL,
  `fecha_entrega` DATETIME NOT NULL,
  `detalle` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL,
  `registro` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  PRIMARY KEY (`cod_tramite_documentario`),
  INDEX `fk_tramite_documentario_ventas1` (`ventas_cod_ventas` ASC),
  INDEX `fk_tramite_documentario_tipo_documento1` (`tipo_documento_cod_tipo_documento` ASC),
  INDEX `fk_tramite_documentario_estado_documento1` (`estado_documento_cod_estado_documento` ASC),
  CONSTRAINT `fk_tramite_documentario_estado_documento1`
    FOREIGN KEY (`estado_documento_cod_estado_documento`)
    REFERENCES `proyecto_001`.`estado_documento` (`cod_estado_documento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tramite_documentario_tipo_documento1`
    FOREIGN KEY (`tipo_documento_cod_tipo_documento`)
    REFERENCES `proyecto_001`.`tipo_documento` (`cod_tipo_documento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tramite_documentario_ventas1`
    FOREIGN KEY (`ventas_cod_ventas`)
    REFERENCES `proyecto_001`.`ventas` (`cod_ventas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_001`.`usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_001`.`usuario` ;

CREATE TABLE IF NOT EXISTS `proyecto_001`.`usuario` (
  `cod_usuario` INT(11) NOT NULL AUTO_INCREMENT,
  `usuario` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `contrasenia` VARCHAR(100) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `ip` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  `estado` BIT(1) NULL DEFAULT b'1',
  `persona_cod_persona` INT(11) NOT NULL,
  `p1` BIT(1) NULL DEFAULT b'0',
  `p2` BIT(1) NULL DEFAULT b'0',
  `p3` BIT(1) NULL DEFAULT b'0',
  `p4` BIT(1) NULL DEFAULT b'0',
  `p5` BIT(1) NULL DEFAULT b'0',
  `p6` BIT(1) NULL DEFAULT b'0',
  `p7` BIT(1) NULL DEFAULT b'0',
  `p8` BIT(1) NULL DEFAULT b'0',
  `p9` BIT(1) NULL DEFAULT b'0',
  `p10` BIT(1) NULL DEFAULT b'0',
  `p11` BIT(1) NULL DEFAULT b'0',
  `p12` BIT(1) NULL DEFAULT b'0',
  `p13` BIT(1) NULL DEFAULT b'0',
  `p14` BIT(1) NULL DEFAULT b'0',
  `p15` BIT(1) NULL DEFAULT b'0',
  `p16` BIT(1) NULL DEFAULT b'0',
  `p17` BIT(1) NULL DEFAULT b'0',
  `p18` BIT(1) NULL DEFAULT b'0',
  `p19` BIT(1) NULL DEFAULT b'0',
  `p20` BIT(1) NULL DEFAULT b'0',
  `p21` BIT(1) NULL DEFAULT b'0',
  `p22` BIT(1) NULL DEFAULT b'0',
  `p23` BIT(1) NULL DEFAULT b'0',
  `p24` BIT(1) NULL DEFAULT b'0',
  `p25` BIT(1) NULL DEFAULT b'0',
  `p26` BIT(1) NULL DEFAULT b'0',
  `p27` BIT(1) NULL DEFAULT b'0',
  `p28` BIT(1) NULL DEFAULT b'0',
  `p29` BIT(1) NULL DEFAULT b'0',
  `p30` BIT(1) NULL DEFAULT b'0',
  `p31` BIT(1) NULL DEFAULT b'0',
  `p32` BIT(1) NULL DEFAULT b'0',
  `p33` BIT(1) NULL DEFAULT b'0',
  `p34` BIT(1) NULL DEFAULT b'0',
  `p35` BIT(1) NULL DEFAULT b'0',
  `p36` BIT(1) NULL DEFAULT b'0',
  `p37` BIT(1) NULL DEFAULT b'0',
  `p38` BIT(1) NULL DEFAULT b'0',
  `p39` BIT(1) NULL DEFAULT b'0',
  `p40` BIT(1) NULL DEFAULT b'0',
  `p41` BIT(1) NULL DEFAULT 0,
  `p42` BIT(1) NULL DEFAULT 0,
  `p43` BIT(1) NULL DEFAULT 0,
  `p44` BIT(1) NULL DEFAULT 0,
  `p45` BIT(1) NULL DEFAULT 0,
  `p46` BIT(1) NULL DEFAULT 0,
  `p47` BIT(1) NULL DEFAULT 0,
  `p48` BIT(1) NULL DEFAULT 0,
  `p49` BIT(1) NULL DEFAULT 0,
  `p50` BIT(1) NULL DEFAULT 0,
  `p51` BIT(1) NULL DEFAULT 0,
  `p52` BIT(1) NULL DEFAULT 0,
  `p53` BIT(1) NULL DEFAULT 0,
  `p54` BIT(1) NULL DEFAULT 0,
  `p55` BIT(1) NULL DEFAULT 0,
  `p56` BIT(1) NULL DEFAULT 0,
  `p57` BIT(1) NULL DEFAULT 0,
  `p58` BIT(1) NULL DEFAULT 0,
  `p59` BIT(1) NULL DEFAULT 0,
  `p60` BIT(1) NULL DEFAULT 0,
  `registro` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  PRIMARY KEY (`cod_usuario`),
  UNIQUE INDEX `usuario_UNIQUE` (`usuario` ASC),
  INDEX `fk_usuario_persona1` (`persona_cod_persona` ASC),
  CONSTRAINT `fk_usuario_persona1`
    FOREIGN KEY (`persona_cod_persona`)
    REFERENCES `proyecto_001`.`persona` (`cod_persona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2
COMMENT = 'p1=acceso a usuarios, de todo tipo';


-- -----------------------------------------------------
-- Table `proyecto_001`.`ventas_detalle`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_001`.`ventas_detalle` ;

CREATE TABLE IF NOT EXISTS `proyecto_001`.`ventas_detalle` (
  `cod_ventas_detalle` INT(11) NOT NULL AUTO_INCREMENT,
  `ventas_cod_ventas` INT(11) NOT NULL,
  `item` INT(11) NULL DEFAULT NULL,
  `articulo_producto_cod_articulo_producto` INT(11) NOT NULL,
  `cantidad` INT(11) NULL DEFAULT NULL,
  `descripcion` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NULL DEFAULT NULL,
  `precio_real` DOUBLE(10,2) NOT NULL,
  `precio_proforma` DOUBLE(10,2) NOT NULL DEFAULT 0.00,
  `precio_cash` DOUBLE(10,2) NULL DEFAULT 0.00,
  `precio_venta` DOUBLE(10,2) NOT NULL,
  `valor_venta` DOUBLE(10,2) NOT NULL,
  `registro` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL,
  PRIMARY KEY (`cod_ventas_detalle`),
  INDEX `fk_ventas_detalle_ventas1` (`ventas_cod_ventas` ASC),
  INDEX `fk_ventas_detalle_articulo_producto1` (`articulo_producto_cod_articulo_producto` ASC),
  CONSTRAINT `fk_ventas_detalle_articulo_producto1`
    FOREIGN KEY (`articulo_producto_cod_articulo_producto`)
    REFERENCES `proyecto_001`.`articulo_producto` (`cod_articulo_producto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ventas_detalle_ventas1`
    FOREIGN KEY (`ventas_cod_ventas`)
    REFERENCES `proyecto_001`.`ventas` (`cod_ventas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_001`.`ventas_serie_numero`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_001`.`ventas_serie_numero` ;

CREATE TABLE IF NOT EXISTS `proyecto_001`.`ventas_serie_numero` (
  `cod_ventas_serie_numero` INT(11) NOT NULL AUTO_INCREMENT,
  `serie_numero` TEXT CHARACTER SET 'latin1' NULL DEFAULT NULL,
  `observacion` TEXT CHARACTER SET 'latin1' NULL DEFAULT NULL,
  `ventas_detalle_cod_ventas_detalle` INT(11) NOT NULL,
  `registro` TEXT CHARACTER SET 'latin1' NOT NULL,
  PRIMARY KEY (`cod_ventas_serie_numero`),
  INDEX `fk_ventas_serie_numero_ventas_detalle1_idx` (`ventas_detalle_cod_ventas_detalle` ASC),
  CONSTRAINT `fk_ventas_serie_numero_ventas_detalle1`
    FOREIGN KEY (`ventas_detalle_cod_ventas_detalle`)
    REFERENCES `proyecto_001`.`ventas_detalle` (`cod_ventas_detalle`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_001`.`comprobante_pago_detalle`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_001`.`comprobante_pago_detalle` ;

CREATE TABLE IF NOT EXISTS `proyecto_001`.`comprobante_pago_detalle` (
  `cod_comprobante_pago_detalle` INT(11) NOT NULL AUTO_INCREMENT,
  `comprobante_pago_cod_comprobante_pago` INT(11) NOT NULL,
  `doc_serie_numero` VARCHAR(45) NOT NULL,
  `estado` BIT NULL DEFAULT 0,
  `numero` VARCHAR(45) NOT NULL,
  `registro` TEXT NOT NULL,
  PRIMARY KEY (`cod_comprobante_pago_detalle`),
  INDEX `fk_comprobante_pago_detalle_comprobante_pago1_idx` (`comprobante_pago_cod_comprobante_pago` ASC),
  CONSTRAINT `fk_comprobante_pago_detalle_comprobante_pago1`
    FOREIGN KEY (`comprobante_pago_cod_comprobante_pago`)
    REFERENCES `proyecto_001`.`comprobante_pago` (`cod_comprobante_pago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_001`.`otros_c_c`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_001`.`otros_c_c` ;

CREATE TABLE IF NOT EXISTS `proyecto_001`.`otros_c_c` (
  `cod_otros_c_c` INT(11) NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(45) NOT NULL,
  `empresa_convenio_cod_empresa_convenio` INT(11) NOT NULL,
  `registro` TEXT NOT NULL,
  PRIMARY KEY (`cod_otros_c_c`),
  INDEX `fk_otros_c_c_empresa_convenio1_idx` (`empresa_convenio_cod_empresa_convenio` ASC),
  CONSTRAINT `fk_otros_c_c_empresa_convenio1`
    FOREIGN KEY (`empresa_convenio_cod_empresa_convenio`)
    REFERENCES `proyecto_001`.`empresa_convenio` (`cod_empresa_convenio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `proyecto_001`.`documento_notificacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `proyecto_001`.`documento_notificacion` ;

CREATE TABLE IF NOT EXISTS `proyecto_001`.`documento_notificacion` (
  `cod_documento_notificacion` INT(11) NOT NULL AUTO_INCREMENT,
  `datos_cliente_cod_datos_cliente` INT(11) NOT NULL,
  `fech1` DATE NULL DEFAULT NULL,
  `fech2` DATE NULL DEFAULT NULL,
  `fech3` DATE NULL DEFAULT NULL,
  `varchar1` VARCHAR(45) NULL DEFAULT NULL,
  `varchar2` VARCHAR(45) NULL DEFAULT NULL,
  `text1` TEXT NULL DEFAULT NULL,
  `text2` TEXT NULL DEFAULT NULL,
  `text3` TEXT NULL DEFAULT NULL,
  `registro` TEXT NOT NULL,
  PRIMARY KEY (`cod_documento_notificacion`),
  INDEX `fk_documento_notificacion_datos_cliente1_idx` (`datos_cliente_cod_datos_cliente` ASC),
  CONSTRAINT `fk_documento_notificacion_datos_cliente1`
    FOREIGN KEY (`datos_cliente_cod_datos_cliente`)
    REFERENCES `proyecto_001`.`datos_cliente` (`cod_datos_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
