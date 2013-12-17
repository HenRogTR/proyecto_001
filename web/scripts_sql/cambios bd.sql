-- actualizar orden de columnas venta_credito
ALTER TABLE `venta_credito` 
CHANGE COLUMN `fecha_inicial` `fecha_inicial` DATE NULL DEFAULT NULL AFTER `monto_inicial`,
CHANGE COLUMN `registro` `registro` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL AFTER `monto_letra`;

-- actualizar orden de columnas venta_credito_letra
ALTER TABLE `venta_credito_letra` 
CHANGE COLUMN `fecha_pago` `fecha_pago` DATETIME NULL DEFAULT '0000-00-00 00:00:00' AFTER `total_pago`;

-- actualizar tabla venta_credito
ALTER TABLE `venta_credito` 
ADD COLUMN `fecha_vencimiento_letra` DATE NULL AFTER `monto_letra`;