------------------------------------------------------------
-- DML / Insert
------------------------------------------------------------
use GlobalTransporteBD

------------------------------------------------------------
-- datos de TipoVehiculo
------------------------------------------------------------
insert into TipoVehiculo (CodigoTipoVehiculo, Descripcion) values
('CAM01', 'Camión'),
('FUR01', 'Furgón refrigerado'),
('CAM02', 'Camioneta');

------------------------------------------------------------
-- datos de Vehiculo
-- ids generados por identity: 1,2,3,4
------------------------------------------------------------
insert into Vehiculo
(Matricula, Descripcion, Marca, Modelo, AnioFabricacion, CapacidadCargaKg, ConsumoPromedioKm, CodigoTipoVehiculo)
values
('SAA1234', 'Camión grande',     'Volvo',    'FH',     2018, 20000, 0.35, 'CAM01'),
('SBB5678', 'Camión mediano',    'Scania',   'P',      2016, 15000, 0.32, 'CAM01'),
('SCC9012', 'Furgón frigorífico','Mercedes', 'Sprinter',2020, 3000,  0.18, 'FUR01'),
('SDD3456', 'Camioneta urbana',  'Ford',     'Ranger', 2019, 1000,  0.12, 'CAM02');

------------------------------------------------------------
-- datos de Chofer
-- choferes 4 y 5 no tendrán envíos (para probar consulta 5.4)
------------------------------------------------------------
insert into Chofer
(NroFuncionario, CI, Nombre, Apellido, FechaNacimiento, NroLicencia, Telefono, IdVehiculo)
values
(1, '4.111.111-1', 'Luis',  'Pérez',    '1985-03-10', 'LIC123', '099111111', 1),
(2, '4.222.222-2', 'Ana',   'García',   '1990-07-22', 'LIC234', '099222222', 1),
(3, '4.333.333-3', 'Mario', 'Suárez',   '1980-01-15', 'LIC345', '099333333', 2),
(4, '4.444.444-4', 'Lucía', 'Rodríguez','1995-11-05', 'LIC456', '099444444', 3),
(5, '4.555.555-5', 'Diego', 'Fernández','1992-09-18', 'LIC567', '099555555', null);

------------------------------------------------------------
-- datos de HabilidadEspecial
-- ids generados por identity: 1,2,3
------------------------------------------------------------
insert into HabilidadEspecial (Descripcion) values
('Carga peligrosa'),
('Transporte refrigerado'),
('Carga sobredimensionada');

------------------------------------------------------------
-- datos de ChoferHabilidad
------------------------------------------------------------
insert into ChoferHabilidad (NroFuncionario, IdHabilidad) values
(1, 1),
(1, 3),
(2, 1),
(3, 2),
(4, 2);


------------------------------------------------------------
-- datos de Cliente
-- cliente 4 sin envíos (para probar consulta 5.2)
------------------------------------------------------------
insert into Cliente
(NroCliente, RazonSocial, Direccion, Telefono, PaisOrigen)
values
(1, 'ACME Logistics', 'Av. Principal 123', '29010001', 'Uruguay'),
(2, 'LogiMax SA',     'Calle 8 Nro 456',   '29020002', 'Argentina'),
(3, 'TexCargo Ltda',  'Ruta 5 Km 30',      '29030003', 'Brasil'),
(4, 'SinEnvios SA',   'Ruta 1 Km 5',       '29040004', 'Chile');

------------------------------------------------------------
-- datos de Envio
-- ids generados por identity: 1..6
-- vehiculo 3 tendrá más envíos (para consulta 5.5)
------------------------------------------------------------
insert into Envio
(FechaSalida, HoraSalida, FechaFinEstimada, HoraFinEstimada, FechaFinReal, HoraFinReal, IdVehiculo)
values
('2025-10-01', '08:00', '2025-10-01', '18:00', '2025-10-01', '17:30', 1), -- envio 1
('2025-10-02', '09:00', '2025-10-02', '19:00', '2025-10-02', '19:15', 1), -- envio 2
('2025-10-03', '07:30', '2025-10-03', '16:00', '2025-10-03', '15:45', 2), -- envio 3
('2025-10-04', '10:00', '2025-10-04', '20:00', '2025-10-04', '20:10', 3), -- envio 4
('2025-10-05', '06:45', '2025-10-05', '14:00', '2025-10-05', '14:05', 3), -- envio 5
('2025-10-06', '11:15', '2025-10-06', '21:00', '2025-10-06', '20:50', 3); -- envio 6

