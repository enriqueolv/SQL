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

/*1. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.*/
SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;
/*2. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. 
Ordene el resultado por el nombre del fabricante, por orden alfabético.*/
SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto INNER JOIN fabricante ON producto.codigo_fabricante=fabricante.codigo ORDER BY fabricante.nombre ASC;
/*3. Devuelve una lista con el código del producto, nombre del producto, código del fabricante y nombre del fabricante, 
de todos los productos de la base de datos.*/
SELECT producto.codigo, producto.nombre, producto.codigo_fabricante, fabricante.nombre FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;
/*4. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.*/
SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE producto.precio = (SELECT MIN(precio) FROM producto);
/*5. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro.*/
SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE producto.precio = (SELECT MAX(precio) FROM producto);
/*6. Devuelve una lista de todos los productos del fabricante Lenovo.*/
SELECT producto.nombre, producto.codigo_fabricante, fabricante.nombre FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = "Lenovo";
/*7. Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que 200€.*/
SELECT producto.nombre, producto.codigo_fabricante, fabricante.nombre 
FROM producto INNER JOIN fabricante 
ON producto.codigo_fabricante = fabricante.codigo 
WHERE fabricante.nombre = "Crucial" AND producto.precio > 200;
/*8. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate. Sin utilizar el operador IN.*/
SELECT producto.nombre, producto.codigo_fabricante, fabricante.nombre 
FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre = "Asus" OR fabricante.nombre = "Hewlett-Packard" OR fabricante.nombre = "Seagate";
/*9. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate. Utilizando el operador IN.*/
SELECT producto.nombre, producto.codigo_fabricante, fabricante.nombre
FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre IN ("Asus", "Hewlett-Packard", "Seagate");
/*10. Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes cuyo nombre termine por la vocal e.*/
SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE UPPER(SUBSTRING(fabricante.nombre, LENGTH(fabricante.nombre), 1)) = UPPER("e");
/*11. Devuelve un listado con el nombre y el precio de todos los productos cuyo nombre de fabricante contenga el carácter w en su nombre.*/
SELECT producto.nombre, producto.precio, producto.codigo_fabricante, fabricante.nombre
FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre LIKE "%w%";
/*12. Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o 
igual a 180€. Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)*/
SELECT producto.nombre, producto.precio, fabricante.nombre
FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
WHERE producto.precio >= 180 ORDER BY producto.precio DESC, producto.nombre ASC;
/*13. Devuelve un listado con el código y el nombre de fabricante, solamente de aquellos fabricantes que tienen productos asociados en la base de datos.*/
SELECT fabricante.codigo, fabricante.nombre
FROM fabricante 
WHERE fabricante.codigo IN (SELECT DISTINCT codigo_fabricante FROM producto);