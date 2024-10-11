DO $$
-- Integrantes: Barriga Marlon Andres && Lucas Freddy Alexis
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
   SELECT numero_cuenta from g7_2024_1.cuenta where fecha_apertura between '2024-07-01' AND '2024-07-31';


    -- 11. Listar cuentas de la sucursal Bahía
    SELECT * FROM g7_2024_1.cuenta WHERE nombre_sucursal = 'SUCURSAL BH';

    -- 12. Liste las cuentas que tienen saldo entre 500 y 1000
    SELECT * FROM g7_2024_1.cuenta WHERE saldo BETWEEN 500 AND 1000;

    -- 13. Liste las cuentas con comisiones entre 1.5 y 2.0
    SELECT * FROM g7_2024_1.cuenta WHERE comision BETWEEN 1.5 AND 2.0;

END $$;
