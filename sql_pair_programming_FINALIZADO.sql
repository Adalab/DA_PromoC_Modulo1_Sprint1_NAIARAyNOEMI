CREATE SCHEMA tienda_zapatillas;
USE tienda_zapatillas;

#1ª- TABLA ZAPATILLAS

CREATE TABLE IF NOT EXISTS zapatillas (
id_zapatilla INT NOT NULL AUTO_INCREMENT,
modelo VARCHAR(45) NOT NULL,
color VARCHAR(45) NOT NULL,
PRIMARY KEY (id_zapatilla) );

#2ª TABLA CLIENTES

CREATE TABLE IF NOT EXISTS clientes (
id_clientes INT NOT NULL AUTO_INCREMENT,
nombre VARCHAR(45) NOT NULL,
numero_telefono INT(9) NOT NULL,
email VARCHAR(45) NOT NULL,
direccion VARCHAR(45) NOT NULL,
ciudad VARCHAR(45),
provincia VARCHAR(45) NOT NULL,
pais VARCHAR(45) NOT NULL,
codigo_postal VARCHAR(45) NOT NULL,
PRIMARY KEY (id_clientes) ) ;

#3ª TABLA EMPLEADOS

CREATE TABLE IF NOT EXISTS empleados (
id_empleado INT NOT NULL AUTO_INCREMENT,
nombre VARCHAR(45) NOT NULL,
tienda VARCHAR(45) NOT NULL,
salario INT,
fecha_incorporacion DATE NOT NULL,
PRIMARY KEY (id_empleado) );

#4ª TABLA FACTURAS

CREATE TABLE IF NOT EXISTS facturas (
id_factura INT NOT NULL AUTO_INCREMENT,
numero_factura VARCHAR(45) NOT NULL,
fecha DATE NOT NULL,
id_zapatilla INT NOT NULL,
id_clientes INT NOT NULL,
id_empleado INT NOT NULL,
PRIMARY KEY (id_factura), 
CONSTRAINT fk_facturas_zapatillas
FOREIGN KEY (id_zapatilla)
REFERENCES zapatillas (id_zapatilla),
CONSTRAINT fk_facturas_clientes
FOREIGN KEY (id_clientes)
REFERENCES clientes (id_clientes),
CONSTRAINT fk_facturas_empleados
FOREIGN KEY (id_empleado)
REFERENCES empleados (id_empleado) );

#5º MODIFICAR TABLAS
ALTER TABLE zapatillas
ADD COLUMN  marca VARCHAR(45) NOT NULL,
ADD COLUMN talla INT NOT NULL ;

ALTER TABLE empleados
MODIFY COLUMN salario FLOAT NOT NULL ;

ALTER TABLE clientes
DROP COLUMN pais,
MODIFY COLUMN codigo_postal INT ;

ALTER TABLE facturas
ADD COLUMN total FLOAT ;

#6º INSERCCIÓN DE DATOS 

INSERT INTO zapatillas (id_zapatilla, modelo, color, marca, talla)
VALUES (1, "XQYUN", "Negro", "Nike", 42),
(2, "UOPMN", "Rosas", "Nike", 39),
(3, "OPNYT", "Verdes", "Adidas", 35) ;

INSERT INTO empleados (id_empleado, nombre, tienda, salario, fecha_incorporacion)
VALUES (1, "Laura", "Alcobendas", 25987 , "2010-09-03"),
(2, "Maria", "Sevilla", NULL, "2001-04-11"),
(3, "Ester", "Oviedo", 30165.98, 2000-11-29) ;

INSERT INTO clientes (id_cliente, nombre, numero_telefono, email, dirección, ciudad, provincia, codigo_postal)
VALUES (1, "Monica", 1234567289, "monica@email.com", "Calle Felicidad", "Móstoles", "Madrid", 28176),
(2, "Lorena", 289345678, "lorena@email.com", "Calle Alegria", "Barcelona", "Barcelona", 2346),
(3, "Carmen", 298463759, "carmen@email.com", "Calle del Color", "Vigo" , "Pontevedra", 23456);

INSERT INTO facturas (id_factura, numero_factura, fecha, id_zapatilla, id_empleado, id_cliente, total)
VALUES (1, 123, "2001-12-11", 1, 2, 1, 54.98),
(2, 1234, "2005-05-23", 1, 1, 3, 89.91),
(3, 12345, 2015-09-18, 2, 3, 3, 76.23) ;

-- PERFECCIONANDO LA BBDD--

UPDATE zapatillas
SET color = amarillo
WHERE id_zapatilla = rosas ;

UPDATE empleados
SET tienda = ACoruña
WHERE id_empleado = 1 ;

