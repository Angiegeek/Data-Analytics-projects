/*Proyecto Integrador 1 Clase 1 Mañana
Alumna: Angie Vargas Matarrita
UNIVERSIDAD CENFOTEC*/

--Creacion de llaves foraneas

alter table actividades 
add constraint FK_producto
foreign key(producto,tipo) references productos(producto,tipo)

alter table actividades 
add constraint FK_lugar
foreign key(lugar) references lugares(lugar)

alter table productos
add constraint FK_tipo
foreign key(tipo) references tipos(tipo) 

--repaso de select basicos
select monto_invertido / asistentes as inversion_asistente from actividades

select forecast + revenue as estimacion_ganancia from actividades
where asistentes > 100

select * from actividades
order by producto, lugar

select * from actividades
order by fecha desc

select sum(monto_invertido) as total from actividades
where asistentes > 100

select forecast/monto_invertido/100 as 'Porcentaje de forecast' ,
revenue/monto_invertido/100 as 'Porcentaje de revenue'
from actividades
where asistentes > 100

select forecast/monto_invertido/100 as 'Porcentaje' from actividades
where asistentes > 100
select min(monto_invertido) as 'monto minimo invertido' from actividades
where asistentes > 100

select max(monto_invertido) as 'monto maximo invertido' from actividades
where asistentes > 100

--Promedio de la inversion total
select avg(monto_invertido) as 'Promedio de inversion' from actividades
where asistentes > 100

--Cuanto se invierte por cada producto
select producto,sum(monto_invertido) as 'Inversion por producto' from actividades
group by producto

--Cuantas actividades se hacen por cada producto
select producto,sum(monto_invertido) as 'Inversion por producto' ,
count(monto_invertido) as 'Numero de actividades'
from actividades
group by producto

--Donde se hace el evento
select lugar,sum(monto_invertido) as 'Inversion por producto' ,
count(monto_invertido) as 'Numero de actividades'
from actividades
group by lugar

--Muestra nombres de los lugares usando join con la tabla de lugares
select nombre,sum(monto_invertido) as 'Inversion por producto' ,
count(monto_invertido) as 'Numero de actividades'
from actividades
join lugares on lugares.lugar = actividades.lugar
group by nombre
order by 'Numero de actividades' desc 

--PROYECTO INTEGRADOR 1
--CLASE 2
--Alumna: Angie Vargas

--------------------------------------------------------------
--Hacer un programa que me diga cuanto es en colones el monto invertido
-----------Con Funcion------------------------------
select * from actividades
create or alter function invColon()
returns float
as
begin
     declare @invColon money
	 select top 1 @invColon= valor from tipoCambio order by fecha desc
	 return @invColon;
end;

select codigo,monto_invertido,monto_invertido* dbo.invColon() from actividades


select codigo, dbo.invColon()*monto_invertido as Inversión,
dbo.invColon()*forecast as Forecast,
dbo.invColon()*revenue as Revenue 
from actividades
---------Con Puntero------------------
create or alter procedure demopuntero
as
declare puntero cursor for
	select codigo, producto, monto_invertido from ACTIVIDADES--El puntero solo puede apuntar a campos de la tabla ya existente
declare @codigo varchar(20);
declare @producto varchar(50);
declare @Inversion_Dolares money;
declare @Inversion_Colones money;
declare @observaciones varchar(100);
create table Conversion ( 
	Campaña VARCHAR(20),
    Producto VARCHAR(20),
    Inversion_Dolares money,
	Inversion_Colones money
    );
open puntero
fetch next from puntero into @codigo, @producto, @Inversion_Dolares
while @@fetch_status <> -1 
	begin
	set @Inversion_Colones= @Inversion_Dolares* (select top 1 valor from tipocambio order by fecha desc);
	INSERT INTO Conversion(Campaña, Producto, Inversion_Dolares, Inversion_Colones)
		VALUES (@codigo, @producto,@Inversion_Dolares,@Inversion_Colones );
	fetch next from puntero into @codigo, @producto,@Inversion_Dolares;
	--Los fectch y los select deben coincidir en cantidad y tipo
end;

close puntero
deallocate puntero

exec demopuntero

select * from Conversion

------------------FUNCION CON FECHA DE TIPO DE CAMBIO---------------------------------------------

create or alter function tipocf( @fecha date)
returns money
as 
begin
	declare @tipocf money;
	select top 1 @tipocf=valor from tipocambio order by fecha desc

	return @tipocf;
end;

select codigo,dbo.tipocf('2024-1-07')*monto_invertido as Inversión,
dbo.tipocf('2024-1-07')*forecast as forecast_colones,
dbo.tipocf('2024-1-07')*revenue as revenue
from actividades
-----------PROCEDURE------------
create or alter procedure ptc
as 
begin
	declare @valor money;
	
	select top 1 @valor=valor from tipocambio order by fecha desc
	select codigo, monto_invertido*@valor as Inversión, 
	forecast*@valor as Forecast,
	revenue*@valor as Revenue
	from actividades 

end;


exec ptc
