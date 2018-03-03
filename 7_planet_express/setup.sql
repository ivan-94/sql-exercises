-- clear
DROP TABLE IF EXISTS employees, planets, has_clearance, clients, packages, shipments;
-- 员工
CREATE TABLE employees
(
  id serial PRIMARY KEY,
  name text NOT NULL,
  -- 职位
  position text NOT NULL,
  -- 薪水
  salary text NOT NULL,
  remarks text
);
-- 星球
CREATE TABLE planets
(
  id serial PRIMARY KEY,
  name text NOT NULL,
  coordinates real NOT NULL
);
-- 表达员工和星球的关系, 多对多
CREATE TABLE has_clearance
(
  employee_id integer NOT NULL REFERENCES employees(id),
  planet_id integer NOT NULL REFERENCES planets(id),
  level integer NOT NULL,
  PRIMARY KEY(employee_id, planet_id)
);
-- 客户
CREATE TABLE clients
(
  number serial PRIMARY KEY,
  name text NOT NULL
);
-- 货仓
CREATE TABLE shipments
(
  id serial PRIMARY KEY,
  date text,
  manager integer NOT NULL REFERENCES employees(id),
  planet_id integer NOT NULL REFERENCES planets(id)
);
-- 包裹
CREATE TABLE packages
(
  shipment integer NOT NULL REFERENCES shipments(id),
  number text NOT NULL,
  contents text NOT NULL,
  weight real NOT NULL,
  sender integer NOT NULL REFERENCES clients(number),
  recipient integer NOT NULL REFERENCES clients(number),
  PRIMARY KEY(shipment, number)
);


-- samples
INSERT INTO clients VALUES(1, 'Zapp Brannigan');
INSERT INTO clients VALUES(2, 'Al Gore''s Head');
INSERT INTO clients VALUES(3, 'Barbados Slim');
INSERT INTO clients VALUES(4, 'Ogden Wernstrom');
INSERT INTO clients VALUES(5, 'Leo Wong');
INSERT INTO clients VALUES(6, 'Lrrr');
INSERT INTO clients VALUES(7, 'John Zoidberg');
INSERT INTO clients VALUES(8, 'John Zoidfarb');
INSERT INTO clients VALUES(9, 'Morbo');
INSERT INTO clients VALUES(10, 'Judge John Whitey');
INSERT INTO clients VALUES(11, 'Calculon');
INSERT INTO employees VALUES(1, 'Phillip J. Fry', 'Delivery boy', 7500.0, 'Not to be confused with the Philip J. Fry from Hovering Squid World 97a');
INSERT INTO employees VALUES(2, 'Turanga Leela', 'Captain', 10000.0, NULL);
INSERT INTO employees VALUES(3, 'Bender Bending Rodriguez', 'Robot', 7500.0, NULL);
INSERT INTO employees VALUES(4, 'Hubert J. Farnsworth', 'CEO', 20000.0, NULL);
INSERT INTO employees VALUES(5, 'John A. Zoidberg', 'Physician', 25.0, NULL);
INSERT INTO employees VALUES(6, 'Amy Wong', 'Intern', 5000.0, NULL);
INSERT INTO employees VALUES(7, 'Hermes Conrad', 'Bureaucrat', 10000.0, NULL);
INSERT INTO employees VALUES(8, 'Scruffy Scruffington', 'Janitor', 5000.0, NULL);
INSERT INTO planets VALUES(1, 'Omicron Persei 8', 89475345.3545);
INSERT INTO planets VALUES(2, 'Decapod X', 65498463216.3466);
INSERT INTO planets VALUES(3, 'Mars', 32435021.65468);
INSERT INTO planets VALUES(4, 'Omega III', 98432121.5464);
INSERT INTO planets VALUES(5, 'Tarantulon VI', 849842198.354654);
INSERT INTO planets VALUES(6, 'Cannibalon', 654321987.21654);
INSERT INTO planets VALUES(7, 'DogDoo VII', 65498721354.688);
INSERT INTO planets VALUES(8, 'Nintenduu 64', 6543219894.1654);
INSERT INTO planets VALUES(9, 'Amazonia', 65432135979.6547);
INSERT INTO has_clearance VALUES(1, 1, 2);
INSERT INTO has_clearance VALUES(1, 2, 3);
INSERT INTO has_clearance VALUES(2, 3, 2);
INSERT INTO has_clearance VALUES(2, 4, 4);
INSERT INTO has_clearance VALUES(3, 5, 2);
INSERT INTO has_clearance VALUES(3, 6, 4);
INSERT INTO has_clearance VALUES(4, 7, 1);
INSERT INTO shipments VALUES(1, '3004/05/11', 1, 1);
INSERT INTO shipments VALUES(2, '3004/05/11', 1, 2);
INSERT INTO shipments VALUES(3, NULL, 2, 3);
INSERT INTO shipments VALUES(4, NULL, 2, 4);
INSERT INTO shipments VALUES(5, NULL, 7, 5);
INSERT INTO packages VALUES(1, 1, 'Undeclared', 1.5, 1, 2);
INSERT INTO packages VALUES(2, 1, 'Undeclared', 10.0, 2, 3);
INSERT INTO packages VALUES(2, 2, 'A bucket of krill', 2.0, 8, 7);
INSERT INTO packages VALUES(3, 1, 'Undeclared', 15.0, 3, 4);
INSERT INTO packages VALUES(3, 2, 'Undeclared', 3.0, 5, 1);
INSERT INTO packages VALUES(3, 3, 'Undeclared', 7.0, 2, 3);
INSERT INTO packages VALUES(4, 1, 'Undeclared', 5.0, 4, 5);
INSERT INTO packages VALUES(4, 2, 'Undeclared', 27.0, 1, 2);
INSERT INTO packages VALUES(5, 1, 'Undeclared', 100.0, 5, 1);