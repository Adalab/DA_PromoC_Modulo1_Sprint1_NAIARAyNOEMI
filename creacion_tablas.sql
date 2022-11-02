CREATE SCHEMA tienda_zapatillas;
USE tienda_zapatillas;

#1ª- TABLA ZAPATILLAS

CREATE TABLE zapatillas (
id_zapatilla INT NOT NULL AUTO_INCREMENT,
modelo VARCHAR(45) NOT NULL,
color VARCHAR(45) NOT NULL,
PRIMARY KEY (id_zapatilla) );

#2ª TABLA CLIENTES

CREATE TABLE clientes (
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

CREATE TABLE empleados (
id_empleado INT NOT NULL AUTO_INCREMENT,
nombre VARCHAR(45) NOT NULL,
tienda VARCHAR(45) NOT NULL,
salario INT,
fecha_incorporacion DATE NOT NULL,
PRIMARY KEY (id_empleado) );

#4ª TABLA FACTURAS

CREATE TABLE facturas (
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
