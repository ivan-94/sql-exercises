-- clear
DROP TABLE IF EXISTS scientists, assigned_to, projects;

CREATE TABLE scientists
(
  ssn serial PRIMARY KEY,
  name text NOT NULL
);

CREATE TABLE projects
(
  code text PRIMARY KEY,
  name text NOT NULL,
  hours integer NOT NULL
);

-- 实现多不多
CREATE TABLE assigned_to
(
  scientist integer REFERENCES scientists(ssn),
  project text REFERENCES projects(code),
  PRIMARY KEY(scientist, project)
);

-- samples

INSERT INTO scientists
  (ssn, name)
VALUES(123234877, 'Michael Rogers'),
  (152934485, 'Anand Manikutty'),
  (222364883, 'Carol Smith'),
  (326587417, 'Joe Stevens'),
  (332154719, 'Mary-Anne Foster'),
  (332569843, 'George ODonnell'),
  (546523478, 'John Doe'),
  (631231482, 'David Smith'),
  (654873219, 'Zacary Efron'),
  (745685214, 'Eric Goldsmith'),
  (845657245, 'Elizabeth Doe'),
  (845657246, 'Kumar Swamy');
INSERT INTO projects
  (code,name,hours)
VALUES
  ('AeH1', 'Winds: Studying Bernoullis Principle', 156),
  ('AeH2', 'Aerodynamics and Bridge Design', 189),
  ('AeH3', 'Aerodynamics and Gas Mileage', 256),
  ('AeH4', 'Aerodynamics and Ice Hockey', 789),
  ('AeH5', 'Aerodynamics of a Football', 98),
  ('AeH6', 'Aerodynamics of Air Hockey', 89),
  ('Ast1', 'A Matter of Time', 112),
  ('Ast2', 'A Puzzling Parallax', 299),
  ('Ast3', 'Build Your Own Telescope', 6546),
  ('Bte1', 'Juicy: Extracting Apple Juice with Pectinase', 321),
  ('Bte2', 'A Magnetic Primer Designer', 9684),
  ('Bte3', 'Bacterial Transformation Efficiency', 321),
  ('Che1', 'A Silver-Cleaning Battery', 545),
  ('Che2', 'A Soluble Separation Solution', 778);
INSERT INTO assigned_to
  (scientist, project)
VALUES
  (123234877, 'AeH1'),
  (152934485, 'AeH3'),
  (222364883, 'Ast3'),
  (326587417, 'Ast3'),
  (332154719, 'Bte1'),
  (546523478, 'Che1'),
  (631231482, 'Ast3'),
  (654873219, 'Che1'),
  (745685214, 'AeH3'),
  (845657245, 'Ast1'),
  (845657246, 'Ast2'),
  (332569843, 'AeH4');