UPDATE clientes
SET numero_telefono = 12345678
WHERE id_cliente = 1 ;

UPDATE facturas
SET total = 89.91
WHERE id_factura = 2 ;

-- CONSULTAS BÁSICAS 1 --

USE northwind ;

SELECT employee_id, last_name, first_name
FROM employees ;

SELECT *
FROM products
WHERE unit_price > 0 and unit_price <= 5 ;

SELECT *
FROM products
WHERE unit_price = 18
OR unit_price = 19
OR unit_price = 20 ;

SELECT *
FROM products
WHERE unit_price >= 15 AND unit_price <= 50 ;

SELECT *
FROM products
WHERE unit_price IS NULL ;

SELECT *
FROM products
WHERE unit_price < 15 AND product_id < 10 ;

SELECT *
FROM products 
WHERE unit_price > 15 AND product_id > 10 ; 

SELECT ship_country
FROM orders ;

-- CONSULTAS BÁSICAS 2 --

#Crea una consulta que muestre los primeros 10 productos según su ID y que nos indique el nombre de dichos productos y sus precios

SELECT product_name, unit_price
FROM products
ORDER BY product_id ASC
LIMIT 10;

#ahora realiza la misma consulta pero que nos muestre los últimos 10 productos según su ID de manera descendiente.

SELECT product_name, unit_price 
FROM products
ORDER BY product_id desc
LIMIT 10;

#Nos interesa conocer qué pedidos distintos hemos tenido (eliminando entradas duplicadas según su ID en la tabla order_details).

SELECT	distinct order_id
FROM order_details;

#vamos a limitar los resultados sólo a los 2 primeros pedidos para verlos más en detalle. 
#Sin embargo, en la tabla OrderDetails pueden existir varios registros para cada pedido, por lo que no nos servirá con un uso normal del comando LIMIT.


SELECT distinct order_id
FROM order_details
LIMIT 2;

#conocer los 3 pedidos que han supuesto un mayor coste económico total para la empresa. Calcúlalo y dale el alias ImporteTotal. Nota: Utiliza unit_price.

SELECT  distinct unit_price  AS IMporteTotal
From order_details 
order by unit_price DESC
LIMIT 3;

#el departamento de Ventas nos piden seleccionar el ID de los pedidos situados entre la 
#5 y la 10 mejor posición en cuanto al coste económico total ImporteTotal.

SELECT order_id, unit_price AS importetotal
FROM ORDER_DETAILS
WHERE unit_price  BETWEEN 5 AND 10;


#una lista de las categorías que componen los tipos de pedido de la empresa. 
#Queremos que la lista de resultado sea renombrada como "NombreDeCategoria".

SELECT category_id, category_name AS nombrecategoria
FROM categories ;

#8 nos piden conocer cuál sería la fecha de envío (ShippedDate) de los pedidos almacenados en la base de datos, 
#si estos sufrieran un retraso de 5 días. Nos piden mostrar la nueva fecha renombrada como FechaRetrasada.
# Pista 💡 Para realizar lo anterior, busca documentación de la función DATE_ADD para MySQL.

SELECT shipped_date, DATE_ADD(shipped_date,  INTERVAL 5 day) as fecharetasada
FROM orders;


#9r más beneficios parece ser el de aquellos con un precio mayor o igual a 15 dólares, pero menor o igual que 50 dólares. 
#Selecciona los datos de ese rango de productos usando el operador BETWEEN.

Select *
FROM products
where unit_price Between 15 and 50
order by unit_price ASC;

#10 Queremos conocer los datos de los productos que tengan exactamente un precio de 18, 19 o 20 dólares
 
 SELECT *
 FROM products
 WHERE unit_price In ("18","19","20");

# Consultas avanzadas 1
#Productos más baratos y caros de nuestra BBDD

SELECT MAX(unit_price) as highestprice, MIN(unit_price) as lowestprice
FROM products;

#Conociendo el numero de productos y su precio medio

select Count(units_in_stock), AVG(unit_price)
FROM products;

#acad la máxima y mínima carga de los pedidos de UK:
	
    SELECT MAX(freight), MIN(freight)
    
    FROM ORDERS
    WHERE ship_country In ("UK");
    
    #Qué productos se venden por encima del precio medio
    
select AVG(unit_price)
From products;

SELECT product_name, unit_price
From products
WHERE unit_price > 28.86
ORDER BY unit_price desc;

#Qué productos se han descontinuado

SELECT product_id, product_name
FROM products
WHERE discontinued = 1;

SELECT product_id, product_name
FROM products
WHERE discontinued != 1
LIMIT 20;

#Detalles de los productos de la query anterior
