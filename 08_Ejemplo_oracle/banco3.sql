-- Tabla CLIENTES
CREATE TABLE CLIENTES3 (
    cliente_id       NUMBER PRIMARY KEY,
    nombre           VARCHAR2(100) NOT NULL,
    apellido         VARCHAR2(100) NOT NULL,
    direccion        VARCHAR2(200),
    telefono         VARCHAR2(20),
    email            VARCHAR2(100) UNIQUE,
    fecha_registro   DATE DEFAULT SYSDATE
);

-- Tabla CUENTAS
CREATE TABLE CUENTAS3 (
    cuenta_id        NUMBER PRIMARY KEY,
    cliente_id       NUMBER NOT NULL,
    tipo_cuenta      VARCHAR2(50) NOT NULL,  -- Ej. 'AHORROS', 'CORRIENTE'
    saldo            NUMBER(12,2) DEFAULT 0,
    fecha_apertura   DATE DEFAULT SYSDATE,
    CONSTRAINT fk_cuenta_cliente FOREIGN KEY (cliente_id)
        REFERENCES CLIENTES3(cliente_id)
);

-- Tabla CREDITOS
CREATE TABLE CREDITOS3 (
    credito_id       NUMBER PRIMARY KEY,
    cliente_id       NUMBER NOT NULL,
    monto            NUMBER(12,2) NOT NULL,
    tasa_interes     NUMBER(5,2) NOT NULL,
    plazo_meses      NUMBER NOT NULL,
    fecha_aprobacion DATE NOT NULL,
    estado           VARCHAR2(20) CHECK (estado IN ('APROBADO', 'PENDIENTE', 'RECHAZADO')),
    CONSTRAINT fk_credito_cliente FOREIGN KEY (cliente_id)
        REFERENCES CLIENTES3(cliente_id)
);

-- Tabla TARJETAS_CREDITO
CREATE TABLE TARJETAS_CREDITO3 (
    tarjeta_id       NUMBER PRIMARY KEY,
    cliente_id       NUMBER NOT NULL,
    numero_tarjeta   VARCHAR2(16) UNIQUE NOT NULL,
    fecha_emision    DATE NOT NULL,
    fecha_expiracion DATE NOT NULL,
    limite_credito   NUMBER(12,2) NOT NULL,
    saldo_actual     NUMBER(12,2) DEFAULT 0,
    estado           VARCHAR2(20) CHECK (estado IN ('ACTIVA', 'INACTIVA', 'BLOQUEADA')),
    CONSTRAINT fk_tarjeta_cliente FOREIGN KEY (cliente_id)
        REFERENCES CLIENTES3(cliente_id)
);

-- Tabla TRANSACCIONES
CREATE TABLE TRANSACCIONES3 (
    transaccion_id   NUMBER PRIMARY KEY,
    cuenta_id        NUMBER,   -- Puede ser nulo si la transacción es por tarjeta
    tarjeta_id       NUMBER,   -- Puede ser nulo si la transacción es en cuenta
    monto            NUMBER(12,2) NOT NULL,
    tipo_transaccion VARCHAR2(20) CHECK (tipo_transaccion IN ('DEBITO', 'CREDITO')),
    fecha_transaccion DATE DEFAULT SYSDATE,
    CONSTRAINT fk_transaccion_cuenta FOREIGN KEY (cuenta_id)
        REFERENCES CUENTAS3(cuenta_id),
    CONSTRAINT fk_transaccion_tarjeta FOREIGN KEY (tarjeta_id)
        REFERENCES TARJETAS_CREDITO3(tarjeta_id)
);



-- Tabla PRODUCTOS
CREATE TABLE PRODUCTOS3 (
    producto_id      NUMBER PRIMARY KEY,
    nombre_producto  VARCHAR2(100) NOT NULL,
    descripcion      VARCHAR2(200),
    precio           NUMBER(10,2) NOT NULL,
    stock            NUMBER NOT NULL
);

-- Tabla FACTURAS
DROP TABLE FACTURAS3
CREATE TABLE FACTURAS3 (
    factura_id       NUMBER PRIMARY KEY,
    cliente_id       NUMBER NOT NULL,
    fecha_factura    DATE DEFAULT SYSDATE,
    total            NUMBER(12,2) NOT NULL,
    CONSTRAINT fk_factura_cliente FOREIGN KEY (cliente_id)
        REFERENCES CLIENTES3(cliente_id)
);

