-- un procedimiento es un conjunto de instrucciones que se ejecutan en un orden determinado
-- se pueden pasar parametros a un procedimiento
-- se pueden retornar valores de un procedimiento

--ejemplos
create procedure SelectAll
as
select * from person.Address
go;

--para ejecutar el procedimiento
execute SelectAll

--con parametros
create procedure SelectAddressP (@City nvarchar(30))
as
select * from person.Address where City = @City
go;
--
exec SelectAddressP @City='New York'


