--trigger (disparadores) son un tipo especial de procedimientos que se ejecutan automaticamente 
--cuando se produce un evento en una tabla
--no puede ser llamado por un usuario
--no se puede pasar parametros
--no se puede retornar valores
--existen tres tipos
--DML data manipulation language, se ejecuta cuando se inserta, actualiza o elimina un registro
--DDL data definition language, se ejecuta cuando se crea, altera o elimina una tabla
--LOGON se ejecuta cuando un usuario se conecta a la base de datos

--ejemplos
--DML
CREATE OR REPLACE TRIGGER trigger_insert
AFTER insert
as insert into (select top 1 id from Table_parent)
go

CREATE  TRIGGER prevent
ON AdventureWork2016
FOR UPDATE
AS
BEGIN
print 'no puedes inserta, actualizar o eliminar esto';
rollback;
END;


CREATE TRIGGER iniciosesion
ON LOGON
AS
BEGIN
	print 'un usuario se a logeado'
END;