-- Tabla DETALLE_FACTURA
DROP TABLE DETALLE_FACTURA3 
CREATE TABLE DETALLE_FACTURA3 (
    detalle_id       NUMBER PRIMARY KEY,
    factura_id       NUMBER NOT NULL,
    producto_id      NUMBER NOT NULL,
    cantidad         NUMBER NOT NULL,
    precio_unitario  NUMBER(10,2) NOT NULL,
    CONSTRAINT fk_detalle_factura FOREIGN KEY (factura_id)
        REFERENCES FACTURAS3(factura_id),
    CONSTRAINT fk_detalle_producto FOREIGN KEY (producto_id)
        REFERENCES PRODUCTOS3(producto_id)
);
--------------------------------------------------------------------------------

-- Tabla EMPLEADOS
CREATE TABLE EMPLEADOS3 (
    empleado_id      NUMBER PRIMARY KEY,
    nombre           VARCHAR2(100) NOT NULL,
    apellido         VARCHAR2(100) NOT NULL,
    departamento     VARCHAR2(50) NOT NULL,  -- Ej. 'FINANZAS', 'VENTAS', etc.
    salario          NUMBER(10,2) NOT NULL,
    fecha_contratacion DATE DEFAULT SYSDATE,
    email            VARCHAR2(100) UNIQUE NOT NULL
);
------------------------------------------------------------------------
-- Tabla PROVEEDORES
CREATE TABLE PROVEEDORES3 (
    proveedor_id     NUMBER PRIMARY KEY,
    nombre           VARCHAR2(100) NOT NULL,
    contacto         VARCHAR2(100),
    telefono         VARCHAR2(20)
);

-- Tabla INVENTARIO
CREATE TABLE INVENTARIO3 (
    inventario_id    NUMBER PRIMARY KEY,
    producto_id      NUMBER NOT NULL,
    proveedor_id     NUMBER NOT NULL,
    cantidad         NUMBER NOT NULL,
    fecha_actualizacion DATE DEFAULT SYSDATE,
    CONSTRAINT fk_inventario_producto FOREIGN KEY (producto_id)
        REFERENCES PRODUCTOS3(producto_id),
    CONSTRAINT fk_inventario_proveedor FOREIGN KEY (proveedor_id)
        REFERENCES PROVEEDORES3(proveedor_id)
);
---------------------------------------------------------------------------------
-- Tabla CAMPAÑAS
CREATE TABLE CAMPAÑAS3 (
    campaña_id       NUMBER PRIMARY KEY,
    nombre_campaña   VARCHAR2(100) NOT NULL,
    fecha_inicio     DATE NOT NULL,
    fecha_fin        DATE,
    presupuesto      NUMBER(12,2)
);

-- Tabla CLIENTES_POTENCIALES
CREATE TABLE CLIENTES_POTENCIALES3 (
    potencial_id     NUMBER PRIMARY KEY,
    nombre           VARCHAR2(100) NOT NULL,
    apellido         VARCHAR2(100),
    email            VARCHAR2(100),
    telefono         VARCHAR2(20),
    fuente           VARCHAR2(50)   -- Ej. 'WEB', 'FERIA', etc.
);
--------------------------------------------------------------------------
-- Insertar Clientes
INSERT INTO CLIENTES3 (cliente_id, nombre, apellido, direccion, telefono, email)
VALUES (1, 'Juan', 'Pérez', 'Av. Siempre Viva 123', '555-0101', 'juan.perez@banco.com');

INSERT INTO CLIENTES3 (cliente_id, nombre, apellido, direccion, telefono, email)
VALUES (2, 'María', 'Gómez', 'Calle Falsa 456', '555-0202', 'maria.gomez@banco.com');

-- Insertar Cuentas
INSERT INTO CUENTAS3 (cuenta_id, cliente_id, tipo_cuenta, saldo)
VALUES (101, 1, 'AHORROS', 15000.00);

INSERT INTO CUENTAS3 (cuenta_id, cliente_id, tipo_cuenta, saldo)
VALUES (102, 2, 'CORRIENTE', 5000.00);

-- Insertar Créditos
INSERT INTO CREDITOS3 (credito_id, cliente_id, monto, tasa_interes, plazo_meses, fecha_aprobacion, estado)
VALUES (1001, 1, 20000.00, 5.5, 36, TO_DATE('2023-01-15','YYYY-MM-DD'), 'APROBADO');

INSERT INTO CREDITOS3 (credito_id, cliente_id, monto, tasa_interes, plazo_meses, fecha_aprobacion, estado)
VALUES (1002, 2, 15000.00, 6.0, 24, TO_DATE('2023-03-10','YYYY-MM-DD'), 'PENDIENTE');

