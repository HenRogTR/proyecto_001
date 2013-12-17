ALTER TABLE `sicci`.`venta_credito` 
ADD COLUMN `fecha_inicial` DATE NULL AFTER `cantidad_letras`,
ADD COLUMN `monto_letra` DOUBLE(10,2) NULL AFTER `fecha_inicial`;

