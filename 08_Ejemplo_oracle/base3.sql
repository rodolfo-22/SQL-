-- Tabla Productos
CREATE TABLE Productos (
    idproducto NUMBER PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    categoria VARCHAR2(50),
    precio_unitario NUMBER(10, 2) NOT NULL
);

-- Tabla Almacenes
CREATE TABLE Almacenes (
    idalmacen NUMBER PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    direccion VARCHAR2(200),
    ciudad VARCHAR2(100)
);

-- Tabla Promociones
CREATE TABLE Promociones (
    idpromocion NUMBER PRIMARY KEY,
    descripcion VARCHAR2(200) NOT NULL,
    descuento NUMBER(5, 2) NOT NULL
);

-- Tabla Clientes
CREATE TABLE Clientes (
    idcliente NUMBER PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    apellido VARCHAR2(100) NOT NULL,
    email VARCHAR2(100),
    telefono VARCHAR2(15)
);

-- Tabla Tiempo
CREATE TABLE Tiempo (
    idtiempo NUMBER PRIMARY KEY,
    fecha DATE NOT NULL,
    año NUMBER(4) NOT NULL,
    mes NUMBER(2) NOT NULL,
    dia NUMBER(2) NOT NULL
);

-- Tabla Ventas (Tabla de hechos)
CREATE TABLE Ventas (
    idventa NUMBER PRIMARY KEY,
    idproducto NUMBER REFERENCES Productos(idproducto),
    idalmacen NUMBER REFERENCES Almacenes(idalmacen),
    idpromocion NUMBER REFERENCES Promociones(idpromocion),
    idcliente NUMBER REFERENCES Clientes(idcliente),
    idtiempo NUMBER REFERENCES Tiempo(idtiempo),
    unidades NUMBER NOT NULL,
    precio NUMBER(10, 2) NOT NULL
);