DO $$
-- Integrantes: Barriga Medina Marlon Andres - Lucas Lucas Freddy Alexis
BEGIN

    CREATE TABLE IF NOT EXISTS g7_2024_1.sucursal(
        nombre_sucursal VARCHAR NOT NULL,
        ciudad VARCHAR NOT NULL,
        activos NUMERIC(10, 2),    
        CONSTRAINT pk_sucursal PRIMARY KEY (nombre_sucursal)
    );

    CREATE TABLE IF NOT EXISTS g7_2024_1.cliente(
        dni VARCHAR NOT NULL,
        nombre_cliente VARCHAR NOT NULL,
        domicilio VARCHAR,    
        CONSTRAINT pk_cliente PRIMARY KEY (dni)
    );

    CREATE TABLE IF NOT EXISTS g7_2024_1.cuenta(
        numero_cuenta VARCHAR NOT NULL,
        saldo NUMERIC(10, 2) DEFAULT 0 NOT NULL,
        nombre_sucursal VARCHAR NOT NULL,    
        comision NUMERIC(10, 2) NOT NULL DEFAULT 0,
        fecha_apertura DATE NOT NULL,
        CONSTRAINT pk_cuenta PRIMARY KEY (numero_cuenta),
        CONSTRAINT fk_cuenta_sucursal FOREIGN KEY (nombre_sucursal) REFERENCES g7_2024_1.sucursal (nombre_sucursal)
    );

    CREATE TABLE IF NOT EXISTS g7_2024_1.impositor(
        numero_cuenta VARCHAR NOT NULL,
        dni VARCHAR NOT NULL,
        CONSTRAINT fk_impositor_cuenta FOREIGN KEY (numero_cuenta) REFERENCES g7_2024_1.cuenta (numero_cuenta),
        CONSTRAINT fk_impositor_cliente FOREIGN KEY (dni) REFERENCES g7_2024_1.cliente (dni),
        CONSTRAINT pk_impositor PRIMARY KEY (numero_cuenta, dni)
    );

    -- LENGUAJE DE MANIPULACION DE DATOS
    ---------------------------------------------------------------------------------------

    -- 1. Ingrese 2 sucursales Manta y Bahía
    insert into g7_2024_1.sucursal (nombre_sucursal, ciudad, activos) VALUES 
    ('SUCURSAL MT', 'MANTA', 1512),
    ('SUCURSAL BH', 'BAHIA', 1512);

    -- 2. Ingrese 2 registros de clientes.
    INSERT INTO g7_2024_1.cliente (dni, nombre_cliente, domicilio) VALUES 
    ('1308999281', 'JORGE DAVID', 'LA CALIFORNIA'),
    ('1305327940', 'JAVIER DEMERA', 'CRUCITA');

    -- 3. Registre 2 cuentas:
    --    1 de la sucursal Manta
    --    1 de la sucursal Bahía
    INSERT INTO g7_2024_1.cuenta (numero_cuenta, saldo, nombre_sucursal, comision, fecha_apertura) VALUES 
    ('310086197', 500, 'SUCURSAL MT', 14.5, '2023-01-29'),
    ('310086198', 200, 'SUCURSAL BH', 11.5, '2023-01-29');

    -- 4. Relacione las 2 cuentas con los registros de clientes (impositor).
    INSERT INTO g7_2024_1.impositor (numero_cuenta, dni) VALUES 
    ('310086197', '1308999281'),
    ('310086198', '1305327940');

    -- 5. Incremente $1,00 el saldo de las cuentas cuya comision sea inferior a 10
    UPDATE g7_2024_1.cuenta SET saldo = saldo + 1 WHERE comision < 10;

    -- Incremente la comision a 2.0 a las cuentas que se hayan aperturado en el ultimo mes.
    UPDATE g7_2024_1.cuenta SET comision = comision + 2 WHERE fecha_apertura BETWEEN CURRENT_DATE - INTERVAL '1 month' AND CURRENT_DATE;

    -- 6. Elimine las cuentas de clientes que no dispongan saldo.
    DELETE FROM g7_2024_1.cuenta WHERE saldo = 0;

    -- 7. Aumente $0.15 sobre el saldo de las cuentas provenientes de la sucursal Bahía.
    UPDATE g7_2024_1.cuenta SET saldo = saldo + 0.15 WHERE nombre_sucursal = 'SUCURSAL BH';

    -- 8. Elimine las sucursales que no dispongan de activos.
    DELETE FROM g7_2024_1.sucursal WHERE activos = 0;

    -- LENGUAJE DE CONSULTA DE DATOS
    ----------------------------------------------------------------------------------------------------------

    -- 9. Listar datos de cuentas superiores a los $1.000,00.
    SELECT numero_cuenta FROM g7_2024_1.cuenta WHERE saldo > 1000;

    -- 10. Liste las cuentas aperturadas en el ultimo año.
   SELECT numero_cuenta from g7_2024_1.cuenta where fecha_apertura between 2024-07-01 AND 2024-07-31;


    -- 11. Listar cuentas de la sucursal Bahía
    SELECT * FROM g7_2024_1.cuenta WHERE nombre_sucursal = 'SUCURSAL BH';

    -- 12. Liste las cuentas que tienen saldo entre 500 y 1000
    SELECT * FROM g7_2024_1.cuenta WHERE saldo BETWEEN 500 AND 1000;

    -- 13. Liste las cuentas con comisiones entre 1.5 y 2.0
    SELECT * FROM g7_2024_1.cuenta WHERE comision BETWEEN 1.5 AND 2.0;

