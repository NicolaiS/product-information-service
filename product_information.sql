DROP DATABASE IF EXISTS product_information;
CREATE DATABASE product_information;

USE product_information;

CREATE TABLE urn(
   urn_id int not null auto_increment primary key,
   urn varchar(52) not null,
   urn_version int
) ENGINE=InnoDB;

CREATE TABLE container(
   container_id int not null auto_increment primary key,
   urn_id int not null,
   name varchar(200) not null,
   sort_order int not null,
   FOREIGN KEY fk_urn(urn_id) REFERENCES urn(urn_id)
) ENGINE=InnoDB;

CREATE TABLE attr_type(
   attr_type_id int not null auto_increment primary key,
   attr_type_description varchar(200)
) ENGINE=InnoDB;

CREATE TABLE attribute(
   attr_id int not null auto_increment primary key,
   urn_id int not null,
   attr_type_id int not null,
   attr_key varchar(100) not null,   
   attr_name varchar(100),
   attr_value text not null,
   sort_order int not null,
   value_format varchar(100),
   FOREIGN KEY (urn_id) REFERENCES urn(urn_id),
   FOREIGN KEY (attr_type_id) REFERENCES attr_type(attr_type_id),
   UNIQUE KEY uq_attr_urn (urn_id, attr_key)
) ENGINE=InnoDB;

CREATE TABLE container_attr(
   container_attr_id int not null auto_increment primary key,
   container_id int not null,
   attr_type_id int not null,
   attr_key varchar(100) not null,   
   attr_name varchar(100),
   attr_value text not null,
   sort_order int not null,
   value_format varchar(100),
   FOREIGN KEY (container_id) REFERENCES container(container_id),
   FOREIGN KEY (attr_type_id) REFERENCES attr_type(attr_type_id),
   UNIQUE KEY uq_attr_container (container_id, attr_key)
) ENGINE=InnoDB;

delimiter //
CREATE TRIGGER update_version_1 AFTER INSERT ON attribute
   FOR EACH ROW
   BEGIN
         UPDATE urn SET urn_version = urn_version + 1 WHERE urn_id = NEW.urn_id;
   END;//
delimiter ;

delimiter //
CREATE TRIGGER update_version_2 AFTER UPDATE ON attribute
   FOR EACH ROW
   BEGIN
         UPDATE urn SET urn_version = urn_version + 1 WHERE urn_id = NEW.urn_id;
   END;//
delimiter ;

delimiter //
CREATE TRIGGER update_version_3 BEFORE DELETE ON attribute
   FOR EACH ROW
   BEGIN
         UPDATE urn SET urn_version = urn_version + 1 WHERE urn_id = OLD.urn_id;
   END;//
delimiter ;

delimiter //
CREATE TRIGGER update_version_4 AFTER INSERT ON container_attr
   FOR EACH ROW
   BEGIN
         UPDATE urn SET urn_version = urn_version + 1 WHERE urn_id = (SELECT urn_id FROM container WHERE container_id = NEW.container_id);
   END;//
delimiter ;

delimiter //
CREATE TRIGGER update_version_5 AFTER UPDATE ON container_attr
   FOR EACH ROW
   BEGIN
         UPDATE urn SET urn_version = urn_version + 1 WHERE urn_id = (SELECT urn_id FROM container WHERE container_id = NEW.container_id);
   END;//
delimiter ;

delimiter //
CREATE TRIGGER update_version_6 BEFORE DELETE ON container_attr
   FOR EACH ROW
   BEGIN
         UPDATE urn SET urn_version = urn_version + 1 WHERE urn_id = (SELECT urn_id FROM container WHERE container_id = OLD.container_id);
   END;//
delimiter ;

delimiter //
CREATE TRIGGER update_version_7 AFTER INSERT ON container
   FOR EACH ROW
   BEGIN
         UPDATE urn SET urn_version = urn_version + 1 WHERE urn_id = NEW.urn_id;
   END;//
delimiter ;

delimiter //
CREATE TRIGGER update_version_8 AFTER UPDATE ON container
   FOR EACH ROW
   BEGIN
         UPDATE urn SET urn_version = urn_version + 1 WHERE urn_id = NEW.urn_id;
   END;//
delimiter ;

delimiter //
CREATE TRIGGER update_version_9 BEFORE DELETE ON container
   FOR EACH ROW
   BEGIN
         UPDATE urn SET urn_version = urn_version + 1 WHERE urn_id = OLD.urn_id;
   END;//
delimiter ;