-- Insertar Tarjetas de Crédito
INSERT INTO TARJETAS_CREDITO3 (tarjeta_id, cliente_id, numero_tarjeta, fecha_emision, fecha_expiracion, limite_credito, saldo_actual, estado)
VALUES (5001, 1, '1234567812345678', TO_DATE('2022-06-01','YYYY-MM-DD'), TO_DATE('2025-06-01','YYYY-MM-DD'), 10000.00, 2500.00, 'ACTIVA');

INSERT INTO TARJETAS_CREDITO3 (tarjeta_id, cliente_id, numero_tarjeta, fecha_emision, fecha_expiracion, limite_credito, saldo_actual, estado)
VALUES (5002, 2, '8765432187654321', TO_DATE('2023-02-01','YYYY-MM-DD'), TO_DATE('2026-02-01','YYYY-MM-DD'), 8000.00, 1500.00, 'ACTIVA');

-- Insertar Transacciones
INSERT INTO TRANSACCIONES3 (transaccion_id, cuenta_id, monto, tipo_transaccion)
VALUES (9001, 101, 500.00, 'CREDITO');

INSERT INTO TRANSACCIONES3 (transaccion_id, cuenta_id, monto, tipo_transaccion)
VALUES (9002, 102, 200.00, 'DEBITO');

----------------------------------------------------------------------------
-- Insertar Productos
INSERT INTO PRODUCTOS3 (producto_id, nombre_producto, descripcion, precio, stock)
VALUES (3001, 'Plan de Ahorro', 'Plan de ahorro a largo plazo', 1000.00, 50);

-- Insertar Facturas
INSERT INTO FACTURAS3 (factura_id, cliente_id, total)
VALUES (4001, 1, 1000.00);

-- Insertar Detalle de Factura
INSERT INTO DETALLE_FACTURA3 (detalle_id, factura_id, producto_id, cantidad, precio_unitario)
VALUES (400101, 4001, 3001, 1, 1000.00);
---------------------------------------------------------------------------
-- Insertar Empleados
INSERT INTO EMPLEADOS3 (empleado_id, nombre, apellido, departamento, salario, email)
VALUES (7001, 'Carlos', 'Ramírez', 'FINANZAS', 3500.00, 'carlos.ramirez@banco.com');

INSERT INTO EMPLEADOS3 (empleado_id, nombre, apellido, departamento, salario, email)
VALUES (7002, 'Ana', 'Martínez', 'VENTAS', 3200.00, 'ana.martinez@banco.com');

---------------------------------------------------------------------------------
-- Insertar Proveedores
INSERT INTO PROVEEDORES3 (proveedor_id, nombre, contacto, telefono)
VALUES (8001, 'Distribuidora XYZ', 'Luis Torres', '555-0303');

-- Insertar Inventario
INSERT INTO INVENTARIO3 (inventario_id, producto_id, proveedor_id, cantidad)
VALUES (800101, 3001, 8001, 20);
------------------------------------------------------------------------------------
-- Insertar Campañas
INSERT INTO CAMPAÑAS3 (campaña_id, nombre_campaña, fecha_inicio, fecha_fin, presupuesto)
VALUES (6001, 'Campaña Primavera', TO_DATE('2023-03-01','YYYY-MM-DD'), TO_DATE('2023-05-31','YYYY-MM-DD'), 50000.00);

-- Insertar Clientes Potenciales
INSERT INTO CLIENTES_POTENCIALES3 (potencial_id, nombre, apellido, email, telefono, fuente)
VALUES (600101, 'Luis', 'Sánchez', 'luis.sanchez@prospecto.com', '555-0404', 'WEB');

-----------------------------------------------------------------------------------
select
    c.nombre,
    sum(cc.monto) as total_creditos
from
    clientes3 c
inner join
    creditos3 cc
on
    c.cliente_id=cc.cliente_id
group by
    c.nombre
having
    sum(cc.monto)>10000

--------------------------------------------------------------------------------
select
    c.nombre,
    c.apellido,
    cc.saldo
from
    clientes3 c
inner join
    cuentas3 cc
on
    c.cliente_id=cc.cliente_id
group by
    c.nombre,
    c.apellido,
    cc.saldo
having
    cc.saldo > (select AVG(saldo) from cuentas3)
--------------------------------------------------------------------------------
SELECT c.cliente_id, c.nombre, c.apellido, cu.saldo
FROM CLIENTES c
JOIN CUENTAS cu ON c.cliente_id = cu.cliente_id
WHERE cu.saldo > (SELECT AVG(saldo) FROM CUENTAS);
--------------------------------------------------------------------------------
select
    c.nombre,
    d.cantidad,
    p.nombre_producto,
    f.total
