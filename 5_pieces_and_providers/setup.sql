-- 清理
DROP TABLE IF EXISTS providers, provides, pieces;

CREATE TABLE providers (
    code text PRIMARY KEY,
    name text NOT NULL
);

CREATE TABLE pieces (
    code serial PRIMARY KEY,
    name text NOT NULL
);

-- 定义多对多关系
CREATE TABLE provides (
    piece integer 
      REFERENCES pieces(code)
      ON UPDATE CASCADE,
    provider text
      REFERENCES providers(code)
      ON UPDATE CASCADE,
    price double precision NOT NULL,
    PRIMARY KEY(piece, provider)
);

-- samples
 INSERT INTO providers(code, name) VALUES('HAL','Clarke Enterprises');
 INSERT INTO providers(code, name) VALUES('RBT','Susan Calvin Corp.');
 INSERT INTO providers(code, name) VALUES('TNBC','Skellington Supplies');
 
 INSERT INTO pieces(code, name) VALUES(1,'Sprocket');
 INSERT INTO pieces(code, name) VALUES(2,'Screw');
 INSERT INTO pieces(code, name) VALUES(3,'Nut');
 INSERT INTO pieces(code, name) VALUES(4,'Bolt');
 
 INSERT INTO provides(piece, provider, price) VALUES(1,'HAL',10);
 INSERT INTO provides(piece, provider, price) VALUES(1,'RBT',15);
 INSERT INTO provides(piece, provider, price) VALUES(2,'HAL',20);
 INSERT INTO provides(piece, provider, price) VALUES(2,'RBT',15);
 INSERT INTO provides(piece, provider, price) VALUES(2,'TNBC',14);
 INSERT INTO provides(piece, provider, price) VALUES(3,'RBT',50);
 INSERT INTO provides(piece, provider, price) VALUES(3,'TNBC',45);
 INSERT INTO provides(piece, provider, price) VALUES(4,'HAL',5);
 INSERT INTO provides(piece, provider, price) VALUES(4,'RBT',7);