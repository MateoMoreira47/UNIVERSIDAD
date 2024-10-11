do $$

--Justin Garcia, Mateo Moreira--

begin
	
	create schema if not exists g8_2024_1;
    create table if not exists g8_2024_1.Personal(
    
    ID_Personal bigserial not null,
    Cedula varchar (100),
    Apellido1 varchar (250),
    Apellido2 varchar (250),
    Nombre1 varchar (500),
    Nombre2 varchar (500),
    Fecha_Nacimiento date,
    constraint pk_Personal primary key (ID_Personal)
    
   );
   
   create table if not exists g8_2024_1.Tipo_Rubro(
   
   ID_Tipo_Rubro int not null,
   Descripcion varchar (200),
   Estado varchar (1),
   Tipo char (1),
   
   constraint pk_Tipo_Rubro primary key (ID_Tipo_Rubro)
   ) ;	
	
  
  create table if not exists g8_2024_1.Periodo(
  
  ID_Periodo serial not null,
  Anio serial,
  Mes serial,
  Descripcion varchar (200),
  Estado varchar (1),
  
  constraint pk_ID_Periodo primary key (ID_Periodo)
  
  );
  
  
  
  create table if not exists g8_2024_1.Detalle_Rubro(
  
  ID_Personal bigserial not null,
  ID_Periodo serial not null,
  ID_Tipo_Rubro serial not null,
  Valor numeric (10,2),
  
  constraint pk_Detalle_Rubro_ID_Personal_ID_Tipo_Rubro_ID_Periodo primary key (ID_Personal, ID_Tipo_Rubro, ID_Periodo),
  constraint fk_Detalle_Rubro_ID_Personal foreign key (ID_Personal) references g8_2024_1.Personal (ID_Personal),
  constraint fk_Detalle_Rubro_ID_Tipo_Rubro foreign key (ID_Tipo_Rubro) references g8_2024_1.Tipo_Rubro (ID_Tipo_Rubro),
  constraint fk_Detalle_Rubro_ID_Periodo foreign key (ID_Periodo) references g8_2024_1.Periodo (ID_Periodo)
  
  );
 
 
 create table if not exists g8_2024_1.Detalle_Nomina(
 ID_Personal bigserial not null,
 ID_Periodo serial not null,
 Total_Ingreso numeric (10,2),
 Total_Descuento numeric (10,2),
 Total numeric (10,2),
 Total_Aporte numeric (10,2),
 
 constraint pk_Detalle_Nomina_ID_Personal_ID_Periodo primary key (ID_Personal, ID_Periodo),
 constraint fk_Detalle_Nomina_ID_Personal foreign key (ID_Personal) references g8_2024_1.Personal (ID_Personal),
 constraint fk_Detalle_Nomina_ID_Periodo foreign key (ID_Periodo) references g8_2024_1.Periodo (ID_Periodo)
 
 );

-- Inicia una transacción
BEGIN TRANSACTION;

-- Agrega una columna "direccion" a la tabla "Personal"
ALTER TABLE g8_2024_1.Personal 
ADD COLUMN direccion VARCHAR NULL;

-- Agrega restricciones a la tabla "Detalle_Nomina"
ALTER TABLE g8_2024_1.Detalle_Nomina
ADD CONSTRAINT chk_Total_Ingreso CHECK (Total_Ingreso > 0),
ADD CONSTRAINT chk_Total_Descuento CHECK (Total_Descuento > 0),
ADD CONSTRAINT chk_Total_Aporte CHECK (Total_Aporte > 0),
ADD CONSTRAINT chk_Total CHECK (Total > 0);


ALTER TABLE g8_2024_1.Tipo_Personal 
ADD CONSTRAINT unique_cedula UNIQUE (Cedula);


ALTER TABLE g8_2024_1.Personal 
ADD COLUMN Puesto VARCHAR NOT NULL;

ALTER TABLE g8_2024_1.Personal 
RENAME COLUMN Puesto TO Cargo;


ALTER TABLE g8_2024_1.Tipo_Rubro 
ADD CONSTRAINT chk_tipo CHECK (tipo IN ('I', 'A', 'D'));


BEGIN TRANSACTION;


ALTER TABLE g8_2024_1.Personal 
ADD COLUMN direccion VARCHAR NULL;


ALTER TABLE g8_2024_1.Detalle_Nomina
ADD CONSTRAINT chk_Total_Ingreso CHECK (Total_Ingreso > 0),
ADD CONSTRAINT chk_Total_Descuento CHECK (Total_Descuento > 0),
ADD CONSTRAINT chk_Total_Aporte CHECK (Total_Aporte > 0),
ADD CONSTRAINT chk_Total CHECK (Total > 0);


ALTER TABLE g8_2024_1.Tipo_Personal 
ADD CONSTRAINT unique_cedula UNIQUE (Cedula);


ALTER TABLE g8_2024_1.Personal 
ADD COLUMN Puesto VARCHAR NOT NULL;

ALTER TABLE g8_2024_1.Personal 
RENAME COLUMN Puesto TO Cargo;


ALTER TABLE g8_2024_1.Tipo_Rubro 
ADD CONSTRAINT chk_tipo CHECK (tipo IN ('I', 'A', 'D'));

commit;


end $$
