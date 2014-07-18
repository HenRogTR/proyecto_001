
-- agregar campo cod_ventas
ALTER TABLE `venta_credito_letra` 
ADD COLUMN `ventas_cod_ventas` INT(11) NULL AFTER `venta_credito_cod_venta_credito`;

-- actualizamos el codVentas
UPDATE venta_credito_letra vcl SET ventas_cod_ventas= 
									(select max(vc.ventas_cod_ventas)
									 from venta_credito vc
								     where vcl.venta_credito_cod_venta_credito= vc.cod_venta_credito)
WHERE vcl.cod_venta_credito_letra!='0';


-- reestructurar ventas
ALTER TABLE `ventas` 
ADD COLUMN `cod_cliente` INT NOT NULL DEFAULT 0 AFTER `observacion`,
ADD COLUMN `duracion` VARCHAR(45) NULL DEFAULT '' AFTER `registro`,
ADD COLUMN `monto_inicial` DOUBLE(10,2) NOT NULL DEFAULT 0.00 AFTER `duracion`,
ADD COLUMN `fecha_inicial_vencimiento` DATE NULL AFTER `monto_inicial`,
ADD COLUMN `cantidad_letras` INT NOT NULL DEFAULT 0 AFTER `fecha_inicial_vencimiento`,
ADD COLUMN `monto_letra` DOUBLE(10,2) NOT NULL DEFAULT 0.00 AFTER `cantidad_letras`,
ADD COLUMN `fecha_vencimiento_letra_deuda` DATE NULL AFTER `monto_letra`,
ADD COLUMN `amortizado` DOUBLE(10,2) NOT NULL DEFAULT 0.00 AFTER `fecha_vencimiento_letra_deuda`,
ADD COLUMN `interes_pagado` DOUBLE(10,2) NOT NULL DEFAULT 0.00 AFTER `amortizado`,
ADD COLUMN `saldo` DOUBLE(10,2) NOT NULL DEFAULT 0.00 AFTER `interes_pagado`;

ALTER TABLE `ventas` 
CHANGE COLUMN `registro` `registro` TEXT CHARACTER SET 'utf8' COLLATE 'utf8_spanish_ci' NOT NULL AFTER `saldo`;

ALTER TABLE `ventas` 
ADD COLUMN `interes` DOUBLE(10,2) NOT NULL DEFAULT 0.00 AFTER `fecha_vencimiento_letra_deuda`;

-- =============================================================================
-- actualizar los campos recientemente agregados
-- actualizamos cod_cliente
UPDATE ventas v SET cod_cliente= 
				(select max(dc.cod_datos_cliente)
				 from datos_cliente dc
            			 where dc.persona_cod_persona= v.persona_cod_persona)
WHERE cod_ventas!='0';

update ventas v 
set v.fecha_inicial_vencimiento=if(v.tipo='contado',NULL,(select vc.fecha_inicial from venta_credito vc where vc.ventas_cod_ventas= v.cod_ventas))
where v.cod_ventas!=0;
-- actualizar cantidad letras

update ventas v 
set v.cantidad_letras=if(v.tipo='contado',0,(select vc.cantidad_letras from venta_credito vc where vc.ventas_cod_ventas= v.cod_ventas))
where v.cod_ventas!=0;
-- actualizar montoInicial

update ventas v 
set v.monto_inicial=if(v.tipo='contado',0.00,(select vc.monto_inicial from venta_credito vc where vc.ventas_cod_ventas= v.cod_ventas))
where v.cod_ventas!=0;
-- actualizar montoLetra

update ventas v 
set v.monto_letra=if(v.tipo='contado',0.00,(select vc.monto_letra from venta_credito vc where vc.ventas_cod_ventas= v.cod_ventas))
where v.cod_ventas!=0;

-- actualizar fecha_vencimiento letra inicial

update ventas v 
set v.fecha_vencimiento_letra_deuda=if(v.tipo='contado',NULL,(select vc.fecha_vencimiento_letra from venta_credito vc where vc.ventas_cod_ventas= v.cod_ventas))
where v.cod_ventas!=0;

-- actualizar amortizado

update `ventas` 
set `ventas`.`amortizado`=
				if(`ventas`.`tipo`='contado' or substring(`ventas`.`registro`,1,1)=0,
					`ventas`.`neto`,
					(select sum( `venta_credito_letra`.`total_pago`) 
						from `venta_credito_letra` 
						where `venta_credito_letra`.`ventas_cod_ventas`=`ventas`.`cod_ventas` 
							and substring(`venta_credito_letra`.`registro`,1,1)=1 ))
where `ventas`.`cod_ventas`!=0;
-- actualizar interes_pagado

update `ventas` 
set `ventas`.`interes_pagado`=
				if(`ventas`.`tipo`='contado' or substring(`ventas`.`registro`,1,1)=0,
					0.00,
					(select sum( `venta_credito_letra`.`interes_pagado`) 
						from `venta_credito_letra` 
						where `venta_credito_letra`.`ventas_cod_ventas`=`ventas`.`cod_ventas` 
							and substring(`venta_credito_letra`.`registro`,1,1)=1 ))
where `ventas`.`cod_ventas`!=0;

-- actualizar el saldo
UPDATE `ventas` SET `saldo`=`neto`-`amortizado` WHERE `cod_ventas`!=0;
-- actualizar fecha vencimiento inicial
-- ==================================================================================================
-- venta 764

ALTER TABLE `venta_credito_letra` 
DROP FOREIGN KEY `fk_ventas_credito_letras_venta_credito1`;
ALTER TABLE `venta_credito_letra` 
DROP COLUMN `venta_credito_cod_venta_credito`,
DROP INDEX `fk_ventas_credito_letras_venta_credito1` ;