------------------------------------------------------------
-- datos de AsignacionChoferEnvio
------------------------------------------------------------
insert into AsignacionChoferEnvio (NroEnvio, NroFuncionario) values
(1, 1),
(1, 2),
(2, 1),
(3, 3),
(4, 1),
(5, 2),
(6, 3);

------------------------------------------------------------
-- datos de Paquete
-- ids generados por identity: 1..8
------------------------------------------------------------
insert into Paquete
(Peso, Volumen, Descripcion, NroEnvio, NroCliente, OrdenEntrega)
values
(100.00, 1.50, 'Electrónica de consumo', 1, 1, 1),
(200.00, 3.00, 'Ropa y textiles',        1, 2, 2),

(150.00, 2.00, 'Repuestos de maquinaria', 2, 1, 1),

(80.00,  1.20, 'Insumos de oficina',      3, 2, 1),
(50.00,  0.80, 'Documentación',           3, 3, 2),

(300.00, 4.00, 'Alimentos no perecederos',4, 1, 1),

(120.00, 1.80, 'Componentes electrónicos',5, 3, 1),

(90.00,  1.00, 'Medicamentos',            6, 2, 1);

------------------------------------------------------------
-- datos de InsumoLogistico
------------------------------------------------------------
insert into InsumoLogistico
(CodigoInsumo, Descripcion, Stock, Proveedor)
values
('PAL01', 'Pallet estándar',    50,  'DepoSur'),
('PAL02', 'Pallet reforzado',   30,  'DepoSur'),
('CAJ01', 'Caja cartón grande', 200, 'Embalajes SA'),
('CAJ02', 'Caja cartón pequeña',300, 'Embalajes SA'),
('ENV01', 'Envoltorio frágil',  150, 'ProtectPack');

------------------------------------------------------------
-- datos de PaqueteInsumo
------------------------------------------------------------
insert into PaqueteInsumo (IdPaquete, CodigoInsumo) values
(1, 'PAL01'),
(1, 'CAJ01'),
(2, 'PAL01'),
(2, 'CAJ01'),
(3, 'PAL02'),
(3, 'CAJ01'),
(4, 'CAJ02'),
(4, 'ENV01'),
(5, 'CAJ02'),
(6, 'PAL02'),
(6, 'CAJ01'),
(7, 'PAL01'),
(7, 'ENV01'),
(8, 'CAJ02');

------------------------------------------------------------
-- datos de CompatibilidadInsumo
------------------------------------------------------------
insert into CompatibilidadInsumo (CodigoInsumo, CodigoInsumoReemplazo) values
('PAL01', 'PAL02'),
('PAL02', 'PAL01'),
('CAJ01', 'CAJ02'),
('CAJ02', 'CAJ01');

------------------------------------------------------------
-- datos de RegistroSeguimiento
------------------------------------------------------------
insert into RegistroSeguimiento
(NroEnvio, NroLinea, Fecha, Hora, Descripcion)
values
(1, 1, '2025-10-01', '08:05', 'Salida de depósito'),
(1, 2, '2025-10-01', '12:00', 'Arribo a centro de distribución'),
(1, 3, '2025-10-01', '17:30', 'Entrega finalizada'),

(2, 1, '2025-10-02', '09:10', 'Salida de depósito'),
(2, 2, '2025-10-02', '18:45', 'Entrega en curso'),
(2, 3, '2025-10-02', '19:15', 'Entrega finalizada'),

(3, 1, '2025-10-03', '07:40', 'Salida de depósito'),
(3, 2, '2025-10-03', '15:45', 'Entrega finalizada');
