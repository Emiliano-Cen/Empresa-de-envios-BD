------------------------------------------------------------
-- DDL
------------------------------------------------------------
create database GlobalTransporteBD
use GlobalTransporteBD

----------------------------------------------------------
-- tabla: TipoVehiculo
----------------------------------------------------------
create table TipoVehiculo(
    CodigoTipoVehiculo char(5) not null primary key,
    Descripcion        varchar(30) not null
);

----------------------------------------------------------
-- tabla: Vehiculo
---------------------------------------------------------
create table Vehiculo(
    IdVehiculo         int identity(1,1) not null primary key,
    Matricula          varchar(10) not null unique,
    Descripcion        varchar(30) not null,
    Marca              varchar(20) not null,
    Modelo             varchar(20) not null,
    AnioFabricacion    int,
    CapacidadCargaKg   int not null check (CapacidadCargaKg > 0),
    ConsumoPromedioKm  decimal(10,2),
    CodigoTipoVehiculo char(5) not null,
    foreign key (CodigoTipoVehiculo) references TipoVehiculo(CodigoTipoVehiculo)
);

---------------------------------------------------------
-- tabla: Chofer
---------------------------------------------------------
create table Chofer(
    NroFuncionario  int not null primary key,
    CI              varchar(12) not null,
    Nombre          varchar(50) not null,
    Apellido        varchar(50) not null,
    FechaNacimiento date not null,
    NroLicencia     varchar(20) not null,
    Telefono        varchar(20),
    IdVehiculo      int,
    foreign key (IdVehiculo) references Vehiculo(IdVehiculo)
);

------------------------------------------------------------
-- tabla: HabilidadEspecial
--------------------------------------------------------
create table HabilidadEspecial(
    IdHabilidad int identity(1,1) not null primary key,
    Descripcion varchar(30) not null
);

-----------------------------------------------------
-- tabla: ChoferHabilidad (relación N:N)
----------------------------------------------------------
create table ChoferHabilidad(
    NroFuncionario int not null,
    IdHabilidad    int not null,
    primary key (NroFuncionario, IdHabilidad),
    foreign key (NroFuncionario) references Chofer(NroFuncionario),
    foreign key (IdHabilidad)    references HabilidadEspecial(IdHabilidad)
);

------------------------------------------------------------
-- tabla: Cliente
--------------------------------------------------------
create table Cliente(
    NroCliente  int not null primary key,
    RazonSocial varchar(40) not null,
    Direccion   varchar(100),
    Telefono    varchar(20),
    PaisOrigen  varchar(50)
);

---------------------------------------------------------
-- tabla: Envio
----------------------------------------------------------
create table Envio(
    NroEnvio         int identity(1,1) not null primary key,
    FechaSalida      date not null,
    HoraSalida       time(0) not null,
    FechaFinEstimada date not null,
    HoraFinEstimada  time(0) not null,
    FechaFinReal     date,
    HoraFinReal      time(0),
    IdVehiculo       int not null,
    foreign key (IdVehiculo) references Vehiculo(IdVehiculo)
);

---------------------------------------------------------
-- tabla: AsignacionChoferEnvio (relación N:N)
------------------------------------------------------------
create table AsignacionChoferEnvio(
    NroEnvio       int not null,
    NroFuncionario int not null,
    primary key (NroEnvio, NroFuncionario),
    foreign key (NroEnvio)       references Envio(NroEnvio),
    foreign key (NroFuncionario) references Chofer(NroFuncionario)
);

---------------------------------------------------------
-- tabla: Paquete
----------------------------------------------------------
create table Paquete(
    IdPaquete    int identity(1,1) not null primary key,
    Peso         decimal(10,2) not null check (Peso > 0),
    Volumen      decimal(10,2) not null check (Volumen > 0),
    Descripcion  varchar(60) not null,
    NroEnvio     int not null,
    NroCliente   int not null,
    OrdenEntrega int not null check (OrdenEntrega >= 1),
    foreign key (NroEnvio)   references Envio(NroEnvio),
    foreign key (NroCliente) references Cliente(NroCliente),
    unique (NroEnvio, OrdenEntrega)
);

---------------------------------------------------------
-- tabla: InsumoLogistico
-----------------------------------------------------------
create table InsumoLogistico(
    CodigoInsumo char(5) not null primary key,
    Descripcion  varchar(20) not null,
    Stock        int not null check (Stock >= 0),
    Proveedor    varchar(50) not null
);

------------------------------------------------------------
-- tabla: PaqueteInsumo (relación N:N)
--------------------------------------------------------
create table PaqueteInsumo(
    IdPaquete    int not null,
    CodigoInsumo char(5) not null,
    primary key (IdPaquete, CodigoInsumo),
    foreign key (IdPaquete)    references Paquete(IdPaquete),
    foreign key (CodigoInsumo) references InsumoLogistico(CodigoInsumo)
);

---------------------------------------------------------
-- tabla: CompatibilidadInsumo (relación recursiva N:N)
------------------------------------------------------------
create table CompatibilidadInsumo(
    CodigoInsumo          char(5) not null,
    CodigoInsumoReemplazo char(5) not null,
    primary key (CodigoInsumo, CodigoInsumoReemplazo),
    foreign key (CodigoInsumo)          references InsumoLogistico(CodigoInsumo),
    foreign key (CodigoInsumoReemplazo) references InsumoLogistico(CodigoInsumo),
    check (CodigoInsumo <> CodigoInsumoReemplazo)
);

------------------------------------------------------------
-- tabla: RegistroSeguimiento
-------------------------------------------------------
create table RegistroSeguimiento(
    NroEnvio    int not null,
    NroLinea    int not null check (NroLinea >= 1),
    Fecha       date not null,
    Hora        time(0) not null,
    Descripcion varchar(100) not null,
    primary key (NroEnvio, NroLinea),
    foreign key (NroEnvio) references Envio(NroEnvio)
);