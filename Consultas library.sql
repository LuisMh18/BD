use library;

drop table books;

CREATE TABLE books (
  id int(11) NOT NULL AUTO_INCREMENT,
  titulo varchar(100) NOT NULL,
  autor varchar(100) NOT NULL,
  edicion int(11) DEFAULT NULL,
  date_add datetime DEFAULT NULL,
  date_modified datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;


select * from books;

describe books;