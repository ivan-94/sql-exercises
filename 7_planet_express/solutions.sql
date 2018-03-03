-- https://en.wikibooks.org/wiki/SQL_Exercises/Planet_Express 
-- 7.1 Who receieved a 1.5kg package?
    -- The result is "Al Gore's Head".
SELECT name
FROM clients, packages
WHERE clients.number = packages.recipient
  AND packages.weight = 1.5;


-- 7.2 What is the total weight of all the packages that he sent?
SELECT SUM(weight)
FROM packages
WHERE packages.sender = (SELECT name
                          FROM clients, packages
                          WHERE clients.number = packages.recipient
                            AND packages.weight = 1.5);


-- 7.3 Which pilots transported those packages?
SELECT E.name
FROM clients AS C 
  INNER JOIN packages AS P 
    ON C.number = P.sender AND C.name = 'Al Gore''s Head'  -- As Above
  INNER JOIN shipments AS S 
    ON P.shipment = S.id
  INNER JOIN employees AS E 
    ON S.manager = E.id;