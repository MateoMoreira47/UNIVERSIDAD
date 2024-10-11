--PRACTICAS DML
-----------------------------------------------------------------------------------------------------------------------------------

--Acceder a PosrgreSql mediante la dbeaver: localhost port=5432 usuario:postgres clave:Base_2024_1
-- LENGUAJE DE DEFINICION DE DATOS
---------------------------------------------------------------------------------------

do $$
--Integrantes:
begin

create table if not exists sucursal(
    nombre_sucursal varchar not null,
    ciudad varchar not null,
    activos NUMERIC(10, 2),    
    CONSTRAINT pk_sucursal primary key(nombre_sucursal)
);

create table if not exists cliente(
    dni varchar not null,
    cliente varchar not null,
    domicilio varchar,    
    CONSTRAINT pk_cliente primary key(dni)
);

create table if not exists cuenta(
    numero_cuenta varchar not null,
    saldo NUMERIC(10, 2) default 0 not null,
    nombre_sucursal varchar not null,    
    comision NUMERIC(10, 2) not null default 0 ,
    apertura date not null,
    CONSTRAINT pk_cuenta primary key(numero_cuenta),
    CONSTRAINT fk_cuenta_sucursal foreign key(nombre_sucursal) references sucursal(nombre_sucursal)
);

create table if not exists impositor(
    numero_cuenta varchar not null,
    dni varchar not null,
    CONSTRAINT fk_impositor_cuenta foreign key(numero_cuenta) references sucursal(numero_cuenta),
    CONSTRAINT fk_impositor_cliente foreign key(dni) references cliente(dni),

    CONSTRAINT pk_impositor primary key(numero_cuenta,dni),


);

-- LENGUAJE DE MANIPULACION DE DATOS
---------------------------------------------------------------------------------------

--1. Ingrese 2 sucursales Manta y Bahía
INSERT INTO sucursal values ('SUCURSAL MT', 'MANTA', 1512),('SUCURSAL BH', 'BAHIA', 1512);

--2. Ingrese 2 registros de clientes.

INSERT INTO cliente (dni, nombre_cliente, domicilio) values ('1308999281', 'JORGE DAVID', 'LA CALIFORNIA');
INSERT INTO cliente (dni, nombre_cliente, domicilio) values ('1305327940', 'JAVIER DEMERA', 'CRUCITA');

/*3. Registre 2 cuentas:
	1 de la sucursal Manta
	1 de la sucursal Bahía
*/

INSERT INTO cuenta(numero_cuenta, saldo, nombre_sucursal , comision, fecha_apertura) values ('310086197', 500, 'SUCURSAL MT_', 14.5, '2023/01/29' );
INSERT INTO cuenta(numero_cuenta, saldo, nombre_sucursal , comision, fecha_apertura) values ('310086198', 200, 'SUCURSAL BH_', 11.5, '2023/01/29' );
SELECT * FROM cuenta;

--4. Relacione las 2 cuentas con los registros de clientes (impositor).

INSERT INTO impositor values ('1308999281', '310086198');
INSERT INTO impositor (numero_cuenta, dni) values ('1308999281', '310086199');


--5. Incremente $1,00 el saldo de las cuentas cuya comision sean inferiores a 10
UPDATE cuenta SET saldo = saldo + 1 where comision < 10;

--Incremente la comision a 2.0 a las cuentas se hayan aperturado en el ultimo mes.

UPDATE cuenta SET comision = comision + 2 where fecha_apertura between '' AND '';

--6. Elimine las cuentas de clientes que no dispongan saldo.


--7. Aumente $0.15 sobre el saldo de las cuentas provenientes de la sucursal BahÃ­a.
UPDATE cuenta SET saldo = saldo + 0.15 where nombre_sucursal = 'CC BAHIA';

--8. Elimine las sucursales que no dispongan de activos.


-- LENGUAJE DE CONSULTA DE DATOS
----------------------------------------------------------------------------------------------------------
--9. Listar datos de cuentas superiores a los $1.000,00.


--10. Liste las cuentas aperturadas en el ultimo aÃ±o.


--11. Listar cuentas de la sucursal CC BAHIA


--12. Liste las cuentas que tienen saldo entre 500 y 1000


--13. Liste las cuentas con comisiones entre 1.5 y 2.0

end $$
