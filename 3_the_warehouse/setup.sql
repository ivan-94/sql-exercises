-- 清理
DROP TABLE IF EXISTS warehouses, boxes;

-- 仓库
CREATE TABLE warehouses (
    code serial PRIMARY KEY,
    location text NOT NULL,
    capacity integer CHECK (capacity > 0) NOT NULL
);

-- 箱子
CREATE TABLE boxes (
    code text PRIMARY KEY,
    contents text NOT NULL,
    value real NOT NULL,
    warehouse integer REFERENCES warehouses(code) NOT NULL
);


-- sample
INSERT INTO warehouses(code,location,capacity) VALUES(1,'Chicago',3);
INSERT INTO warehouses(code,location,capacity) VALUES(2,'Chicago',4);
INSERT INTO warehouses(code,location,capacity) VALUES(3,'New York',7);
INSERT INTO warehouses(code,location,capacity) VALUES(4,'Los Angeles',2);
INSERT INTO warehouses(code,location,capacity) VALUES(5,'San Francisco',8);

INSERT INTO boxes(code,contents,value,warehouse) VALUES('0MN7','Rocks',180,3);
INSERT INTO boxes(code,contents,value,warehouse) VALUES('4H8P','Rocks',250,1);
INSERT INTO boxes(code,contents,value,warehouse) VALUES('4RT3','Scissors',190,4);
INSERT INTO boxes(code,contents,value,warehouse) VALUES('7G3H','Rocks',200,1);
INSERT INTO boxes(code,contents,value,warehouse) VALUES('8JN6','Papers',75,1);
INSERT INTO boxes(code,contents,value,warehouse) VALUES('8Y6U','Papers',50,3);
INSERT INTO boxes(code,contents,value,warehouse) VALUES('9J6F','Papers',175,2);
INSERT INTO boxes(code,contents,value,warehouse) VALUES('LL08','Rocks',140,4);
INSERT INTO boxes(code,contents,value,warehouse) VALUES('P0H6','Scissors',125,1);
INSERT INTO boxes(code,contents,value,warehouse) VALUES('P2T6','Scissors',150,2);
INSERT INTO boxes(code,contents,value,warehouse) VALUES('TU55','Papers',90,5);