END $$;


--**********************PRACTICA DE BASE DE DATOS: SELECT FROM
--SEMANA 15: 22 DE JULIO DE 2024
--INTEGRANTES:
--PARTE 1
--1.1 Seleccione los clientes cuyo nombre empiece con M.
select nombre_cliente from g7_2024_1.cliente where nombre_cliente like 'M%';
--1.2 Liste clientes que terminen el E
select nombre_cliente from g7_2024_1.cliente where nombre_cliente like '%E';

--1.3 Liste los clientes que hayan registrado el domicilio.
select nombre_cliente from g7_2024_1.cliente where domicilio is not null; 


--1.4 Obtenga la cantidad de cuentas registradas en la sucursal de la ciudad de BAHIA.
SELECT nombre_sucursal, COUNT(*) AS cantidad_de_cuentas
FROM g7_2024_1.cuenta
WHERE nombre_sucursal = 'SUCURSAL BH'
GROUP BY nombre_sucursal;


--1.5 Obtenga la cuenta con mayor y con menor saldo.
SELECT numero_cuenta, saldo
FROM g7_2024_1.cuenta
ORDER BY saldo ASC
LIMIT 1;


SELECT numero_cuenta, saldo
FROM g7_2024_1.cuenta
ORDER BY saldo desc
LIMIT 1;

--1.7 Obtenga el promedio de las comisiones.
SELECT AVG(comision) AS promedio_comisiones
FROM g7_2024_1.cuenta;


--1.8 Contar el n�mero de cuentas en cada sucursal.
 SELECT nombre_sucursal, COUNT(*) AS cantidad_de_cuentas
FROM g7_2024_1.cuenta
GROUP BY nombre_sucursal;


--1.9 Liste las cuentas ordenadas por fecha de apertura (mas reciente)
select * from g7_2024_1.cuenta order by fecha_apertura desc;

--1.10 Obtener la suma total de comisiones generadas en cada sucursal, mostrando solo aquellas sucursales con una suma total de comisiones mayor a 5,000.
SELECT s.nombre_sucursal, SUM(c.comision) AS suma_comision
FROM g7_2024_1.cuenta c
INNER JOIN g7_2024_1.sucursal s ON s.nombre_sucursal = c.nombre_sucursal 
GROUP BY s.nombre_sucursal
HAVING SUM(c.comision) > 5000;

--1.11 De las cuentas registradas, liste la ciudad a la que pertenece.
SELECT c.numero_cuenta, s.ciudad
FROM g7_2024_1.cuenta c
INNER JOIN g7_2024_1.sucursal s ON c.nombre_sucursal = s.nombre_sucursal ;


--1.12 Liste los clientes que poseen un n�mero de cuenta en la sucursal de la ciudad de Bahia.
SELECT c.numero_cuenta, s.ciudad 
FROM g7_2024_1.cuenta c
INNER JOIN g7_2024_1.sucursal s ON c.nombre_sucursal = s.nombre_sucursal 
WHERE s.ciudad = 'BAHIA';

--1.13 Liste el dni ylos nombres de los clientes con o sin n�meros de cuenta.
SELECT c.dni, c.cliente 
FROM cliente c
LEFT JOIN cuenta cu ON c.dni = c.cliente 
WHERE cu.numero_cuenta IS NULL;


--1.14 Listar las cuentas bancarias de la ciudad de MANTA con los siguientes  
--campos: dni, nombre_cliente, saldo, nombre_sucursal y ciudad. 
SELECT c.dni, c.cliente AS nombre_cliente, a.Saldo, b.nombre_sucursal , b.Ciudad
FROM cliente c
JOIN cuenta a ON c.cliente = c.cliente 
JOIN sucursal b ON a.nombre_sucursal = b.nombre_sucursal 
WHERE b.ciudad = 'MANTA';


--***************PARTE 2 *************************
--2.1 Implemente la siguiente base de datos: Creacion de la Estructura

--2.2 Insertar 3 fabricantes tecnolog�a

--2.3 Insertar 5 art�culos por cada fabricante (15 art�culos)

--2.4 Obtenga el nombre y precio de todos los art�culos.

--2.5 Obtenga el nombre de todos los art�culos con precios superiores a $100,00

--2.6 A�adir un nuevo producto: Altavoces de $70,56 (del fabricante 2).

--2.7 Obtenga un listado completo de art�culos, incluyendo por cada articulo sus datos (nombreArticulo, y precio)
--y de su fabricante (nombreFabricante).


--2.8 Obtener todos los datos de los fabricantes cuyo nombre comience por �V�

--2.9 Obtener el precio total de todos los articulos

--2.10 Obtener el n�mero de articulos existentes




