CREATE DATABASE IF NOT EXISTS ventas_db;
CREATE USER IF NOT EXISTS 'sqoopuser'@'%' IDENTIFIED BY 'sqooppassword';
GRANT ALL PRIVILEGES ON ventas_db.* TO 'sqoopuser'@'%';
FLUSH PRIVILEGES;

USE ventas_db;
SET SESSION cte_max_recursion_depth = 2000;

CREATE TABLE clientes (
  id_cliente INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50),
  email VARCHAR(100),
  ciudad VARCHAR(50)
);

CREATE TABLE pedidos (
  id_pedido INT PRIMARY KEY AUTO_INCREMENT,
  id_cliente INT,
  producto VARCHAR(50),
  cantidad INT,
  precio DECIMAL(10,2),
  fecha_pedido DATE,
  FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- 100 clientes
INSERT INTO clientes (nombre, email, ciudad)
WITH RECURSIVE n AS (SELECT 1 AS i UNION ALL SELECT i+1 FROM n WHERE i < 100)
SELECT CONCAT('Cliente ', i),
       CONCAT('cliente', i, '@ejemplo.com'),
       ELT(1 + MOD(i,5), 'Sevilla','Madrid','Barcelona','Valencia','Bilbao')
FROM n;

-- 1000 pedidos
INSERT INTO pedidos (id_cliente, producto, cantidad, precio, fecha_pedido)
WITH RECURSIVE n AS (SELECT 1 AS i UNION ALL SELECT i+1 FROM n WHERE i < 1000)
SELECT 1 + MOD(i,100),
       ELT(1 + MOD(i,5), 'Portatil','Raton','Teclado','Monitor','Auriculares'),
       1 + MOD(i,10),
       ROUND(10 + MOD(i*7, 490), 2),
       DATE_ADD('2025-01-01', INTERVAL MOD(i,300) DAY)
FROM n;

