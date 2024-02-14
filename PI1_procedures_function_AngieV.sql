/*Universidad CENFOTEC 2024
Estudiante: Angie Vargas Matarrita
Ejercicio 2 Proyecto Integrador 1
Objetivo: Con la base de datos de Eventos debo buscar las 
actividades que son mas factibles de ejecutar segun su revenue y forecast*/

use mercadeoidb
select codigo, productos.producto,precio_licencia, productos.tipo,monto_invertido
from actividades
join productos on productos.producto = actividades.producto

select producto,precio_licencia	,descripcion from productos
join tipos on tipos.tipo = productos.tipo

select * from producto_precio_descripcion
---------------------------------------------------------
create or alter procedure zz @dato int, @dato2 int
as
begin
	 print @dato+@dato2;
end;

execute zz 5,4
--------------------------------------------------------------
/*select sum(revenue) from actividades
where producto = 'FOXP'*/
------------------------------------------------------------
create or alter procedure zz @producto varchar (10)
as
declare @total int;
begin
	 select @total= sum(revenue) from actividades
	 where producto = @producto;

	 print 'Total Revenue'
	 print @total 
end;

execute zz 'INFX'
-----------------------------------------------------------
create or alter procedure gg @producto varchar (10)
as
declare @total int;
begin
	 select sum(revenue) as revenue,
			sum(forecast) as forecast,
			sum(monto_invertido) as inversion
	 from actividades
	 where producto = @producto;
end;

 execute gg 'INFX'

 --------------------------------------------------
create or alter function ff( @producto varchar (10))
returns int
as
begin
	declare @total int;
	select @total = sum(revenue) 
	from actividades
	where producto =@producto
	return @total
end;

select dbo.ff(producto) totales from productos

---------------------------------------------------
create or alter function ff2( @monto_invertido money, @forecast money, @revenue money)
returns float
as
begin
	  return @monto_invertido /(@revenue+@forecast )
end;

select codigo, dbo.ff2(monto_invertido,forecast,revenue) from actividades

-------------------------------------------------------------------------
create table tipoCambio (fecha date, valor money)
insert into tipoCambio values('2024-01-10', 514);
insert into tipoCambio values('2024-01-09', 513);
insert into tipoCambio values('2024-01-08', 516);
insert into tipoCambio values('2024-01-07', 520);
insert into tipoCambio values('2024-01-06', 521);

select * from tipoCambio