------------------------------------------------------------
-- DQL / Consultas
------------------------------------------------------------

use GlobalTransporteBD

------------------------------------------------------------
-- 5.1 listar cada cliente con la cantidad total de envíos
--     que ha realizado (solo clientes con envíos)
------------------------------------------------------------
select  c.NroCliente,
        c.RazonSocial,
        count(distinct p.NroEnvio) as CantidadEnvios
from Cliente c, Paquete p
where c.NroCliente = p.NroCliente
group by c.NroCliente, c.RazonSocial

------------------------------------------------------------
-- 5.2 mostrar todos los clientes y la cantidad de envíos
--     (incluye clientes con 0 envíos)
------------------------------------------------------------
select  c.NroCliente,
        c.RazonSocial,
        (select count(distinct p.NroEnvio)
         from Paquete p
         where p.NroCliente = c.NroCliente) as CantidadEnvios
from Cliente c
order by c.NroCliente

------------------------------------------------------------
-- 5.3 calcular el peso promedio de los paquetes
--     transportados por cada vehículo
------------------------------------------------------------
select  v.IdVehiculo,
        v.Matricula,
        avg(p.Peso) as PesoPromedio
from Vehiculo v, Envio e, Paquete p
where v.IdVehiculo = e.IdVehiculo
and   e.NroEnvio = p.NroEnvio
group by v.IdVehiculo, v.Matricula

------------------------------------------------------------
-- 5.4 listar los choferes que existen en la empresa
--     pero que nunca participaron en ningún envío
------------------------------------------------------------
select  NroFuncionario,
        CI,
        Nombre,
        Apellido,
        FechaNacimiento,
        NroLicencia,
        Telefono,
        IdVehiculo
from Chofer
where NroFuncionario not in (
    select distinct NroFuncionario
    from AsignacionChoferEnvio
)

------------------------------------------------------------
-- 5.5 obtener el vehículo con mayor cantidad de envíos realizados
--     (si hay empate, muestra todos)
------------------------------------------------------------
select  v.IdVehiculo,
        v.Matricula,
        count(*) as CantidadEnvios
from Vehiculo v, Envio e
where v.IdVehiculo = e.IdVehiculo
group by v.IdVehiculo, v.Matricula
having count(*) = (
    select max(cantEnvios)
    from (
        select IdVehiculo, count(*) as cantEnvios
        from Envio
        group by IdVehiculo
    ) as x
)

------------------------------------------------------------
-- 5.6 listar cada insumo junto con la descripción de los
--     insumos que son compatibles con él
------------------------------------------------------------
select  i.CodigoInsumo,
        i.Descripcion as DescripcionInsumo,
        ic.CodigoInsumoReemplazo,
        i2.Descripcion as DescripcionCompatible
from InsumoLogistico i
left join CompatibilidadInsumo ic
    on i.CodigoInsumo = ic.CodigoInsumo
left join InsumoLogistico i2
    on ic.CodigoInsumoReemplazo = i2.CodigoInsumo
order by i.CodigoInsumo, ic.CodigoInsumoReemplazo

------------------------------------------------------------
-- 5.7 modificar la tabla de insumos para agregar el stock
--     disponible e inicializarlo en 100 para todos
------------------------------------------------------------
alter table InsumoLogistico
add StockDisponible int

update InsumoLogistico
set StockDisponible = 100

select * from InsumoLogistico
 