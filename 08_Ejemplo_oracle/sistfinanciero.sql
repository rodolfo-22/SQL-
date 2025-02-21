-- Obtén el nombre completo del cliente, el tipo de cuenta, el saldo actual y la cantidad total de transacciones realizadas en su cuenta.
SELECT 
    c.nombre, 
    c.apellido, 
    ct.tipo_cuenta, 
    ct.saldo, 
    COUNT(t.transaccion_id) AS total_transacciones
FROM 
    Clientes c
INNER JOIN 
    Cuentas ct ON c.cliente_id = ct.cliente_id
INNER JOIN 
    Transacciones t ON ct.cuenta_id = t.cuenta_id
GROUP BY 
    c.nombre, c.apellido, ct.tipo_cuenta, ct.saldo;


--
SELECT
    c.nombre, 
    c.apellido, 
    SUM(ct.saldo) AS saldo_total, -- Suma el saldo de todas las cuentas del cliente
    COUNT(t.transaccion_id) AS total_transacciones -- Cuenta las transacciones de todas las cuentas
FROM
    clientes c
INNER JOIN
    cuentas ct ON c.cliente_id = ct.cliente_id
INNER JOIN 
    Transacciones t ON ct.cuenta_id = t.cuenta_id
GROUP BY
    c.nombre, 
    c.apellido, 
    c.cliente_id -- Agrupamos por cliente para obtener resultados por cliente
HAVING COUNT( DISTINCT ct.cuenta_id) > 1


--Clientes con saldo total superior al promedio
SELECT
    c.nombre,
    c.apellido,
    SUM(ct.saldo) AS saldo_total
FROM
    clientes c
INNER JOIN
    cuentas ct ON c.cliente_id = ct.cliente_id
GROUP BY
    c.nombre,
    c.apellido,
    c.cliente_id
HAVING
    SUM(ct.saldo) > (SELECT AVG(saldo) FROM cuentas);
    --El AVG() la función devuelve el valor promedio de una columna numérica.

--ranking de clientes con mayor saldo
SELECT
    c.nombre,
    c.apellido,
    SUM(ct.saldo) AS saldo_total,
    RANK() OVER (ORDER BY SUM(ct.saldo) DESC) AS ranking
FROM
    clientes c
INNER JOIN
    cuentas ct ON c.cliente_id = ct.cliente_id
GROUP BY
    c.nombre,
    c.apellido,
    c.cliente_id;

--transaciones por sucursal
SELECT 
    COUNT(t.transaccion_id) AS Total_transacciones,
    s.nombre,
    tt.descripcion AS tipo_transaccion
FROM
    cuentas c
INNER JOIN
    sucursales s
    ON 
    c.sucursal_id=s.sucursal_id
INNER JOIN
    transacciones t
    ON
    c.cuenta_id=t.cuenta_id
INNER JOIN
    Tipos_Transaccion tt
    ON
    t.tipo_transaccion_id=tt.tipo_transaccion_id
GROUP BY
    s.nombre,
    s.sucursal_id,
    tt.descripcion