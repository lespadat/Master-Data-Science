-- Script para pruebas sesion SQL (2015-11-20)

-- borra si existe
DROP TABLE IF EXISTS amigos ;

-- crea la tabla
CREATE TABLE amigos (
    nombre VARCHAR, 
    edad INT, 
    email VARCHAR) ;

-- inserta algunos registros    
INSERT INTO amigos VALUES ( 'Leo Messi', 28, 'leomessi@pulga.com' ) ;
INSERT INTO amigos VALUES ( 'Cristiano Ronaldo', 30, 'CR7@bicho.pt' ) ;




