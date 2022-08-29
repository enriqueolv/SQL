DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda CHARACTER SET utf8mb4;
USE tienda;
DROP TABLE IF EXISTS fabricante;
DROP TABLE IF EXISTS producto;
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

/*1. Calcula el número total de productos que hay en la tabla productos.*/
SELECT COUNT(*) FROM producto;
/*2. Calcula el número total de fabricantes que hay en la tabla fabricante.*/
SELECT COUNT(*) FROM fabricantes;
/*3. Calcula el número de valores distintos de código de fabricante aparecen en la tabla productos.*/
SELECT COUNT(DISTINCT codigo_fabricante) FROM producto;
/*4. Calcula la media del precio de todos los productos.*/
SELECT AVG(precio) FROM producto;
/*5. Calcula el precio más barato de todos los productos.*/
SELECT MIN(precio) FROM producto;
/*6. Calcula el precio más caro de todos los productos.*/
SELECT MAX(precio) FROM producto;
/*7. Lista el nombre y el precio del producto más barato.*/
SELECT nombre, precio FROM producto WHERE precio = (SELECT MIN(precio) FROM producto);
/*8. Lista el nombre y el precio del producto más caro.*/
SELECT nombre, precio FROM producto WHERE precio = (SELECT MAX(precio) FROM producto);
/*9. Calcula la suma de los precios de todos los productos.*/
SELECT SUM(precio) FROM producto;
/*10. Calcula el número de productos que tiene el fabricante Asus.*/
SELECT COUNT(*) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = "Asus");
/*11. Calcula la media del precio de todos los productos del fabricante Asus.*/
SELECT AVG(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = "Asus");
/*12. Calcula el precio más barato de todos los productos del fabricante Asus.*/
SELECT MIN(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre="Asus");
/*13. Calcula el precio más caro de todos los productos del fabricante Asus.*/
SELECT MAX(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre="Asus");
/*14. Calcula la suma de todos los productos del fabricante Asus.*/
SELECT SUM(precio) FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre="Asus");
/*15. Muestra el precio máximo, precio mínimo, precio medio y el número total de productos que tiene el fabricante Crucial.*/
SELECT MAX(precio), MiN(precio), AVG(precio), COUNT(*) FROM producto  WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = "Crucial");
/*16. Muestra el número total de productos que tiene cada uno de los fabricantes. El listado también debe incluir los 
fabricantes que no tienen ningún producto. El resultado mostrará dos columnas, una con el nombre del fabricante y otra con el número de productos que tiene. 
Ordene el resultado descendentemente por el número de productos.*/
SELECT fabricante.nombre, COUNT(producto.codigo_fabricante) AS cantidad_de_productos
FROM fabricante LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante
GROUP BY fabricante.nombre ORDER BY cantidad_de_productos DESC;
/*17. Muestra el precio máximo, precio mínimo y precio medio de los productos de cada uno de los fabricantes. 
El resultado mostrará el nombre del fabricante junto con los datos que se solicitan.*/
SELECT fabricante.nombre, MAX(producto.precio), MIN(producto.precio), AVG(producto.precio)
FROM fabricante LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante
GROUP BY fabricante.codigo;
/*18. Muestra el precio máximo, precio mínimo, precio medio y el número total de productos de los fabricantes que tienen un precio medio superior a 200€. 
No es necesario mostrar el nombre del fabricante, con el código del fabricante es suficiente. Recuerda que WHERE no puede ser usado con funciones de agregacion(AVR, COUNT, SUM, etc.)*/
SELECT fabricante.nombre, fabricante.codigo MIN(producto.precio), MAX(producto.precio), AVG(producto.precio), COUNT(producto.codigo_fabricante)
FROM fabricante LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante
GROUP BY fabricante.codigo
HAVING AVG(producto.precio) > 200;
/*19. Muestra el nombre de cada fabricante, junto con el precio máximo, precio mínimo, precio medio y el número total de productos 
de los fabricantes que tienen un precio medio superior a 200€. Es necesario mostrar el nombre del fabricante.*/
SELECT fabricante.nombre, MIN(producto.precio), MAX(producto.precio), AVG(producto.precio), COUNT(producto.codigo_fabricante)
FROM fabricante LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante
GROUP BY fabricante.codigo
HAVING AVG(producto.precio) > 200;
/*20. Calcula el número de productos que tienen un precio mayor o igual a 180€.*/
SELECT COUNT(*) FROM producto WHERE precio >= 180;
/*21. Calcula el número de productos que tiene cada fabricante con un precio mayor o igual a 180€.*/
SELECT fabricante.nombre, COUNT(producto.codigo_fabricante)
FROM fabricante LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante
WHERE producto.precio >= 180
GROUP BY fabricante.codigo
/*22. Lista el precio medio los productos de cada fabricante, mostrando solamente el código del fabricante.*/
SELECT fabricante.codigo, AVG(producto.precio)
FROM fabricante LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante
GROUP BY fabricante.codigo;
/*23. Lista el precio medio los productos de cada fabricante, mostrando solamente el nombre del fabricante.*/
SELECT fabricante.nombre, AVG(producto.precio)
FROM fabricante LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante
GROUP BY fabricante.codigo;
/*24. Lista los nombres de los fabricantes cuyos productos tienen un precio medio mayor o igual a 150€.*/
SELECT fabricante.nombre, AVG(producto.precio)
FROM fabricante LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante
GROUP BY fabricante.codigo
HAVING AVG(producto.precio) > 150;
/*25. Devuelve un listado con los nombres de los fabricantes que tienen 2 o más productos.*/
SELECT fabricante.nombre, COUNT(producto.codigo_fabricante)
FROM fabricante LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante
GROUP BY fabricante.codigo
HAVING COUNT(producto.codigo_fabricante) >= 2;
/*26. Devuelve un listado con los nombres de los fabricantes y el número de productos que tiene cada uno con un precio superior o igual a 220 €. 
No es necesario mostrar el nombre de los fabricantes que no tienen productos que cumplan la condición.*/
SELECT fabricante.nombre, COUNT(producto.codigo_fabricante)
FROM fabricante INNER JOIN producto ON fabricante.codigo = producto.codigo_fabricante
WHERE producto.precio >= 220
GROUP BY fabricante.nombre;
/*27. Devuelve un listado con los nombres de los fabricantes y el número de productos que tiene cada uno con un precio superior o igual a 220 €. 
El listado debe mostrar el nombre de todos los fabricantes, es decir, si hay algún fabricante que no tiene productos con un precio superior o igual a 220€ 
deberá aparecer en el listado con un valor igual a 0 en el número de productos. See: diference between where and AND inside ON clause*/
SELECT fabricante.nombre, COUNT(producto.codigo_fabricante)
FROM fabricante LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante AND producto.precio > 220
GROUP BY fabricante.nombre;
/*28. Devuelve un listado con los nombres de los fabricantes donde la suma del precio de todos sus productos es superior a 1000 €.*/
SELECT fabricante.nombre, SUM(producto.precio)
FROM fabricante INNER JOIN producto ON fabricante.codigo = producto.codigo_fabricante
GROUP BY fabricante.nombre
HAVING SUM(producto.precio) > 1000;
/*29. Devuelve un listado con el nombre del producto más caro que tiene cada fabricante. El resultado debe tener tres columnas: 
nombre del producto, precio y nombre del fabricante. El resultado tiene que estar ordenado alfabéticamente de menor a mayor por el nombre del fabricante.*/
SELECT fabricante.nombre, MAX(producto.precio), producto.nombre
FROM producto INNER JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo
GROUP BY fabricante.codigo
ORDER BY fabricante.nombre ASC;