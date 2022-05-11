use merntasks;

drop table usuario;
CREATE TABLE usuario (
  id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  nombre varchar(200) NOT NULL,
  email varchar(200) NOT NULL,
  password varchar(200) NOT NULL,
  date_add datetime DEFAULT CURRENT_TIMESTAMP,
  date_modified datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

select * from usuario order by id desc;
desc usuario;

INSERT INTO usuario 
(id, nombre, email, password, date_add, date_modified) 
VALUES 
(1, "Luis Ángel", "luis@gmail.com", "Luis1234", CURRENT_TIMESTAMP ,CURRENT_TIMESTAMP);

INSERT INTO usuario 
(id, nombre, email, password) 
VALUES 
(2, "Diana", "diana@gmail.com", "diana1234"),
(3, "Vianney", "vianney@gmail.com", "vianney1234");


drop table proyecto;
CREATE TABLE proyecto (
  id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  nombre varchar(200) NOT NULL,
  usuario_id int(11) NOT null,
  date_add datetime DEFAULT CURRENT_TIMESTAMP,
  date_modified datetime DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (usuario_id) REFERENCES usuario(id) ON DELETE RESTRICT ON UPDATE restrict 
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


select * from proyecto order by id desc;
desc proyecto;


drop table tarea;
CREATE TABLE tarea (
  id int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  nombre varchar(200) NOT NULL,
  estado tinyint(1) default 0,
  proyecto_id int(11) NOT null,
  date_add datetime DEFAULT CURRENT_TIMESTAMP,
  date_modified datetime DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (proyecto_id) REFERENCES proyecto(id) ON DELETE RESTRICT ON UPDATE restrict 
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


select * from tarea order by id desc;
desc tarea;



