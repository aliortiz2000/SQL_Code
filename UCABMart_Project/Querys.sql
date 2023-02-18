-- 

-- Attendance Report

SELECT asistencia AS Asistencia, horai_asistencia AS Entrada, horaf_asistencia AS Salida, ci AS Cedula,nombre1_personal +' '+ apellido1_personal AS Nombre_Apellido, nombre_rol AS Departamento
FROM horario, personal_horario, personal, usuario, rol
WHERE id_horario=cod_horario_ph AND cod_personal_ph=id_personal AND id_personal=cod_personal_usuario AND cod_rol_usuario=id_rol
GROUP BY asistencia, ci, horai_asistencia, horaf_asistencia, nombre1_personal, apellido1_personal, nombre_rol;


-- Expenses - Revenues

SELECT hist_mov, id_producto, nombre_producto, ingreso_egreso,cant_p 
FROM producto, sede_producto, pasillo, sede, hist_movimiento
WHERE id_producto=cod_producto_sp AND id_producto=cod_producto_pasillo AND 
cod_sede_pasillo=id_sede AND cod_sede_sp=id_sede AND id_sede=2 AND (cod_sede_producto_hm=id_sede_producto OR cod_pasillo_hm=id_pasillo);


5 customers who spent the most buying in 2020

SELECT TOP 5  * 
FROM(
	SELECT id_cliente, nombre1_natural + ' ' + apellido1_natural AS Nombre, SUM(total_compra) AS Total
	FROM cliente, c_natural, compra 
	WHERE id_cliente=cod_clienten AND id_cliente=cod_cliente_compra AND fecha_compra BETWEEN '01/01/2020' AND '01/01/2021'
	GROUP BY id_cliente, nombre1_natural, apellido1_natural
	
	UNION
	
	SELECT id_cliente, denominacionc_juridico AS Nombre, SUM(total_compra) AS Total
	FROM cliente, c_juridico, compra 
	WHERE id_cliente=cod_clientej AND id_cliente=cod_cliente_compra AND fecha_compra BETWEEN '01/01/2020' AND '01/01/2021'
	GROUP BY id_cliente, denominacionc_juridico
) AS clientes_5
ORDER BY Total DESC;


-- Top 5 best-selling products in 2020

SELECT TOP 5 id_producto, nombre_producto, COUNT(cod_producto_detalle) AS Vendidos
FROM producto, detalle_compra, compra
WHERE id_producto=cod_producto_detalle AND cod_compra_detalle=id_compra AND fecha_compra BETWEEN '01/01/2020' AND '31/01/2020'
GROUP BY id_producto, nombre_producto
ORDER BY Vendidos DESC


-- 5 Most Frequent Customers in 2020

SELECT TOP 5 * 
FROM(
	SELECT id_cliente, nombre1_natural + ' ' + apellido1_natural AS Nombre, COUNT(cod_cliente_compra) AS Total
	FROM cliente, c_natural, compra 
	WHERE id_cliente=cod_clienten AND id_cliente=cod_cliente_compra AND fecha_compra BETWEEN '01-01-2020' AND '01-01-2021'
	GROUP BY id_cliente, nombre1_natural, apellido1_natural
	
	UNION
	
	SELECT id_cliente, denominacionc_juridico AS Nombre, COUNT(cod_cliente_compra) AS Total
	FROM cliente, c_juridico, compra 
	WHERE id_cliente=cod_clientej AND id_cliente=cod_cliente_compra AND fecha_compra BETWEEN '01-01-2020' AND '01-01-2021'
	GROUP BY id_cliente, denominacionc_juridico
) AS clientes_frecuentes
ORDER BY Total DESC


-- Products with Active Discounts

SELECT  nombre_producto AS Nombre_Producto, CONVERT(varchar, descuento*100) + '% Descuento' AS Descuento_Producto
FROM producto, promocion, promocion_producto
WHERE id_promocion = cod_promocion_pp AND cod_producto_pp = id_producto AND fechaf_p IS NULL;


-- Months Sorted by Most Sales

SELECT MONTH(fecha_compra) AS Mes,  COUNT(*) AS Total
FROM compra 
GROUP BY MONTH(fecha_compra)
ORDER BY 2 DESC;


