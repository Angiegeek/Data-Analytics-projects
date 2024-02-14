--Proyecto SQL 
--Universidad Cenfotec
--Alumna:Angie Vargas Matarrita
-----------------------------------------------------------------------------------------------------------------------
/*Primer parte, nos conectamos a la DB master, el Drop, create y use DB Proyecto es para estar segura de 
estar en la DB que necesito*/
USE MASTER
GO

DROP DATABASE PROYECTO
GO

CREATE DATABASE PROYECTO
GO

USE PROYECTO
GO
/*Creacion de la tabla ya que parte del ejecicio solicitado es hacerlo
de esta manera en vez de acceder a la info de un CSV, JSON O XSL*/
CREATE TABLE CLIENTE (
   CTE_ID               INTEGER NOT NULL,
   CTE_NOMBRE1          VARCHAR(255) NOT NULL,
   CTE_NOMBRE2          VARCHAR(255),
   CTE_APELLIDO1        VARCHAR(255) NOT NULL,
   CTE_APELLIDO2        VARCHAR(255),
   CTE_FECHA_NACIMIENTO DATE NOT NULL,
   CTE_SALDO            DECIMAL(20,2) NOT NULL,
   CTE_LIMITE_CREDITO   DECIMAL(20,2) NOT NULL,
   CTE_DESCUENTO        DECIMAL(6,2) NOT NULL,
   CONSTRAINT PK_CTE_ID PRIMARY KEY(CTE_ID),
   CONSTRAINT CK_CTE_SALDO CHECK(CTE_SALDO>=0),
   CONSTRAINT CK_CTE_LIMITE_CREDITO CHECK(CTE_LIMITE_CREDITO>=0),
   CONSTRAINT CK_DESCUENTO CHECK(CTE_DESCUENTO>=0),
)
GO

CREATE TABLE DIRECCION (
   DIR_ID           INTEGER NOT NULL,
   DIR_CTE_ID       INTEGER NOT NULL,
   DIR_NUMERO_CALLE VARCHAR(5),
   DIR_NOMBRE_CALLE VARCHAR(40) NOT NULL,
   DIR_BARRIO       VARCHAR(40) NOT NULL,
   DIR_CIUDAD       VARCHAR(40) NOT NULL,
   CONSTRAINT PK_DIR_ID PRIMARY KEY(DIR_ID ),
   CONSTRAINT FK_DIR_CTE_ID FOREIGN KEY(DIR_CTE_ID) REFERENCES CLIENTE(CTE_ID),
   CONSTRAINT CK_DIR_NUMERO_CALLE CHECK(DIR_NUMERO_CALLE>=0)

)
GO

CREATE TABLE PEDIDO (
   PDD_ID           INTEGER NOT NULL,
   PDD_CTE_ID       INTEGER NOT NULL,
   PDD_FECHA        DATE NOT NULL,
   PDD_DIR_ID       INTEGER NOT NULL,
   PDD_NUMERO_CALLE VARCHAR(5) NOT NULL,
   PDD_NOMBRE_CALLE VARCHAR(40) NOT NULL,
   PDD_BARRIO       VARCHAR(40) NOT NULL,
   PDD_CIUDAD       VARCHAR(40) NOT NULL
   CONSTRAINT PK_PDD_ID  PRIMARY KEY(PDD_ID),
   CONSTRAINT FK_PDD_CTE_ID FOREIGN KEY(PDD_CTE_ID) REFERENCES CLIENTE(CTE_ID),
   CONSTRAINT FK_PDD_DIR_ID FOREIGN KEY(PDD_DIR_ID) REFERENCES DIRECCION(DIR_ID),

)
GO

CREATE TABLE ARTICULO (
   ART_ID          INTEGER NOT NULL,
   ART_DESCRIPCION VARCHAR(40) NOT NULL,
   CONSTRAINT PK_ART_ID  PRIMARY KEY(ART_ID),
   

)
GO

CREATE TABLE ARTICULO_X_PEDIDO (
   AXP_ID     INTEGER NOT NULL,
   AXP_PDD_ID INTEGER NOT NULL,
   AXP_ART_ID INTEGER NOT NULL,
   AXP_CANTIDAD DECIMAL(10,2) NOT NULL,
   AXP_PRECIO_UNITARIO DECIMAL(20,2) NOT NULL,
   AXP_PRECIO_VENTA DECIMAL(20,2) NOT NULL
   CONSTRAINT PK_AXP_ID   PRIMARY KEY(AXP_ID),
   CONSTRAINT FK_AXP_PDD_ID FOREIGN KEY(AXP_PDD_ID) REFERENCES PEDIDO(PDD_ID),
   CONSTRAINT FK_AXP_ART_ID FOREIGN KEY(AXP_ART_ID) REFERENCES ARTICULO(ART_ID),
   CONSTRAINT CK_AXP_CANTIDAD CHECK(AXP_CANTIDAD>=0),
   CONSTRAINT CK_AXP_PRECIO_UNITARIO CHECK(AXP_PRECIO_UNITARIO>=0),
   CONSTRAINT AXP_PRECIO_VENTA CHECK(AXP_PRECIO_VENTA>=0)

)
GO

