DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda CHARACTER SET utf8mb4;
USE tienda;

CREATE TABLE fabricante(
 codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
 nombre VARCHAR(100) NOT NULL
);

CREATE TABLE producto(
    codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DOUBLE NOT NULL,
    codigo_fabricante INT UNSIGNED NOT NULL,
    FOREIGN KEY (codigo_fabricante) REFERENCES fabricante(codigo)
);

INSERT INTO fabricante VALUES(1, "Asus");
INSERT INTO fabricante VALUES(2, "Lenovo");
INSERT INTO fabricante VALUES(3, "Hewlett-Packard");
INSERT INTO fabricante VALUES(4, "Samsung");
INSERT INTO fabricante VALUES(5, "Seagate");
INSERT INTO fabricante VALUES(6, "Crucial");
INSERT INTO fabricante VALUES(7, "Gigabyte");
INSERT INTO fabricante VALUES(8, "Huawei");
INSERT INTO fabricante VALUES(9, "Xiaomi");

INSERT INTO producto VALUES(1,  "Disco duro SATA3 1TB", 86.99, 5);
INSERT INTO producto VALUES(2,  "Memoria RAM DDR4 8GB", 120, 6);
INSERT INTO producto VALUES(3,  "Disco SSD 1TB", 150.99, 4);
INSERT INTO producto VALUES(4,  "GeForece GTX 1050Ti", 185, 7);
INSERT INTO producto VALUES(5,  "GeForce GTX 1080 Xtreme", 755, 6);
INSERT INTO producto VALUES(6,  "Monitor 24 LED Full HD", 202, 1);
INSERT INTO producto VALUES(7,  "Monitor 27 LED Full HD", 245.99, 1);
INSERT INTO producto VALUES(8,  "Portátil Yoga 520", 559, 2);
INSERT INTO producto VALUES(9,  "Portátil Ideapad 320", 444, 2);
INSERT INTO producto VALUES(10, "Impresora HP Deskjet 3720", 59.99, 3);
INSERT INTO producto VALUES(11, "Impresora HP Laserjet Pro M26nw", 180, 3);

/*Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.:*/
/*1. Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos 
que tiene cada uno de ellos. El listado deberá mostrar también aquellos fabricantes que no tienen productos asociados.*/
SELECT fabricante.nombre, producto.nombre
FROM fabricante LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante
ORDER BY fabricante.nombre ASC;
/*2. Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.*/
SELECT fabricante.nombre
FROM fabricante LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante
WHERE producto.codigo_fabricante IS NULL;
/*3. ¿Pueden existir productos que no estén relacionados con un fabricante? Justifique su respuesta.*/
/*
Si, siempre que dentro de la tabla de productos, el código del fabricante no 
tenga la restrición NOT NULL
*/