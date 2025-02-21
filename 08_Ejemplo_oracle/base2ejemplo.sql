DROP TABLE carrito CASCADE CONSTRAINTS;
DROP TABLE detalle CASCADE CONSTRAINTS;
DROP TABLE factura CASCADE CONSTRAINTS;
DROP TABLE producto CASCADE CONSTRAINTS;
DROP TABLE cliente CASCADE CONSTRAINTS;
DROP TABLE categoria CASCADE CONSTRAINTS;
drop table usuarios;
drop table roles;
commit;

CREATE TABLE categoria(
    id_categoria NUMBER(3) PRIMARY KEY,
    nombre_cat VARCHAR2(20),
    descripcion VARCHAR2(50)
);


CREATE TABLE producto(
    id_producto NUMBER(5) PRIMARY KEY,
    nombre_prod VARCHAR2(30),
    precio_unit NUMBER(12,2),
    stock NUMBER(6),
    id_categori NUMBER(3),
    CONSTRAINT fk_categoria FOREIGN KEY (id_categori) REFERENCES categoria(id_categoria)
);

CREATE TABLE cliente (
    id_cliente NUMBER(10) PRIMARY KEY,
    nombre VARCHAR2(15),
    apellido VARCHAR2(20),
    edad NUMBER(2),
    direccion VARCHAR2(30),
    telefono NUMBER(10),
    email VARCHAR2(45),
    tarjeta_credito NUMBER(16),
    direccion_envio VARCHAR2(30)
);


CREATE TABLE factura (
    id_factura NUMBER(7) PRIMARY KEY,
    id_client NUMBER(10),
    fecha DATE,
    total_factura NUMBER(12,2),
    estado_fact varchar2(12)
);

CREATE TABLE detalle (
    num_detalle NUMBER(7),
    id_fact NUMBER(7),
    id_producto NUMBER(8),
    cantidad NUMBER(4),
    precio NUMBER(12,2),
    PRIMARY KEY (id_fact, num_detalle),  -- Clave primaria compuesta
    CONSTRAINT fk_factura FOREIGN KEY (id_fact) REFERENCES factura(id_factura),
    CONSTRAINT fk_producto FOREIGN KEY (id_producto) REFERENCES producto(id_producto)
);


CREATE TABLE carrito (
    id_carrito NUMBER(5) PRIMARY KEY,
    id_factura NUMBER(7),
    id_cliente number(10),
    cantidad_prod NUMBER(5),
    CONSTRAINT fk_factura_carrito FOREIGN KEY (id_factura) REFERENCES factura(id_factura),
    CONSTRAINT fk_id_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);


create table usuarios(
id_usuario number(5),
id_rol number(2),
nombre_usuario varchar2(10));


create table roles(
id_rol number(3),
nombre_rol varchar2(15),
descripcion varchar2(30));

commit;

--cuantas facturas tiene cada cliente
select
    c.nombre,
    count( f.id_client) AS no_facturas
from
    cliente c
inner join
    factura f
on
    c.id_cliente = f.id_client
group by
    c.nombre


--subconsultas

select
    c.nombre,
    c.apellido
from
    cliente c
where
    c.edad>(select AVG(b.edad) from cliente b)

select * from cliente