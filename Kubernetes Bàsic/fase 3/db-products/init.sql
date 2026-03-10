CREATE DATABASE IF NOT EXISTS productsdb;
USE productsdb;

CREATE TABLE IF NOT EXISTS products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  price DECIMAL(10,2) NOT NULL,
  stock INT NOT NULL
);

INSERT INTO products (name, price, stock) VALUES
('Teclat mecànic', 59.99, 10),
('Ratolí gaming', 29.99, 20),
('Auriculars', 39.99, 15);