CREATE TABLE TEL_X_CTE(
	TEL_X_CTE_ID INTEGER NOT NULL,
	TEL_X_CTE_NUM VARCHAR(255) NOT NULL,
	TEL_X_CTE_CTE_ID INTEGER NOT NULL,
	TEL_X_CTE_DESCRIPCION VARCHAR(40) NOT NULL,
	CONSTRAINT PK_TEL_X_CTE_ID   PRIMARY KEY(TEL_X_CTE_ID),
	CONSTRAINT FK_TEL_X_CTE_CTE_ID FOREIGN KEY(TEL_X_CTE_CTE_ID) REFERENCES CLIENTE(CTE_ID)
)
GO
/*Una vez creadas las tablas, ingresamos la información que van a contener*/

-- CLIENTE
INSERT INTO CLIENTE (CTE_ID, CTE_NOMBRE1, CTE_NOMBRE2, CTE_APELLIDO1, CTE_APELLIDO2, CTE_FECHA_NACIMIENTO, CTE_SALDO, CTE_LIMITE_CREDITO, CTE_DESCUENTO) VALUES
(1, 'Juan', 'Carlos', 'Lopez', 'Perez', '1990-05-15', 1500.00, 5000.00, 0.10),
(2, 'Maria', 'Elena', 'Gomez', 'Martinez', '1985-08-20', 2000.00, 8000.00, 0.15 ),
(3, 'Pedro', 'Pablo', 'Rodriguez', 'Jimenez', '1995-02-10', 1000.00, 3000.00, 0.05),
(4, 'Ana', 'Isabel', 'Fernandez', 'Lara', '1980-11-28', 3000.00, 10000.00, 0.20),
(5, 'Carlos', 'Alberto', 'Gutierrez', 'Santos', '1992-09-05', 2500.00, 6000.00, 0.12),
(6, 'Lucia', 'Camila', 'Gutierrez', 'Santos', '1993-09-05', 7500.00, 5000.00, 0.12);

-- DIRECCION
INSERT INTO DIRECCION (DIR_ID, DIR_CTE_ID, DIR_NUMERO_CALLE, DIR_NOMBRE_CALLE, DIR_BARRIO, DIR_CIUDAD) VALUES
(1, 1, '123', 'Calle Principal', 'Centro', 'Ciudad A'),
(2, 2, '456', 'Avenida Central', 'Residencial', 'Ciudad B'),
(3, 3, '789', 'Calle Secundaria', 'Oeste', 'Ciudad C'),
(4, 4, '321', 'Avenida Norte', 'Este', 'Ciudad D'),
(5, 5, '654', 'Calle Este', 'Sur', 'Ciudad E'),
(6, 6, '', 'Avenida Bolivar', 'Norte', 'Ciudad F');

select * from DIRECCION

-- PEDIDO
INSERT INTO PEDIDO (PDD_ID, PDD_CTE_ID, PDD_FECHA, PDD_DIR_ID, PDD_NUMERO_CALLE, PDD_NOMBRE_CALLE, PDD_BARRIO, PDD_CIUDAD)
VALUES 
(1, 1, '2023-01-10', 1, '123', 'Calle Principal', 'Centro', 'Ciudad A'),
(2, 2, '2023-02-15', 2, '456', 'Avenida Central', 'Residencial', 'Ciudad B'),
(3, 3, '2023-03-20', 3, '789', 'Calle Secundaria', 'Oeste', 'Ciudad C'),
(4, 4, '2023-04-25', 4, '321', 'Avenida Norte', 'Este', 'Ciudad D'),
(5, 5, '2023-05-30', 5, '654', 'Calle Este', 'Sur', 'Ciudad E'),
(6, 6, '2023-06-01', 6, '', 'Avenida Bolivar', 'Norte', 'Ciudad F')
;

-- ARTICULO
INSERT INTO ARTICULO (ART_ID, ART_DESCRIPCION)
VALUES 
(1, 'Laptop'),
(2, 'Teléfono'),
(3, 'Impresora'),
(4, 'Cámara'),
(5, 'Tablet');