from
    clientes3 c
inner join
    facturas3 f
on
    c.cliente_id=f.cliente_id
inner join
    DETALLE_FACTURA3 d
on
    f.factura_id=d.factura_id
inner join
    PRODUCTOS3 p
on
    d.producto_id=p.producto_id
--------------------------------------------------------------------------------
--Necesito obtener una lista que muestre, para cada cliente, su nombre y apellido, junto con el total de créditos aprobados (es decir, la suma de los montos de los créditos cuyo estado es 'APROBADO'). Además, solo se deben mostrar aquellos clientes cuyo total de créditos aprobados supere 10,000. El resultado debe estar ordenado de mayor a menor según el total de créditos.
select
    c.nombre,
    c.apellido,
    sum(cc.monto) as monto_total
from
    clientes3 c
inner join
    CREDITOS3 cc
on 
    c.cliente_id=cc.cliente_id
where
    cc.estado = 'APROBADO'
group by
    c.nombre,
    c.apellido
HAVING
    sum(cc.monto) > 10000
order by
    sum(cc.monto) desc
    
--------------------------------------------------------------------------------
select
    p.producto_id,
    p.nombre_producto,
    sum(d.cantidad) as total_cantidad,
    sum(d.cantidad * precio_unitario) as total_generado
from
    productos3 p
inner join
    DETALLE_FACTURA3 d
on
    p.producto_id=d.producto_id
group by
    p.producto_id,
    p.nombre_producto
HAVING
    SUM(d.cantidad * d.precio_unitario) > 5000
order by
    sum(d.cantidad * precio_unitario) desc
-------------------------------------------------------
select
    c.nombre,
    c.apellido,
    sum(tc.saldo_actual) as deuda_total
from
    clientes3 c
inner join
    TARJETAS_CREDITO3 tc
on
    c.cliente_id=tc.cliente_id
where
    tc.estado = 'ACTIVA'
group by
    c.nombre,
    c.apellido
having
     SUM(tc.saldo_actual) > 0
order by
    sum(tc.saldo_actual) desc
---------------------------------------------------------------------
--clientes con total de cuentas y total de saldos
select
    c.nombre,
    c.apellido,
    cc.tipo_cuenta,
    count(cuenta_id) as total_cuentas,
    sum(cc.saldo) as total_saldo
from
    clientes3 c
inner join
    CUENTAS3 cc
on
    c.cliente_id=cc.cliente_id
group by
    c.nombre,
    c.apellido,
    cc.tipo_cuenta
having
    sum(cc.saldo) >5000
order by
    sum(cc.saldo) desc
------------------------------------------------------------------------------




--procedimientos almacenados
--procedimiento para buscar el saldo de una cuenta
CREATE OR REPLACE PROCEDURE obtener_saldo_cliente (
    p_cliente_id IN NUMBER,      -- ID del cliente (entrada)
    p_saldo_total OUT NUMBER     -- Saldo total (salida)
) AS
BEGIN
    -- Calculamos el saldo total sumando los saldos de sus cuentas
    SELECT NVL(SUM(saldo), 0)
    INTO p_saldo_total
    FROM CUENTAS3
    WHERE cliente_id = p_cliente_id;
END obtener_saldo_cliente;
------------------
EXEC obtener_saldo_cliente(1, :v_saldo);
PRINT v_saldo;


---obtener saldo total
CREATE OR REPLACE PROCEDURE obtener_total_saldo (
    p_cliente_id IN number,
    p_total OUT NUMBER 
)AS
BEGIN
    select NVL(SUM(saldo), 0)
    into p_total
    from cuentas3
    where p_cliente_id=cliente_id;
END obtener_total_saldo;
------------------------------------------------
VARIABLE saldo NUMBER;
EXEC obtener_total_saldo(1,:saldo);
print saldo;
-------------------------------
---retornar el saldo y la cantidad de cuentas del cliente
create or replace procedure saldo_cuentas(
    p_cliente_id in number,
    p_saldo out number,
    p_cuentas out number
)as
begin
    select 
        nvl(sum(saldo),0), 
        count(*)
    into
        p_saldo, 
        p_cuentas
    from
        cuentas3
    where cliente_id=p_cliente_id;
end saldo_cuentas;
/
-----------------------------
variable c1 number;
variable cc number;
exec saldo_cuentas(1, :c1, :cc);
print c1
print cc
--------------------------------
