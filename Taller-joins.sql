--TALLER DE JOIN

--
select * from produccion.tbUbigeo

select * from produccion.tbEmprendimiento

select * from produccion.tbActividadEconomica

select * from produccion.tbEmprendimientoActividad

--P1
--CROSS JOIN - PRODUCTO CARTESIANO -No se especifica ON (COLUMNA EN COMÚN)
select e.id,ae.ciiu
from 
produccion.tbEmprendimiento as e cross join--TI
produccion.tbActividadEconomica as ae--TD

select count(1) from produccion.tbEmprendimiento --22
select count(1) from DevWifiDB.dbo.PlanWifi --6

select e.id,p.nombre
from 
EmpresasDB.produccion.tbEmprendimiento as e cross join--TI
DevWifiDB.dbo.PlanWifi as p --132

--P2
select e.ruc,e.razonsocial,u.departamento,u.provincia,u.distrito from
produccion.tbEmprendimiento as e inner join      --TI (FK-idubigeo)
produccion.tbUbigeo as u on e.idubigeo=u.id      --TD (PK-id)
where u.departamento='AMAZONAS' --Filtrar los emprendimientos por departamento

select e.ruc,e.razonsocial,u.departamento,u.provincia,u.distrito from
produccion.tbEmprendimiento as e inner join      --TI (FK-idubigeo)
produccion.tbUbigeo as u on e.idubigeo=u.id and u.departamento='AMAZONAS'     --TD (PK-id)

--P3

select ea.ciiu,ea.idemprendimiento,
e.ruc,
substring(e.ruc,1,2) as iruc,--Extraer una porción de cadena, desde la posición 1, 2 caracteres
e.razonsocial,e.fecinicio 
from
produccion.tbEmprendimientoActividad ea inner join--TI
produccion.tbEmprendimiento e on ea.idemprendimiento=e.id          --TD
where ea.ciiu like '1%' --todos los ciiu que inician en 1,% no importa los caracteres que vengan hacia derecha.
order by ea.ciiu,ea.idemprendimiento,e.fecinicio --Ordenamiento 1° nivel ciiu, 2° nivel idemprendimiento

--P4
select ea.ciiu,ea.idemprendimiento,isnull(e.ruc,'-') as ruc, --e.ruc es desconocido=> mostrar '-'
isnull(e.razonsocial,'-') as razonsocial,isnull(e.fecinicio,'9999-12-31') as fecfinicio
from
produccion.tbEmprendimientoActividad ea left join--TI (PREVALECE)
produccion.tbEmprendimiento e on ea.idemprendimiento=e.id          --TD
where ea.ciiu like '9%' --todos las relaciones con ciiu que inician en 9
order by ea.ciiu,ea.idemprendimiento --Ordenamiento 1° nivel ciiu, 2° nivel idemprendimiento

select ea.ciiu,ea.idemprendimiento,isnull(e.ruc,'-') as ruc, --e.ruc es desconocido=> mostrar '-'
isnull(e.razonsocial,'-') as razonsocial,isnull(e.fecinicio,'9999-12-31') as fecfinicio
from
produccion.tbEmprendimientoActividad ea left join--TI (PREVALECE)
produccion.tbEmprendimiento e on ea.idemprendimiento=e.id and ea.ciiu like '9%'--TD Hacer cruce sólo con ciiu que inicia en 9
order by ea.ciiu,ea.idemprendimiento --Ordenamiento 1° nivel ciiu, 2° nivel idemprendimiento

--P6

select isnull(a.descripcion,'-') as actividad,ea.ciiu,ea.idemprendimiento  from
produccion.tbActividadEconomica as a right join      --TI
produccion.tbEmprendimientoActividad as ea on a.ciiu=ea.ciiu--TD (PREVALECE)
where ea.ciiu like '9%' --todos las relaciones con ciiu que inician en 9

select isnull(a.descripcion,'-') as actividad,ea.ciiu,ea.idemprendimiento  from
produccion.tbActividadEconomica as a right join      --TI
produccion.tbEmprendimientoActividad as ea on a.ciiu=ea.ciiu and ea.ciiu like '9%'--TD (PREVALECE)

select * from produccion.tbEmprendimientoActividad where ciiu='9991' and idemprendimiento=99
select * from produccion.tbActividadEconomica where ciiu='9991'
select * from produccion.tbEmprendimiento where id=99

--P7
--304
select isnull(ea.ciiu,'-') as ciiu,
isnull(ea.idemprendimiento,'-') as idempresa,isnull(e.ruc,'-') as ruc, --e.ruc es desconocido=> mostrar '-'
isnull(e.razonsocial,'-') as razonsocial,isnull(e.fecinicio,'9999-12-31') as fecfinicio
from
produccion.tbEmprendimientoActividad ea full outer join--TI 
produccion.tbEmprendimiento e on ea.idemprendimiento=e.id          --TD
order by ea.ciiu,ea.idemprendimiento --Ordenamiento 1° nivel ciiu, 2° nivel idemprendimiento

--LEFT JOIN
select isnull(ea.ciiu,'-') as ciiu,
isnull(ea.idemprendimiento,'-') as idempresa,isnull(e.ruc,'-') as ruc, --e.ruc es desconocido=> mostrar '-'
isnull(e.razonsocial,'-') as razonsocial,isnull(e.fecinicio,'9999-12-31') as fecfinicio
from
produccion.tbEmprendimientoActividad ea left join--TI 
produccion.tbEmprendimiento e on ea.idemprendimiento=e.id          --TD
union 
--RIGHT JOIN
select isnull(ea.ciiu,'-') as ciiu,
isnull(ea.idemprendimiento,'-') as idempresa,isnull(e.ruc,'-') as ruc, --e.ruc es desconocido=> mostrar '-'
isnull(e.razonsocial,'-') as razonsocial,isnull(e.fecinicio,'9999-12-31') as fecfinicio
from
produccion.tbEmprendimientoActividad ea right join--TI 
produccion.tbEmprendimiento e on ea.idemprendimiento=e.id          --TD

