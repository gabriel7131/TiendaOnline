-- CREAMOS LA BBDD Y LAS TABLAS --
CREATE DATABASE ecommerce_bbdd;

CREATE TABLE tbl_categorias (
	codigo INT AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(50),
	visible boolean default true,
	categoria_superior INT,
	foreign key(categoria_superior) REFERENCES tbl_categorias(codigo)
);

CREATE TABLE tbl_marcas (
	codigo INT AUTO_INCREMENT PRIMARY KEY,
	nombre varchar(50) UNIQUE,
	visible boolean default true
);

CREATE TABLE tbl_productos (
	webid INT AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(50),
	precio DECIMAL(10,2),
	precionuevo DECIMAL(10,2),
	stock INT default 1,
	nuevo BOOLEAN default true,
	recomendado BOOLEAN default false,
	descripcion VARCHAR(255),
	visible BOOLEAN default true,
	CHECK (precio>precionuevo),
	codigo_marca INT,
	codigo_categoria INT,
	FOREIGN KEY(codigo_marca) REFERENCES tbl_marcas(codigo),
	FOREIGN KEY(codigo_categoria) REFERENCES tbl_categorias(codigo),
	img VARCHAR(100) default 'demo.png'
);

CREATE TABLE tbl_revision (
	codigo INT AUTO_INCREMENT PRIMARY KEY,
	nombre varchar(50) UNIQUE not null,
	correo VARCHAR(80),
	comentario VARCHAR(255),
	estrellas INT default 3,
	fecha DATETIME,
	webid INT,
	FOREIGN KEY(webid) REFERENCES tbl_productos(webid)
);


-- CREAMOS ESTOS DOS PROCEDURES PARA MOSTRAR CATEGORIAS Y SUBCATEGORIAS --
DELIMITER $$
CREATE PROCEDURE ecommerce_bbdd.sp_listarCategoriaSuperior()
BEGIN
    SELECT codigo, nombre FROM tbl_categorias
    WHERE codigo=categoria_superior AND visible=true;
END $$

DELIMITER $$
CREATE PROCEDURE ecommerce_bbdd.sp_listarSubCategoria(p_csuperior int)
BEGIN
    SELECT codigo, nombre FROM tbl_categorias
    WHERE codigo<>categoria_superior AND visible=true AND categoria_superior=p_csuperior;
END $$ 


-- Y LOS PROBAMOS --
call sp_listarCategoriaSuperior()

call sp_listarSubCategoria (1)
call sp_listarSubCategoria (5)


-- CREAMOS UN PL PARA CONTAR SUBCATEGORIAS Y SI ES CERO NO COLOCAR EL FA FA-PLUS --
delimiter $$
CREATE PROCEDURE sp_contarSubCategorias (codcat int)
BEGIN
	SELECT count(*) as cantidad FROM tbl_categorias
	WHERE categoria_superior=codcat AND codigo<>codcat;
END $$


-- PROBAMOS EL PL PARA CONTAR SUBCATEGORIAS --
call sp_contarSubCategorias(1)
call sp_contarSubCategorias(5)
call sp_contarSubCategorias(8)
call sp_contarSubCategorias(9)


-- PROBAMOS EL UPDATE, QUE ES LO UNICO QUE NOS FALTABA DE HACER DEL CRUD (Create, Read, Update, Delete)--
SELECT * FROM tbl_categorias LIMIT 100;

UPDATE `ecommerce_bbdd`.`tbl_categorias` SET `nombre`='Mujeres' WHERE `codigo`='8';
UPDATE `ecommerce_bbdd`.`tbl_categorias` SET `nombre`='Niños' WHERE `codigo`='9';

SELECT * FROM tbl_categorias LIMIT 100;

UPDATE tbl_categorias SET nombre = 'Mujeres' WHERE codigo='9';
UPDATE tbl_categorias SET nombre='Niños' WHERE codigo='8';

SELECT * FROM tbl_categorias LIMIT 100;

UPDATE tbl_categorias SET nombre = 'Mujeres' WHERE codigo='8';
UPDATE tbl_categorias SET nombre='Niños' WHERE codigo='9';

SELECT * FROM tbl_categorias LIMIT 100;

