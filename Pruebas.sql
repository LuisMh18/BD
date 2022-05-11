create database pruebas;

use pruebas;

drop table usuario;
CREATE TABLE usuario (
  id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  usuario varchar(200) DEFAULT NULL,
  perfil varchar(200) DEFAULT NULL,
  created_at datetime DEFAULT CURRENT_TIMESTAMP,
  updated_at datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

INSERT INTO usuario 
(id, usuario, perfil) 
VALUES 
(1, "LuisMh", "Administrador"),
(2, "RPrueba", "Programador"),
(3, "DManager", "Director de proyectos"),
(4, "Admin", "Administrador");

INSERT INTO usuario 
(id, usuario, perfil) 
VALUES 
(8, "Test", "Test");

select * from usuario;

drop table total_usuarios;
CREATE TABLE total_usuarios (
  id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  total int(10) default null,
  created_at datetime DEFAULT CURRENT_TIMESTAMP,
  updated_at datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

select * from total_usuarios;
INSERT INTO total_usuarios 
(total) 
VALUES 
(4);

select count(*) from usuario;

drop trigger nuevoTotalUsuarios;

/*Trigguer que se ejecuta despues de que se inserta un nuevo usuario
 * se actualiza el total de usuarios*/
CREATE TRIGGER nuevoTotalUsuarios
after insert ON usuario
FOR EACH ROW
BEGIN
  update total_usuarios set total = total + 1;
END

drop table usuario_detalle;
CREATE TABLE usuario_detalle (
  id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  nombre varchar(200) NOT NULL,
  apellidos varchar(200) NOT NULL,
  usuario_id int(11) NOT null,
  created_at datetime DEFAULT CURRENT_TIMESTAMP,
  updated_at datetime DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE RESTRICT ON UPDATE restrict 
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


INSERT INTO usuario_detalle 
(id, nombre, apellidos, usuario_id) 
VALUES 
(1, "LuisÁngel", "Mondragón", 1),
(2, "Jesus", "Perez", 4);


select * from usuario_detalle;

/* inner join y join es lo mismo, es la union de las tablas donde coinciden los datos
 * que estamos agregando, es decir solo te trae los datos que coincidan en las dos tablas,
 * INNER JOIN: Devuelve todas las filas cuando hay al menos una coincidencia en ambas tablas. */
select * from usuario 
		join usuario_detalle on usuario.id = usuario_detalle.usuario_id;

/*te trae todos los datos aun que no coincidan
 * LEFT JOIN: Devuelve todas las filas de la tabla de la izquierda, y las filas coincidentes de 
 * la tabla de la derecha.
 * */
select * from usuario 
		left join usuario_detalle on usuario.id = usuario_detalle.usuario_id;

/*RIGHT JOIN: Devuelve todas las filas de la tabla de la derecha, y las filas coincidentes de 
 * la tabla de la izquierda.*/
select * from usuario 
		right join usuario_detalle on usuario.id = usuario_detalle.usuario_id;
	
/*OUTER JOIN: Devuelve todas las filas de las dos tablas, la izquierda y la derecha. 
 * También se llama FULL OUTER JOIN. --- mm hace los mismo que solo el left join*/
select * from usuario 
		left OUTER join usuario_detalle on usuario.id = usuario_detalle.usuario_id;
	
	
CREATE TABLE productos (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL,
    coste FLOAT NOT NULL DEFAULT 0.0,
    precio FLOAT NOT NULL DEFAULT 0.0,
    PRIMARY KEY(id)
);

INSERT INTO productos (nombre, coste, precio) 
VALUES 
('Producto A', 4, 8), 
('Producto B', 2, 4),
('Producto C', 40, 80);

select * from productos;

/*
 * 
 * Técnicamente, un trigger es un objeto de una base de datos que está asociado a una tabla, 
 * y que será activado cuando la acción que tiene asociada tiene lugar. El trigger se puede ejecutar 
 * cuando tiene lugar una acción INSERT, UPDATE o DELETE, siendo posible su ejecución tanto antes como 
 * después del evento.
 * 
 * **/

/*
 * 
 * Vamos a crear un trigger que actualice automáticamente el precio de los productos de la tabla creada en 
 * el apartado anterior cada vez que se actualice su coste. Le llamaremos actualizarPrecioProducto.
 * El trigger comprobará si el coste del producto ha cambiado y, en caso afirmativo, establecerá el precio 
 * del producto con el doble del valor de su coste. Para crear el trigger
 * 
 * Lo que hacemos es crear un trigger que se ejecute antes de la actualización del registro, algo 
 * que indicamos con la sentencia «BEFORE UPDATE ON«. Luego comprobamos si el coste antiguo del producto 
 * difiere del nuevo y, si es así, actualizamos el precio con el doble del valor de su nuevo coste. 
 * Un negocio redondo.
 * */

drop trigger actualizarPrecioProducto;

create trigger actualizarPrecioProducto
before update on productos 
for each row 
 if new.coste <> old.coste
 	then 
 	 set new.precio = new.coste * 2;
 end if 

UPDATE productos SET coste = 25 WHERE id = 1;
SELECT * FROM productos;




/*------------------------------------------*/
use apirest;
select * from usuarios;
select * from pacientes;
select * from usuarios_token;