-- ARTICULO_X_PEDIDO
INSERT INTO ARTICULO_X_PEDIDO (AXP_ID, AXP_PDD_ID, AXP_ART_ID, AXP_CANTIDAD, AXP_PRECIO_UNITARIO, AXP_PRECIO_VENTA)
VALUES 
(1, 1, 1, 2, 800.00, 1600.00),
(2, 2, 3, 1, 500.00, 500.00),
(3, 3, 2, 3, 300.00, 900.00),
(4, 4, 5, 1, 400.00, 400.00),
(5, 5, 4, 2, 600.00, 1200.00);

SELECT * FROM ARTICULO_X_PEDIDO

-- TEL_X_CTE
INSERT INTO TEL_X_CTE (TEL_X_CTE_ID, TEL_X_CTE_NUM, TEL_X_CTE_CTE_ID, TEL_X_CTE_DESCRIPCION)
VALUES 
(1, '555-111-2222', 1, 'Personal'),
(2, '777-333-4444', 2, 'Trabajo'),
(3, '999-555-6666', 3, 'Casa'),
(4, '111-777-8888', 4, 'Móvil'),
(5, '333-999-0000', 5, 'Principal');

---------------------------------------------------------------------------------------------------------------
------------------------------	QUERYS DE CONSULTAS A LA DB------------------------------------------------------
--CONSULTAS

--1. CLIENTES CON EL SALDO MAYOR A 2000
SELECT CTE_NOMBRE1, CTE_NOMBRE2, CTE_APELLIDO1, CTE_APELLIDO2 
  FROM CLIENTE
 WHERE CTE_SALDO >= 2000;

--2.CLASIFICACION DEL CREDITO DEL CLIENTE
 SELECT CTE_NOMBRE1, CTE_NOMBRE2, CTE_APELLIDO1, CTE_APELLIDO2,
 CASE WHEN CTE_LIMITE_CREDITO < 5000 THEN 'Limite de credito Bajo'
	  WHEN CTE_LIMITE_CREDITO >=5000 AND CTE_LIMITE_CREDITO <=8000 THEN 'Limite de Credito Medio'
	  ELSE 'Limite de Credito Alto'
   END 'Clasificacion De Credito'
 FROM CLIENTE


--3.Envio de los Pedidos del 1er trimestre
SELECT PDD_NUMERO_CALLE,PDD_NOMBRE_CALLE,PDD_BARRIO,PDD_CIUDAD,PDD_FECHA
FROM PEDIDO
WHERE PDD_FECHA < CONVERT(DATE,'2023-03-01',120);

--4.Edad de los clientes
SELECT CONCAT(CTE_NOMBRE1,' ', CTE_NOMBRE2,' ',  CTE_APELLIDO1, ' ', CTE_APELLIDO2) 'Nombre del cliente',
CTE_FECHA_NACIMIENTO 'Fecha de Nacimiento',
DATEDIFF(YEAR, 
CONVERT(DATE,CTE_FECHA_NACIMIENTO, 120),
GETDATE()) 'Edad del cliente'
FROM CLIENTE

--5.Clasificacion de los descuentos
SELECT CONCAT(CTE_NOMBRE1,' ', CTE_NOMBRE2,' ',  CTE_APELLIDO1, ' ', CTE_APELLIDO2) 'Nombre del cliente',
   CASE WHEN CTE_DESCUENTO = 0.05 THEN 'Descuento 1'
	    WHEN CTE_DESCUENTO = 0.10 THEN 'Descuento 2'
        WHEN CTE_DESCUENTO = 0.12 THEN 'Descuento 3'
        WHEN CTE_DESCUENTO = 0.15 THEN 'Descuento 4'
        WHEN CTE_DESCUENTO = 0.20 THEN 'Descuento 5'
	    ELSE 'Asignar descuento'
  END 'Tipo de descuento'
FROM CLIENTE
--6.Cantidad de Articulos en Inventario
SELECT ART_DESCRIPCION 'Tipo de articulo',
	CASE WHEN ART_DESCRIPCION = 'Laptop' THEN 2
		 WHEN ART_DESCRIPCION = 'Teléfono' THEN 5
		 WHEN ART_DESCRIPCION = 'Impresora' THEN 6
		 WHEN ART_DESCRIPCION = 'Cámara' THEN 3
		 WHEN ART_DESCRIPCION = 'Tablet' THEN 8
	END 'Cantidad en inventario'
from ARTICULO

--7.'Direccion del cliente ID 1'
SELECT CONCAT(DIR_CIUDAD,' ',DIR_BARRIO,' ',DIR_NOMBRE_CALLE,' ',DIR_NUMERO_CALLE) 'Direccion del cliente ID 1'
FROM DIRECCION
WHERE DIR_CTE_ID = 1

