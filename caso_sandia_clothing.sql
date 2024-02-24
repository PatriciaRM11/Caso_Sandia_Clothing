#Caso de Uso: Sandia Clothing
use sandia_clothing;

#Análisis de Ventas
#1.¿Cuál fue la cantidad total vendida de todos los productos?
Select sum(qty) as cantidad_total from ventas;

#2. ¿Cuál es el ingreso total generado por todos los productos antes de los descuentos?
select sum(qty * precio) as ventas_brutas from ventas; 

#3.¿Cuál es el ingreso medio generado por todos los productos antes de descuentos?
select avg(qty * precio) as media_ventas_brutas from ventas;

#4. ¿Cuál es el ingreso total generado por cada producto antes de los descuentos?
select d.nombre_producto, sum(v.qty * v.precio) as ventas_brutas from ventas v left join producto_detalle d on v.id_producto=d.id_producto
group by d.nombre_producto order by ventas_brutas desc; 

#5. ¿Cuál fue el monto total del descuento para todos los productos?
select sum(descuento) as descuento_total from ventas; 

#6.	¿Cuál fue el monto total del descuento por cada producto?
select d.nombre_producto, sum(v.descuento) as descuento_total from ventas v left join producto_detalle d on v.id_producto=d.id_producto
group by d.nombre_producto order by descuento_total desc;

#Análisis de Transacciones 
#1.	¿Cuántas transacciones únicas hubo? 
select count(distinct(id_txn)) as n_transacciones_unicas from ventas;

#2.	¿Cuáles son las ventas totales brutas de cada transacción?
select id_txn, sum(qty * precio) as ventas_brutas from ventas group by id_txn order by ventas_brutas desc; 

#3.	¿Qué cantidad de productos totales se compran en cada transacción? 4.	Ordena el resultado anterior de mayor a menor cantidad de productos.
Select id_txn, sum(qty) as cantidad_producto from ventas group by id_txn order by cantidad_producto desc;

# 5.	¿Cuál es el valor de descuento promedio por transacción?
select id_txn, avg(descuento) as descuento_promedio_txn from ventas group by id_txn order by descuento_promedio_txn;

#6. ¿Cuál es el ingreso promedio neto para transacciones de miembros “t”?
select id_txn, avg(qty * precio - descuento) as ingreso_promedio_neto from ventas where miembro='t' group by id_txn order by ingreso_promedio_neto desc;

#Análisis Producto
#1. ¿Cuales son los 3 productos principales por ingresos totales antes del descuento? 
select d.nombre_producto, sum(v.qty * v.precio) as ventas_brutas from ventas v left join producto_detalle d on v.id_producto=d.id_producto
group by d.nombre_producto order by ventas_brutas desc limit 3; 

#2. ¿Cual es la cantidad total, ingresos y el descuento de cada segmento de producto? 
select d.nombre_segmento, count(v.qty) as cantidad, sum(v.qty * v.precio) as ventas_brutas, sum(v.descuento) as descuento from ventas v left join producto_detalle d on v.id_producto=d.id_producto group by d.nombre_segmento;

#3. ¿Cual es el producto con mayores ventas para cada segmento?
select d.nombre_segmento, d.nombre_producto, SUM(v.qty * v.precio - v.descuento) as ventas_netas from ventas v left join producto_detalle d on d.id_producto=v.id_producto group by d.nombre_segmento, d.nombre_producto order by d.nombre_segmento, ventas_netas desc;

#4. ¿Cual es la cantidad total, los ingresos, y el decuento para cada segmento?
select d.nombre_categoria, count(v.qty) as cantidad, sum(v.qty * v.precio) as ventas_brutas, sum(v.descuento) as descuento from ventas v left join producto_detalle d on v.id_producto=d.id_producto group by d.nombre_categoria;

#5. ¿Cual es el producto con mayores ventas para cada categoria?
select d.nombre_categoria, d.nombre_producto, SUM(v.qty * v.precio - v.descuento) as ventas_netas from ventas v left join producto_detalle d on d.id_producto=v.id_producto group by d.nombre_categoria, d.nombre_producto order by ventas_netas desc limit 2;

#6. ¿Cuales son los 5 producto con menores ventas?
select nombre_producto, SUM(qty * v.precio - descuento) as ventas_netas from ventas v left join producto_detalle d on d.id_producto=v.id_producto group by nombre_producto order by ventas_netas limit 5;

#7. ¿Cual es la cantidad de productos vendidos para la categoria mujer?
select SUM(qty) as cantidad_productos from ventas v left join producto_detalle d on d.id_producto where nombre_categoria= 'Mujer';
