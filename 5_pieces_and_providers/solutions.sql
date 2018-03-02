-- https://en.wikibooks.org/wiki/SQL_Exercises/Pieces_and_providers
-- 5.1 Select the name of all the pieces. 
SELECT name FROM pieces;


-- 5.2  Select all the providers' data. 
SELECT * FROM providers;


-- 5.3 Obtain the average price of each piece (show only the piece code and the average price).
SELECT piece, AVG(price)
FROM provides
GROUP BY piece;


-- 5.4  Obtain the names of all providers who supply piece 1.
SELECT name
FROM providers, provides
WHERE providers.code = provides.provider
  AND provides.piece = 1;
-- or
SELECT name
FROM providers
WHERE code IN (SELECT provider FROM provides WHERE piece = 1);


-- 5.5 Select the name of pieces provided by provider with code "HAL".
SELECT name
FROM pieces, provides
WHERE pieces.code = provides.piece
  AND provides.provider = 'HAL';
-- or
SELECT name
FROM pieces
WHERE code IN (SELECT piece FROM provides WHERE provider = 'HAL');


-- 5.6 -- For each piece, find the most expensive offering of that piece and include the piece name, provider name, and price 
-- (note that there could be two providers who supply the same piece at the most expensive price).
SELECT O.name, Q.name, P.price
FROM pieces AS O, provides AS P, providers AS Q
WHERE O.code = P.piece
  AND P.provider = Q.code
  AND P.price = (SELECT MAX(price)
                FROM provides
                WHERE O.code = piece
               );
-- or
SELECT pieces.name, providers.name, price
FROM pieces INNER JOIN provides ON pieces.code = provides.piece
            INNER JOIN providers ON provides.provider = providers.code
WHERE price = (SELECT MAX(price) FROM provides
               WHERE piece = pieces.code);


-- 5.7 Add an entry to the database to indicate that "Skellington Supplies" (code "TNBC") will provide sprockets (code "1") for 7 cents each.
INSERT INTO providers(code, name) VALUES('TNBC', 'Skellington Supplies');
INSERT INTO pieces(code, name) VALUES(1, 'sprockets');
INSERT INTO provides(piece, provider, price) VALUES(1, 'TNBC', 7);

-- 5.8 Increase all prices by one cent.
UPDATE provides SET price = price + 1;


-- 5.9 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply bolts (code 4).
DELETE FROM provides
  WHERE provider = 'RBT' AND piece = '4';

-- 5.10 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply any pieces 
    -- (the provider should still remain in the database).
DELETE FROM provides
  WHERE provider = 'RBT';