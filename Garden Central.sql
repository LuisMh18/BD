use garden;
select * from usuario order by id desc;
select * from rol;
select * from usuario_detalle order by id desc;
show tables;
select * from cliente;
desc usuario_detalle;
desc usuario;

drop table usuario_detalle;
CREATE TABLE usuario_detalle (
  id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  usuario_id int(11) not null,
  nombre varchar(200) NOT NULL,
  created_at datetime DEFAULT CURRENT_TIMESTAMP,
  updated_at datetime DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE RESTRICT ON UPDATE restrict 
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

/* inner join y join es lo mismo, es la union de las tablas donde coinciden los datos
 * que estamos agregando */
select * from usuario
join rol on usuario.rol_id = rol.id;

select * from usuario 
left join rol on usuario.rol_id = rol.id;

select * from usuario 
left join rol on usuario.rol_id = rol.id;

select * from usuario 
left join usuario_detalle on usuario_detalle.rol_id = rol.id;

select * from usuario 
right join rol on usuario.rol_id = rol.id;

create or replace view vh_usuario as 
select us.id, us.rol_id, rol.nombre as nombreRol, us.usuario, us.password, us.email,
cli.usuario_id, cli.nombre_cliente, cli.materno, cli.paterno 
from usuario us
left join cliente cli on cli.usuario_id  = us.id 
left join rol on rol.id  = us.rol_id 
order by us.id desc;

select * from vh_usuario where nombre_cliente is not null;

select * from almacen order by id desc;

desc almacen;

drop table menu;
CREATE TABLE menu (
  id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  nombre varchar(200) DEFAULT NULL,
  orden int(10) default null,
  created_at datetime DEFAULT CURRENT_TIMESTAMP,
  updated_at datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


INSERT INTO menu 
(id, nombre, orden) 
VALUES 
(1, "Catálogos", 2),
(2, "Consultas", 3),
(3, "Páginas", 4),
(4, "Movimientos", 5),
(5, "Entradas", 6),
(6, "Inventario", 7),
(7, "Dashboard", 1);

alter table menu add ruta varchar(200) default null after nombre;
alter table menu add icono varchar(200) default null after ruta;
update menu set ruta = "/admin/dashboard", icono="bi bi-display-fill" where id = 7;
update menu set icono="bi bi-bookmark" where id = 1;
update menu set icono="bi bi-search" where id = 2;
update menu set icono="bi bi-book-half" where id = 3;
update menu set icono="bi bi-arrow-left-right" where id = 4;
update menu set icono="bi bi-shuffle" where id = 5;
update menu set icono="bi bi-tools" where id = 6;

select * from vh_menu;

select * from menu order by orden asc;
select * from menu where id in(2,3);

select * from submenu where menu_id = 2;

drop table submenu;
CREATE TABLE submenu (
  id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  nombre varchar(200) NOT NULL,
  ruta varchar(200) default null,
  icono varchar(200) default null,
  orden int(10) default null,
  menu_id int(11) NOT null,
  created_at datetime DEFAULT CURRENT_TIMESTAMP,
  updated_at datetime DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (menu_id) REFERENCES menu(id) ON DELETE RESTRICT ON UPDATE restrict 
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


INSERT INTO submenu 
(id, nombre, ruta, icono, orden, menu_id) 
VALUES 
(1, "Almacen", "/admin/almacen", "bi bi-clipboard2-fill", 1, 1),
(2, "Categorías", "/admin/categorias", "bi bi-collection-fill", 2, 1),
(3, "Usuarios", "/admin/usuarios", "bi bi-file-person", 17, 1),
(4, "Unidad medida", "/admin/unidad_medida", "bi bi-square-fill", 16, 1),
(5, "Rol", "/admin/rol", "bi bi-steam", 15, 1),
(6, "Proveedor", "/admin/proveedor", "bi bi-person-fill", 14, 1),
(7, "Producto", "/admin/producto", "bi bi-square-fill", 13, 1),
(8, "Clientes", "/admin/clientes", "bi bi-people", 3, 1),
(9, "Comercializador", "/admin/comercializador", "bi bi-person-rolodex", 4, 1),
(10, "Estados", "/admin/estados", "bi bi-square-fill", 5, 1),
(11, "Familias", "/admin/familias", "bi bi-square-fill", 6, 1),
(12, "Formas de pago", "/admin/formas_de_pago", "bi bi-square-fill",  7, 1),
(13, "Importador","/admin/importador", "bi bi-person-square", 8, 1),
(14, "Mensajeria", "/admin/mensajeria", "bi bi-file-text", 9, 1),
(15, "Municipio", "/admin/municipio", "bi bi-square-fill", 10, 1),
(16, "Nivel de descuento", "/admin/nivel_descuento", "bi bi-square-fill", 11, 1),
(17, "País", "/admin/pais", "bi bi-square-fill", 12, 1);

INSERT INTO submenu 
(id, nombre, ruta, icono, orden, menu_id) 
VALUES 
(18, "Consultas", "/admin/consultas", "bi bi-search", 18, 2),
(19, "Movimientos", "/admin/movimientos", "bi bi-shuffle", 19, 2),
(20, "Estatus", "/admin/estatus", "bi bi-square", 20, 2);

INSERT INTO submenu 
(id, nombre, ruta, icono, orden, menu_id) 
VALUES 
(21, "Términos y condiciones", "/admin/terminos", "bi bi-chat-text-fill", 21, 3),
(22, "Notas", "/admin/notas", "bi bi-file-text-fill", 22, 3);

INSERT INTO submenu 
(id, nombre, ruta, icono, orden, menu_id) 
VALUES 
(23, "Consultas", "/admin/inventario", "bi bi-clipboard2-fill", 23, 6);

INSERT INTO submenu 
(id, nombre, ruta, icono, orden, menu_id) 
VALUES 
(24, "Agregar", "/admin/movimientos", "bi bi-shuffle", 24, 4),
(25, "Nueva Entrada", "/admin/entradas", "bi bi-arrow-right-circle", 24, 5);

select * from submenu where menu_id = 1 order by orden asc;
select * from submenu where menu_id = 2 order by orden asc;
select * from submenu order by orden asc;

select * from submenu where menu_id = 1;


create or replace view vh_menu as
select
     menu.id as id, menu.nombre, menu.ruta, menu.icono, menu.orden, menu.created_at,
     (select group_concat(submenu.nombre,'-',submenu.ruta separator ' ,') 
           from submenu where submenu.menu_id = menu.id 
           order by submenu.orden asc) as Submenu
from
    menu
order by menu.orden asc;

select * from almacen WHERE DATE(created_at) BETWEEN '2015-11-30 00:00:00' AND '2022-04-11 23:59:59';
select * from almacen WHERE DATE(created_at) BETWEEN '2022-04-11 00:00:00' AND '2022-04-15 23:59:59';

SELECT * FROM almacen WHERE DATE(created_at) BETWEEN '2015-11-30 00:00:00' AND '2015-11-30 23:59:59' AND '2022-04-11 23:59:59';

SELECT * FROM almacen order by id DESC limit 0, 10;
SELECT * FROM almacen order by id DESC limit 10, 10;
SELECT * FROM almacen order by id DESC limit 21, 10;

SELECT * FROM almacen order by id desc;

SELECT * FROM almacen
LIMIT 15,15

select * from vh_menu;

select * from almacen;

select * from almacen where clave like lcase("%ac%") and nombre like lcase("%Al%");

SELECT * FROM almacen WHERE clave="prueba" and nombre="prueba" and estatus=0;

SELECT * FROM almacen WHERE clave like lcase("%pru%") and nombre like lcase("%prueba%") and estatus=0;

select * from almacen order by id asc limit 1, 4;

SELECT * FROM almacen WHERE clave like lcase("%pru%") 
            and nombre like lcase("%prueba%") and estatus=0 limit 1, 15;
           
 SELECT * FROM almacen order by id desc limit 0, 10;

select * from producto;
select * from inventario_detalle;

create or replace view vh_inventario as
select inventario_detalle.id as id, producto.id as idProducto, producto.clave, producto.nombre, producto.color, producto.foto, 
       concat("/img/productos/", producto.foto) as ruta_imagen,
      inventario_detalle.cantidad, inventario_detalle.num_pedimento,
  	  inventario_detalle.created_at
  from  producto
  join inventario_detalle on inventario_detalle.producto_id = producto.id;
 
 select * from vh_inventario;
SELECT * FROM vh_inventario order by id desc limit 0, 10;
 SELECT * FROM vh_inventario order by id desc limit 1, 10;
SELECT * FROM vh_inventario order by id desc limit 11, 20;
SELECT * FROM vh_inventario order by id desc limit 71, 80;
SELECT * FROM vh_inventario order by id desc limit 0, 50;
SELECT * FROM vh_inventario order by id desc limit 51, 100;

select * from usuario order by id desc;
desc usuario;
select * from rol;
select * from cliente;
select * from almacen;

CREATE TABLE cat_estatus (
  id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  estatus varchar(50) NOT NULL,
  created_at datetime DEFAULT CURRENT_TIMESTAMP,
  updated_at datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO cat_estatus 
(estatus) 
VALUES 
("Activo"),
("Inactivo");

select * from cat_estatus;

alter table usuario DROP COLUMN remember_token;

select count(*) as total from vh_inventario;
SELECT * FROM vh_inventario WHERE clave like lcase("%ah003%") order by id desc limit 0, 50;
select * from usuario;
SELECT * FROM almacen order by id asc;

select count(*) as total from vh_inventario;

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'nombre' AND TABLE_NAME = 'almacen';

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME = 'pepe' AND TABLE_NAME = 'almacen';

select * from pedido where DATE(fecha_registro) = "2016-05-31";
select * from pedido where DATE(fecha_registro) = "2016-05-24";
/*-------------------------------------------------------------------------------*/
/*Total de pedidos del día*/
select count(*) as totalPedidosPorDia from pedido where DATE(fecha_registro) = "2016-05-24";
/*Total de pedidos pagados del día*/
select count(*) as totalPedidosPagadosPorDia from pedido where DATE(fecha_registro) = "2016-05-24" and estatus = 2;
/*Total de pedidos a credito del día*/
select count(*) as totalPedidosCreditoPorDia from pedido where DATE(fecha_registro) = "2016-05-24" and estatus = 1;
/*Total de pedidos pendientes del día*/
select count(*) as totalPedidosPendientesPorDia from pedido where DATE(fecha_registro) = "2016-05-24" and estatus = 0;
/*Total de pedidos cancelados del día*/
select count(*) as totalPedidosCanceladosPorDia from pedido where DATE(fecha_registro) = "2016-05-24" and estatus = 3;
/*-------------------------------------------------------------------------------*/
/*Total de dinero de todos los pedidos del día*/
select sum(total) as totalPedidosDineroPorDia from pedido where DATE(fecha_registro) = "2016-05-24";
/*Total de dinero de todos los pedidos pagados del día*/
select sum(total) as totalPedidosDineroPagadosPorDia from pedido where DATE(fecha_registro) = "2016-05-24" and estatus = 2;
/*Total de dinero de todos los pedidos a credito del día*/
select sum(total) as totalPedidosDineroCreditoPorDia from pedido where DATE(fecha_registro) = "2016-05-24" and estatus = 1;
/*Total de dinero de todos los pedidos pendientes del día*/
select sum(total) as totalPedidosDineroPendientesPorDia from pedido where DATE(fecha_registro) = "2016-05-24" and estatus = 0;
/*Total de dinero de todos los pedidos cancelados del día*/
select sum(total) as totalPedidosDineroCanceladosPorDia from pedido where DATE(fecha_registro) = "2016-05-24" and estatus = 3;
/*-------------------------------------------------------------------------------*/
/*Total de pedidos del mes*/ MONTH(colfecha) = 10 AND YEAR(colfecha) = 2016
select count(*) as totalPedidosPorMes from pedido where MONTH(fecha_registro) = "05" and YEAR(fecha_registro) = "2016";
/*Total de pedidos pagados del día*/
select count(*) as totalPedidosPagadosPorMes from pedido where MONTH(fecha_registro) = "05" and YEAR(fecha_registro) = "2016" and estatus = 2;
/*Total de pedidos a credito del día*/
select count(*) as totalPedidosCreditoPorMes from pedido where MONTH(fecha_registro) = "05" and YEAR(fecha_registro) = "2016" and estatus = 1;
/*Total de pedidos pendientes del día*/
select count(*) as totalPedidosPendientesPorMes from pedido where MONTH(fecha_registro) = "05" and YEAR(fecha_registro) = "2016" and estatus = 0;
/*Total de pedidos cancelados del día*/
select count(*) as totalPedidosCanceladosPorMes from pedido where MONTH(fecha_registro) = "05" and YEAR(fecha_registro) = "2016" and estatus = 3;
/*-------------------------------------------------------------------------------*/
/*Total de dinero de todos los pedidos del mes*/
select sum(total) as totalPedidosDineroPorDia from pedido where MONTH(fecha_registro) = "05";
/*Total de dinero de todos los pedidos pagados del día*/
select sum(total) as totalPedidosDineroPagadosPorDia from pedido where MONTH(fecha_registro) = "05" and estatus = 2;
/*Total de dinero de todos los pedidos a credito del día*/
select sum(total) as totalPedidosDineroCreditoPorDia from pedido where MONTH(fecha_registro) = "05" and estatus = 1;
/*Total de dinero de todos los pedidos pendientes del día*/
select sum(total) as totalPedidosDineroPendientesPorDia from pedido where MONTH(fecha_registro) = "05" and estatus = 0;
/*Total de dinero de todos los pedidos cancelados del día*/
select sum(total) as totalPedidosDineroCanceladosPorDia from pedido where MONTH(fecha_registro) = "05" and estatus = 3;
/*-------------------------------------------------------------------------------*/

/*Total de pedidos del año*/
select count(*) as totalPedidosPorAnio from pedido where YEAR(fecha_registro) = "2016";
/*Total de pedidos pagados del día*/
select count(*) as totalPedidosPagadosPorAnio from pedido where YEAR(fecha_registro) = "2016" and estatus = 2;
/*Total de pedidos a credito del día*/
select count(*) as totalPedidosCreditoPorAnio from pedido where YEAR(fecha_registro) = "2016" and estatus = 1;
/*Total de pedidos pendientes del día*/
select count(*) as totalPedidosPendientesPorAnio from pedido where YEAR(fecha_registro) = "2016" and estatus = 0;
/*Total de pedidos cancelados del día*/
select count(*) as totalPedidosCanceladosPorAnio from pedido where YEAR(fecha_registro) = "2016" and estatus = 3;
/*-------------------------------------------------------------------------------*/
/*Total de dinero de todos los pedidos del año*/
select sum(total) as totalPedidosDineroPorAnio from pedido where YEAR(fecha_registro) = "2016";
/*Total de dinero de todos los pedidos pagados del año*/
select sum(total) as totalPedidosDineroPagadosPorAnio from pedido where YEAR(fecha_registro) = "2016" and estatus = 2;
/*Total de dinero de todos los pedidos a credito del año*/
select sum(total) as totalPedidosDineroCreditoPorAnio from pedido where YEAR(fecha_registro) = "2016" and estatus = 1;
/*Total de dinero de todos los pedidos pendientes del año*/
select sum(total) as totalPedidosDineroPendientesPorAnio from pedido where YEAR(fecha_registro) = "2016" and estatus = 0;
/*Total de dinero de todos los pedidos cancelados del año*/
select sum(total) as totalPedidosDineroCanceladosPorAnio from pedido where YEAR(fecha_registro) = "2016" and estatus = 3;
/*-------------------------------------------------------------------------------*/
/*Total de pedidos por periodo*/
select count(*) as totalPedidosPorPeriodo from pedido where DATE(fecha_registro) between '2015-11-30 00:00:00' AND '2022-04-11 23:59:59';
/*Total de pedidos pagados del día*/
select count(*) as totalPedidosPagadosPorPeriodo from pedido where DATE(fecha_registro) between '2015-11-30 00:00:00' AND '2022-04-11 23:59:59' and estatus = 2;
/*Total de pedidos a credito del día*/
select count(*) as totalPedidosCreditoPorPeriodo from pedido where DATE(fecha_registro) between '2015-11-30 00:00:00' AND '2022-04-11 23:59:59' and estatus = 1;
/*Total de pedidos pendientes del día*/
select count(*) as totalPedidosPendientesPorPeriodo from pedido where DATE(fecha_registro) between '2015-11-30 00:00:00' AND '2022-04-11 23:59:59' and estatus = 0;
/*Total de pedidos cancelados del día*/
select count(*) as totalPedidosCanceladosPorPeriodo from pedido where DATE(fecha_registro) between '2015-11-30 00:00:00' AND '2022-04-11 23:59:59' and estatus = 3;
/*-------------------------------------------------------------------------------*/
/*Total de dinero de pedidos por periodo*/
select sum(total) as totalPedidosDineroPorPeriodo from pedido where DATE(fecha_registro) between '2015-11-30 00:00:00' AND '2022-04-11 23:59:59';
/*Total de pedidos pagados del día*/
select sum(total) as totalPedidosDineroPagadosPorPeriodo from pedido where DATE(fecha_registro) between '2015-11-30 00:00:00' AND '2022-04-11 23:59:59' and estatus = 2;
/*Total de pedidos a credito del día*/
select sum(total) as totalPedidosDineroCreditoPorPeriodo from pedido where DATE(fecha_registro) between '2015-11-30 00:00:00' AND '2022-04-11 23:59:59' and estatus = 1;
/*Total de pedidos pendientes del día*/
select sum(total) as totalPedidosDineroPendientesPorPeriodo from pedido where DATE(fecha_registro) between '2015-11-30 00:00:00' AND '2022-04-11 23:59:59' and estatus = 0;
/*Total de pedidos cancelados del día*/
select sum(total) as totalPedidosDineroCanceladosPorPeriodo from pedido where DATE(fecha_registro) between '2015-11-30 00:00:00' AND '2022-04-11 23:59:59' and estatus = 3;
/*-------------------------------------------------------------------------------*/
select * from pedido;
drop procedure obtenerPedidosporCliente;

CREATE PROCEDURE obtenerPedidosporCliente(IN id int(10), in tipo varchar(50) )
begin
	
        if (tipo = "dia") then
	        SELECT * FROM pedido WHERE cliente_id = id;
	    elseif (tipo = "mes") then
	        SELECT * FROM pedido WHERE cliente_id = id limit 2;
	    end if;
    
end

CALL obtenerPedidosporCliente(86, "mes");

drop procedure test;
CREATE PROCEDURE test () 
BEGIN
SELECT 
   ( select sum(id) from usuario ) as Usuarios ,
   ( select sum(total) from pedido) as Pedidos 
   ;
END

call test();

/*Procedimiento almacenado para obtener los totales de pedidos*/
drop procedure obtenerPedidosporFecha;
CREATE PROCEDURE obtenerPedidosporFecha(
    IN anio varchar(10), 
    IN mes varchar(10), 
    IN dia varchar(10), 
    in fechaFin varchar(50),
    in tipo varchar(50) 
)
begin
	
        if (tipo = "dia") then
	        /*-------------------------------------------------------------------------------*/
		/*Total de pedidos del día*/
        select 
			(select count(*) from pedido where DATE(fecha_registro) = group_concat(anio,'-',mes,'-',dia)) as totalPedidos,
			/*Total de pedidos pagados del día*/
			(select count(*) from pedido where DATE(fecha_registro) = group_concat(anio,'-',mes,'-',dia) and estatus = 2) as totalPedidosPagados,
			/*Total de pedidos a credito del día*/
			(select count(*) from pedido where DATE(fecha_registro) = group_concat(anio,'-',mes,'-',dia) and estatus = 1) as totalPedidosCredito,
			/*Total de pedidos pendientes del día*/
			(select count(*) from pedido where DATE(fecha_registro) = group_concat(anio,'-',mes,'-',dia) and estatus = 0) as totalPedidosPendientes,
			/*Total de pedidos cancelados del día*/
			(select count(*) from pedido where DATE(fecha_registro) = group_concat(anio,'-',mes,'-',dia) and estatus = 3) as totalPedidosCancelados,
			
		/*-------------------------------------------------------------------------------*/
		/*Total de dinero de todos los pedidos del día*/
			(select sum(total) from pedido where DATE(fecha_registro) = group_concat(anio,'-',mes,'-',dia)) as totalPedidosDineroPorDia,
			/*Total de dinero de todos los pedidos pagados del día*/
			(select sum(total) from pedido where DATE(fecha_registro) = group_concat(anio,'-',mes,'-',dia) and estatus = 2) as totalPedidosDineroPagados,
			/*Total de dinero de todos los pedidos a credito del día*/
			(select sum(total) from pedido where DATE(fecha_registro) = group_concat(anio,'-',mes,'-',dia) and estatus = 1) as totalPedidosDineroCredito,
			/*Total de dinero de todos los pedidos pendientes del día*/
			(select sum(total) from pedido where DATE(fecha_registro) = group_concat(anio,'-',mes,'-',dia) and estatus = 0) as totalPedidosDineroPendientes,
			/*Total de dinero de todos los pedidos cancelados del día*/
			(select sum(total) from pedido where DATE(fecha_registro) = group_concat(anio,'-',mes,'-',dia) and estatus = 3) as totalPedidosDineroCancelados
		
		;
	    elseif (tipo = "mes") then
	        /*Total de pedidos por año y mes*/
	    select
			(select count(*) from pedido where MONTH(fecha_registro) = mes and YEAR(fecha_registro) = anio) as totalPedidos,
			/*Total de pedidos pagados del día*/
			(select count(*) from pedido where MONTH(fecha_registro) = mes and YEAR(fecha_registro) = anio and estatus = 2) as totalPedidosPagados,
			/*Total de pedidos a credito del día*/
			(select count(*) from pedido where MONTH(fecha_registro) = mes and YEAR(fecha_registro) = anio and estatus = 1) as totalPedidosCredito,
			/*Total de pedidos pendientes del día*/
			(select count(*) from pedido where MONTH(fecha_registro) = mes and YEAR(fecha_registro) = anio and estatus = 0) as totalPedidosPendientes,
			/*Total de pedidos cancelados del día*/
			(select count(*) from pedido where MONTH(fecha_registro) = mes and YEAR(fecha_registro) = anio and estatus = 3) as totalPedidosCancelados,
			/*-------------------------------------------------------------------------------*/
			/*Total de dinero de todos los pedidos del mes*/
			(select sum(total) from pedido where MONTH(fecha_registro) = mes and YEAR(fecha_registro) = anio) as totalPedidosDinero,
			/*Total de dinero de todos los pedidos pagados del día*/
			(select sum(total) from pedido where MONTH(fecha_registro) = mes and YEAR(fecha_registro) = anio and estatus = 2) as totalPedidosDineroPagados,
			/*Total de dinero de todos los pedidos a credito del día*/
			(select sum(total) from pedido where MONTH(fecha_registro) = mes and YEAR(fecha_registro) = anio and estatus = 1) as totalPedidosDineroCredito,
			/*Total de dinero de todos los pedidos pendientes del día*/
			(select sum(total) from pedido where MONTH(fecha_registro) = mes and YEAR(fecha_registro) = anio and estatus = 0) as totalPedidosDineroPendientes,
			/*Total de dinero de todos los pedidos cancelados del día*/
			(select sum(total) from pedido where MONTH(fecha_registro) = mes and YEAR(fecha_registro) = anio and estatus = 3) as totalPedidosDineroCancelados
		    ;
			/*-------------------------------------------------------------------------------*/
	    elseif (tipo = "anio") then
	        /*Total de pedidos del año*/
	    select
			(select count(*) from pedido where YEAR(fecha_registro) = anio) as totalPedidos,
			/*Total de pedidos pagados del día*/
			(select count(*) from pedido where YEAR(fecha_registro) = anio and estatus = 2) as totalPedidosPagados,
			/*Total de pedidos a credito del día*/
			(select count(*) from pedido where YEAR(fecha_registro) = anio and estatus = 1) as totalPedidosCredito,
			/*Total de pedidos pendientes del día*/
			(select count(*) from pedido where YEAR(fecha_registro) = anio and estatus = 0) as totalPedidosPendientes,
			/*Total de pedidos cancelados del día*/
			(select count(*) from pedido where YEAR(fecha_registro) = anio and estatus = 3) as totalPedidosCancelados,
			/*-------------------------------------------------------------------------------*/
			/*Total de dinero de todos los pedidos del año*/
			(select sum(total) from pedido where YEAR(fecha_registro) = anio) as totalPedidosDinero,
			/*Total de dinero de todos los pedidos pagados del año*/
			(select sum(total) from pedido where YEAR(fecha_registro) = anio and estatus = 2) as totalPedidosDineroPagados,
			/*Total de dinero de todos los pedidos a credito del año*/
			(select sum(total) from pedido where YEAR(fecha_registro) = anio and estatus = 1) as totalPedidosDineroCredito,
			/*Total de dinero de todos los pedidos pendientes del año*/
			(select sum(total) from pedido where YEAR(fecha_registro) = anio and estatus = 0) as totalPedidosDineroPendientes,
			/*Total de dinero de todos los pedidos cancelados del año*/
			(select sum(total) from pedido where YEAR(fecha_registro) = anio and estatus = 3) as totalPedidosDineroCancelados
		;
	    elseif (tipo = "periodo") then     
	        /*Total de pedidos por periodo*/
	    select
			(select count(*) from pedido where DATE(fecha_registro) between group_concat(anio,'-',mes,'-',dia,' 00:00:00') AND group_concat(fechaFin,' 23:59:59')) as totalPedidos,
			/*Total de pedidos pagados del día*/
			(select count(*) from pedido where DATE(fecha_registro) between group_concat(anio,'-',mes,'-',dia,' 00:00:00') AND group_concat(fechaFin,' 23:59:59') and estatus = 2) as totalPedidosPagados,
			/*Total de pedidos a credito del día*/
			(select count(*) from pedido where DATE(fecha_registro) between group_concat(anio,'-',mes,'-',dia,' 00:00:00') AND group_concat(fechaFin,' 23:59:59') and estatus = 1) as totalPedidosCredito,
			/*Total de pedidos pendientes del día*/
			(select count(*) from pedido where DATE(fecha_registro) between group_concat(anio,'-',mes,'-',dia,' 00:00:00') AND group_concat(fechaFin,' 23:59:59') and estatus = 0) as totalPedidosPendientes,
			/*Total de pedidos cancelados del día*/
			(select count(*) from pedido where DATE(fecha_registro) between group_concat(anio,'-',mes,'-',dia,' 00:00:00') AND group_concat(fechaFin,' 23:59:59') and estatus = 3) as totalPedidosCancelados,
			/*-------------------------------------------------------------------------------*/
			/*Total de dinero de pedidos por periodo*/
			(select sum(total) from pedido where DATE(fecha_registro) between group_concat(anio,'-',mes,'-',dia,' 00:00:00') AND group_concat(fechaFin,' 23:59:59')) as totalPedidosDinero,
			/*Total de pedidos pagados del día*/
			(select sum(total) from pedido where DATE(fecha_registro) between group_concat(anio,'-',mes,'-',dia,' 00:00:00') AND group_concat(fechaFin,' 23:59:59') and estatus = 2) as totalPedidosDineroPagados,
			/*Total de pedidos a credito del día*/
			(select sum(total) from pedido where DATE(fecha_registro) between group_concat(anio,'-',mes,'-',dia,' 00:00:00') AND group_concat(fechaFin,' 23:59:59') and estatus = 1) as totalPedidosDineroCredito,
			/*Total de pedidos pendientes del día*/
			(select sum(total) from pedido where DATE(fecha_registro) between group_concat(anio,'-',mes,'-',dia,' 00:00:00') AND group_concat(fechaFin,' 23:59:59') and estatus = 0) as totalPedidosDineroPendientes,
			/*Total de pedidos cancelados del día*/
			(select sum(total) from pedido where DATE(fecha_registro) between group_concat(anio,'-',mes,'-',dia,' 00:00:00') AND group_concat(fechaFin,' 23:59:59') and estatus = 3) as totalPedidosDineroCancelados
		;
			/*-------------------------------------------------------------------------------*/
	    else 
	        SELECT * FROM pedido WHERE id = 0;
	    end if;
    
end

CALL obtenerPedidosporFecha("2016", "05", "24", null, "dia");
CALL obtenerPedidosporFecha("2016", "05", "24", null, "mes");
CALL obtenerPedidosporFecha("2022", "05", "24", null, "anio");
CALL obtenerPedidosporFecha("2015", "11", "30", "2022-04-11", "periodo");
 CALL obtenerPedidosporFecha('2022', '04', '02', null, 'periodo');

/* stored para ver tods los pedidos*/
drop procedure obtenerPedidos;
CREATE PROCEDURE obtenerPedidos()
begin
	
    select 
		(select count(*) from pedido) as totalPedidos,
		(select count(*) from pedido where estatus = 2) as totalPedidosPagados,
		(select count(*) from pedido where estatus = 1) as totalPedidosCredito,
		(select count(*) from pedido where estatus = 0) as totalPedidosPendientes,
		(select count(*) from pedido where estatus = 3) as totalPedidosCancelados,
			
		(select sum(total) from pedido) as totalPedidosDinero,
		(select sum(total) from pedido where estatus = 2) as totalPedidosDineroPagados,
		(select sum(total) from pedido where estatus = 1) as totalPedidosDineroCredito,
		(select sum(total) from pedido where estatus = 0) as totalPedidosDineroPendientes,
		(select sum(total) from pedido where estatus = 3) as totalPedidosDineroCancelados
		
		;
    
end


call obtenerPedidos();

select * from producto;
select * from vh_inventario;

select * from producto;
select * from importador;
select * from almacen;
select * from familia;
select * from categoria;

create or replace view vh_producto as
select producto.id as id, producto.clave, producto.nombre, producto.color,
       producto.piezas_paquete, producto.total_piezas, producto.foto, 
       producto.created_at, 
      (case when (producto.iva0  = 1) then 'SI' else 'NO'end) as IVA,
      (case when (producto.estatus  = 1) then 'Activo' else 'Inactivo'end) as estatus,
      concat("/img/productos/", producto.foto) as ruta_imagen,
      importador.nombre as importador,
      almacen.nombre as almacen,
      familia.descripcion as familia,
      categoria.categoria as categoria
  from  producto
  join importador on importador.id = producto.importador_id
  join almacen on almacen.id = producto.almacen_id
  join familia on familia.id = producto.familia_id
  join categoria on categoria.id = producto.categoria_id
  where producto.estatus = 1
 order by producto.id desc;


select * from cliente;
select * from pedido;
select * from usuario;
select * from rol;

select cliente.nombre_cliente, cliente.paterno, cliente.materno,
		pedido.id as id, pedido.num_pedido, pedido.created_at, pedido.extra_pedido, pedido.estatus,
		usuario.usuario,
		rol.nombre as rol
from cliente 
		join pedido on pedido.cliente_id = cliente.id
		left join usuario on usuario.id = cliente.usuario_id
		left join rol on rol.id = usuario.rol_id;

select * from vh_inventario where idProducto = 1;

 select * from producto;
 select * from vh_producto;

select * from cliente;
select * from nivel_descuento;

create or replace view vh_producto_detail as
select producto.id, producto.clave, producto.nombre, producto.color, producto.iva0, producto.foto,
concat("/img/productos/", producto.foto) as ruta_imagen,
inventario.cantidad,
producto_precio.moneda, producto_precio.precio,
categoria.categoria as categoria, categoria.id as idCategoria
from producto
join inventario on producto.id = inventario.producto_id
join producto_precio on producto.id = producto_precio.producto_id
join categoria on categoria.id = producto.categoria_id
where producto_precio.estatus = 1
and producto.estatus = 1
and producto_precio.tipo = 1
order by clave asc, nombre asc, id desc;

select * from pedido;

/* - (case when (producto.iva0  = 1) then 'SI' else 'NO'end) as IVA, */

select * from usuario;
select * from cliente;

select * from rol;

create or replace view vh_pedido_cliente as
select concat(cliente.nombre_cliente, ' ' ,cliente.paterno, ' ', cliente.materno) as nombre_cliente, 
cliente.razon_social, cliente.numero_cliente, cliente.agente_id,
usuario.usuario as agente,
pedido.id, pedido.num_pedido, pedido.total, pedido.fecha_registro as created_at,
(case when (pedido.extra_pedido = 1) then 'Si' else 'No' end) as extra_pedido,
pedido.estatus as estatus,
(case when (pedido.estatus = 0) then 'Pendiente' when (pedido.estatus = 1) then 'Crédito' when (pedido.estatus = 2) then 'Pagado' else 'Cancelado' end) as estatusDes
from cliente
join pedido on pedido.cliente_id = cliente.id
join usuario on usuario.id = cliente.agente_id
where pedido.estatus != 4
order by pedido.created_at desc, pedido.id desc;

select * from vh_pedido_cliente where agente_id = 92;

select sum(total) as sumaTotal from vh_pedido_cliente where agente_id = 92;

select * from vh_pedido_cliente;

select * from vh_producto_detail;


 SELECT * FROM vh_producto_detail WHERE UPPER(clave) LIKE '%AC01%';

select * from categoria order by categoria asc;

select * from inventario;
select * from inventario_detalle;
select * from producto;
select * from producto_precio;

select sum(cantidad) as cantidadProductoInventario from inventario_detalle where producto_id = 7;


