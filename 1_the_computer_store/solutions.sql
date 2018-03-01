-- 1.1 Select the names of all the products in the store.
SELECT name FROM products;


-- 1.2 Select the names and the prices of all the products in the store.
SELECT name, price FROM products;


-- 1.3 Select the name of the products with a price less than or equal to $200.
SELECT name FROM products WHERE price <= 200;


-- 1.4 Select all the products with a price between $60 and $120.
SELECT * FROM products WHERE price >= 60 AND price <= 120;
-- or
SELECT * FROM products WHERE price BETWEEN 60 AND 120;


-- 1.5 Select the name and price in cents (i.e., the price must be multiplied by 100).
SELECT name, (price * 100) AS price_in_cents FROM products;


-- 1.6 Compute the average price of all the products.
SELECT AVG(price) FROM products;


-- 1.7 Compute the average price of all products with manufacturer code equal to 2.
SELECT AVG(price) FROM products WHERE manufacturer = 2;


-- 1.8 Compute the number of products with a price larger than or equal to $180.
SELECT COUNT(price) FROM products WHERE price >= 180;


-- 1.9 Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).
SELECT name, price
FROM products 
WHERE price >= 180
ORDER BY price DESC, name;


-- 1.10 Select all the data from the products, including all the data for each product's manufacturer.
SELECT * 
FROM products, manufacturers
WHERE products.manufacturer = manufacturers.code;
-- or
SELECT *
FROM products INNER JOIN manufacturers
ON products.manufacturer = manufacturers.code;


-- 1.11 Select the product name, price, and manufacturer name of all the products.
SELECT products.name, price, manufacturers.name AS manufacturer_name
FROM products, manufacturers
WHERE products.manufacturer = manufacturers.code;
-- or
SELECT products.name, price, manufacturers.name AS manufacturer_name
FROM products INNER JOIN manufacturers
ON products.manufacturer = manufacturers.code;


-- 1.12 Select the average price of each manufacturer's products, showing only the manufacturer's code.
SELECT manufacturer, AVG(price)
FROM products
GROUP BY manufacturer;


-- 1.13 Select the average price of each manufacturer's products, showing the manufacturer's name.
SELECT manufacturers.name, AVG(price)
FROM products, manufacturers
WHERE products.manufacturer = manufacturers.code
GROUP BY manufacturers.name;
-- or
SELECT manufacturers.name, AVG(price)
FROM products INNER JOIN manufacturers
ON products.manufacturer = manufacturers.code
GROUP BY manufacturers.name;


-- 1.14 Select the names of manufacturer whose products have an average price larger than or equal to $150.
SELECT manufacturers.name
FROM products, manufacturers
WHERE products.manufacturer = manufacturers.code
GROUP BY manufacturers.name
HAVING AVG(price) >= 150;
-- or
SELECT manufacturers.name
FROM products INNER JOIN manufacturers
ON products.manufacturer = manufacturers.code
GROUP BY manufacturers.name
HAVING AVG(price) >= 150;


-- 1.15 Select the name and price of the cheapest product.
SELECT name, price
FROM products
ORDER BY price 
LIMIT 1;
-- or
SELECT name, price
FROM products
WHERE price = (SELECT MIN(price) FROM products);


-- 1.16 Select the name of each manufacturer along with the name and price of its most expensive product.
SELECT P.name, M.name, P.price
FROM products AS P, manufacturers AS M
WHERE P.manufacturer = M.code
  AND P.price = (SELECT MAX(P.price)
                 FROM products AS P 
                 WHERE P.manufacturer = M.code);
-- or
SELECT P.name, M.name, P.price
FROM products AS P INNER JOIN manufacturers AS M
ON P.manufacturer = M.code
  AND P.price = (SELECT MAX(P.price)
                 FROM products AS P 
                 WHERE P.manufacturer = M.code);


-- 1.17 Add a new product: Loudspeakers, $70, manufacturer 2.
INSERT INTO products (name, price, manufacturer) VALUES('Loudspeakers', 70, 2);


-- 1.18 Update the name of product 8 to "Laser Printer".
UPDATE products
SET name = 'Laser Printer'
WHERE code = 8;


-- 1.19 Apply a 10% discount to all products.
UPDATE products
SET price = price * 0.9;


-- 1.20 Apply a 10% discount to all products with a price larger than or equal to $120.
UPDATE products
SET price = price * 0.9
WHERE price >= 120;