--8.Consulta al numero de telefono que esta registrado en su descripcion como "Personal"
SELECT TEL_X_CTE_NUM FROM TEL_X_CTE
WHERE TEL_X_CTE_DESCRIPCION = 'Personal'

--9. Clasificación de la gama de producto por el rango de precios

SELECT *, 
	CASE WHEN AXP_PRECIO_UNITARIO >= 900.00 THEN 'Producto Gama Alta'
	     WHEN AXP_PRECIO_UNITARIO < 900.00 AND AXP_PRECIO_UNITARIO >=500 THEN 'Producto Gama Media'
	     ELSE 'Producto Gama baja'
    End 'Gama de Producto'
FROM ARTICULO_X_PEDIDO

--10.Para encontrar la ubicación de un cliente especifico por su id
SELECT * FROM DIRECCION WHERE DIR_CTE_ID = 4;

/**Clase 2 **/
SELECT * FROM dbo.DIRECCION
SELECT * FROM dbo.PEDIDO
SELECT * FROM dbo.CLIENTE
-----------------------------------------------------------
--INTERSECT
-----------------------------------------------------------
--1.Intersecta toda la informacion de los clientes con su limite de credito
--menor o igual a 5000 y mayor o igual a 3000 y que los clientes
--se llamen Juan o Pedro
SELECT * 
 FROM dbo.CLIENTE
 WHERE CTE_LIMITE_CREDITO <=5000
 AND CTE_LIMITE_CREDITO >=3000
 INTERSECT
 SELECT *
 FROM dbo.CLIENTE
 WHERE CTE_NOMBRE1 = 'Juan' OR CTE_NOMBRE1 ='Pedro'

----------------------------------------------------------------
--UNION
----------------------------------------------------------------
--Une los clientes que tienen fecha de nacimiento menor de 1985-08-20 
--con la cliente de saldo 2000 y los ordena de manera ascendente 

SELECT CONCAT(CTE_NOMBRE1,' ',CTE_NOMBRE2,' ',CTE_APELLIDO1,' ',CTE_APELLIDO2) Nombre_Cliente, CTE_SALDO Saldo
FROM CLIENTE
WHERE CTE_FECHA_NACIMIENTO > CONVERT(DATE,'1985-08-20',120)
UNION
SELECT CONCAT(CTE_NOMBRE1,' ',CTE_NOMBRE2,' ',CTE_APELLIDO1,' ',CTE_APELLIDO2), CTE_SALDO Saldo 
FROM CLIENTE
WHERE CTE_SALDO = 2000 
ORDER BY CTE_SALDO ASC
-------------------------------------------------------------------
--INNER JOIN
-------------------------------------------------------------------
--Une la tabla pedido y direccion mostrando fechas de pedido y direcciones
/**select * from DIRECCION
select * from PEDIDO**/

SELECT D.DIR_ID AS 'ID De Direccion',
	   CONCAT(DIR_NUMERO_CALLE,' ',DIR_NOMBRE_CALLE,' ',DIR_BARRIO,' ',DIR_CIUDAD) Direccion,
	   P.PDD_ID AS 'ID del pedido',
	   PDD_FECHA AS 'Fecha del pedido'
FROM DIRECCION D INNER JOIN PEDIDO P ON PDD_DIR_ID = DIR_ID
WHERE D.DIR_NUMERO_CALLE <500
------------------------------------------------------------
--LEFT JOIN
------------------------------------------------------------
--Trae todos los clientes y muestra los telefonos y tipo de telefono
--que se encuentran en la tabla Telefono por cliente.
--Los valores null son automaticos por que no los hemos incluido
SELECT CONCAT(CTE_NOMBRE1,' ',CTE_NOMBRE2,' ',CTE_APELLIDO1,' ',CTE_APELLIDO2) 'Nombre Cliente',
T.TEL_X_CTE_NUM 'Telefono del cliente',
T.TEL_X_CTE_DESCRIPCION 'Tipo de Telefono'
FROM CLIENTE C LEFT JOIN TEL_X_CTE T ON TEL_X_CTE_CTE_ID= CTE_ID
-------------------------------------------------------------------------
--RIGHT JOIN
-------------------------------------------------------------------------
--Nos trae los precios de Venta de la tabla Articulos por pedido y nos los asocia con
-- la tabla de Articulos y los ordena de manera descendente

SELECT A.ART_DESCRIPCION 'Producto',
	   AP.AXP_PRECIO_VENTA 'Precio de venta'
FROM ARTICULO A RIGHT JOIN ARTICULO_X_PEDIDO AP ON AXP_ART_ID = ART_ID
ORDER BY AP.AXP_PRECIO_VENTA DESC
-------------------------------------------------------------------------
