-- top ten paises con más aeropuertos
select country_name, count(*) as n
from optd_por_public 
where location_type in ('A','CA')
group by country_name 
order by 2 desc
limit 10 ;


-- top ten aviones con más motores
select manufacturer, model, nb_engines
from optd_aircraft
where nb_engines is not null
order by nb_engines desc, manufacturer 
limit 10 ; 


-- número de aviones con 4 motores
select count(*)
from optd_aircraft 
where nb_engines = 4;


-- número medio de motores x compañia aerea
select manufacturer, avg(nb_engines) as n
from optd_aircraft 
where nb_engines is not null
group by manufacturer
order by n desc
limit 10 ;


-- los 10 aeropuertos más altos del mundo
select iata_code, name, country_name, elevation
from optd_por_public 
where elevation is not null and location_type in ('A','CA')
order by elevation desc
limit 10 ; 


-- las 10 ciudades más pobladas del mundo
select name, country_name, population 
from optd_por_public 
where location_type = 'C'
and population is not null
order by population desc 
limit 10 ;


-- los 10 paises más poblados
select country_name, sum(population) as n
from optd_por_public
where location_type = 'C'
and population is not null
order by n desc
limit 10 ;


-- aeropuertos por país
select country_name, count(*) as airports
from optd_por_public
where location_type in ('A','CA')
group by country_name ; 



-- número de aeropuertos x habitantes >>> tengo que hacer query multiple

select tabH.country_name, tabH.nPobl, tabAir.nAirp, 
CAST(1000*(tabAir.nAirp/tabH.nPobl) as float) as airpPC 
from
(select country_name, sum(population) as nPobl
from optd_por_public 
where location_type = 'C' and population is not null
group by country_name) as tabH , 
(select country_name, count(*) as nAirp
from optd_por_public 
where location_type in ('A','CA')
group by country_name) as tabAir
where tabH.country_name=tabAir.country_name 
and nPobl>0 and nAirp>0 ;


-- cada tabla a una vista
-- view1
create view Poblac as
select country_name, sum(population) as nPobl
from optd_por_public 
where location_type = 'C' and population is not null
group by country_name ;

--view2
create view Aerop as 
select country_name, count(*) as nAirp
from optd_por_public 
where location_type in ('A','CA')
group by country_name ;


-- query
select p.country_name, p.nPobl, a.nAirp, 
1000* CAST(a.nairp as float)/p.nPobl as AirporPC
from Poblac p, Aerop a
where p.country_name = a.country_name 
and p.nPobl>0 and a.nAirp>0
order by AirporPC desc
LIMIT 20;


-- otra forma de hacer la query con inner join
select p.country_name, p.nPobl, a.nAirp,
1000* CAST(a.nairp as float)/p.nPobl as AirporPC
from Poblac p
INNER JOIN Aerop a
ON p.country_name = a.country_name
where p.nPobl>0 and a.nAirp>0
order by AirporPC desc
LIMIT 20;


-- 

-- DIA2 >>> Sentencias múltiples

-- LEFT OUTER JOIN

-- ej1. todas las aerolineas con su número de vuelos

-- LEFT  >> maestro aerolineas
-- RIGHT >> vuelos por aerolineas


select L."2char_code", L.name, R.flight_freq
from optd_airlines as L
LEFT OUTER JOIN ref_airline_nb_of_flights as R
ON L."2char_code"= R.airline_code_2c ;



-- ej1. todas las aerolineas que han tenido vuelos con su Nombre

-- cambiamos el orden

-- LEFT  >> vuelos por aerolineas
-- RIGHT >> maestro aerolineas 

select R."2char_code", R.name, L.flight_freq
from ref_airline_nb_of_flights as L
LEFT OUTER JOIN optd_airlines as R
ON R."2char_code"= L.airline_code_2c ;



-- Subselects

-- Ciudades con elevación por debajo de la media de elevación

select name, country_name, elevation
from optd_por_public 
where location_type = 'C'
and elevation > (select avg(elevation) from optd_por_public where location_type = 'C' and elevation is not null) ;


-- Cuantas ciudades x país están por encima de la media de elevación

select country_name, count(*)
from optd_por_public 
where location_type = 'C'
and elevation > (select avg(elevation) from optd_por_public where location_type = 'C' and elevation is not null) 
group by country_name ;

-- la misma de antes pero muestra sólo los países con más de 3 ciudades por encima de la media

select country_name, count(*)
from optd_por_public 
where location_type = 'C'
and elevation > (select avg(elevation) from optd_por_public where location_type = 'C' and elevation is not null) 
group by country_name 
HAVING COUNT(*) >= 3;


-- ciudades x encima de la media de elevación del País
select A.country_code, A.country_name, A.name, A.elevation, B.elevMediaPais
from optd_por_public A, 
(select country_code, country_name, round(avg(elevation),2) as elevMediaPais
from optd_por_public 
where location_type = 'C' and elevation is not null
group by country_code, country_name) B
where A.country_code = B.country_code
and A.location_type = 'C'
and A.elevation > B.elevMediaPais
order by 2, 4 desc ;



--- EJERCICIO TIENDA INFORMATICA

CREATE TABLE FABRICANTE (
codigo INT PRIMARY KEY, 
nombre VARCHAR ) ;

CREATE TABLE ARTICULO (
codigo INT PRIMARY KEY, 
nombre VARCHAR, 
precio FLOAT,
fabricante INT REFERENCES fabricante(codigo)) ;

insert into FABRICANTE values ( 1, 'DANONE' ) ;
insert into FABRICANTE values ( 2, 'TRIDENT' ) ;
insert into FABRICANTE values ( 3, 'COCA COLA' ) ;
insert into FABRICANTE values ( 4, 'PROCUBITOS' ) ;


insert into articulo values ( 1, 'YOGURT', 0.25, 1 ) ;
insert into articulo values ( 2, 'NATILLAS', 0.45, 1 ) ;
insert into articulo values ( 3, 'LEJIA', 0.8 ) ;
insert into articulo values ( 4, 'CUADERNO',2.2 ) ;
insert into articulo values ( 5, 'CHICLE',1,2 ) ;
insert into articulo values ( 6, 'LATA COCA-COLA',0.56,3 ) ;





select nombre, precio 
from ARTICULO ;

select distinct f.nombre 
from FABRICANTE F, ARTICULO A
where a.codigo = f.fabricante
  and a.precio between 60 and 200 ;

select f.nombre, a.nombre, a.precio
from FABRICANTE F, ARTICULO A
where f.codigo = a.fabricante
  and a.precio between 60 and 200 ;

select avg(precio)
from ARTICULO ;

select count(*)
from ARTICULO
where precio > 180 ;

select *
from ARTICULO
order by precio ASC 
LIMIT 5 ;

select f.nombre, a.nombre, a.precio
from FABRICANTE F, ARTICULO A
where f.codigo = a.fabricante ;

select f.nombre, AVG(a.precio)
from FABRICANTE F, ARTICULO A
where f.codigo = a.fabricante
GROUP BY f.codigo ;











