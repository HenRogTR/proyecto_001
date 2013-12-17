ALTER TABLE `ventas` 
ADD COLUMN `doc_serie_numero_guia` VARCHAR(45) NULL AFTER `registro`,
ADD COLUMN `direccion2` TEXT NULL AFTER `doc_serie_numero_guia`,
ADD COLUMN `direccion3` TEXT NULL AFTER `direccion2`;

UPDATE `sicci`.`ventas` SET `direccion2`='JR. CORONEL PORTILLO 440-PUCALLPA' WHERE `cod_ventas`!='0';
