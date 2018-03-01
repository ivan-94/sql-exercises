-- 清理
DROP TABLE IF EXISTS departments, employees;

-- 部门
CREATE TABLE departments (
    code serial PRIMARY KEY,
    name text NOT NULL UNIQUE,
    budget real
);

-- 员工
CREATE TABLE employees (
    ssn serial PRIMARY KEY,
    name text NOT NULL,
    last_name text NOT NULL,
    department integer NOT NULL REFERENCES departments(code)
);

-- samples
INSERT INTO departments(code,name,budget) VALUES(14,'IT',65000);
INSERT INTO departments(code,name,budget) VALUES(37,'Accounting',15000);
INSERT INTO departments(code,name,budget) VALUES(59,'Human Resources',240000);
INSERT INTO departments(code,name,budget) VALUES(77,'Research',55000);

INSERT INTO employees(ssn,name,last_name,department) VALUES('123234877','Michael','Rogers',14);
INSERT INTO employees(ssn,name,last_name,department) VALUES('152934485','Anand','Manikutty',14);
INSERT INTO employees(ssn,name,last_name,department) VALUES('222364883','Carol','Smith',37);
INSERT INTO employees(ssn,name,last_name,department) VALUES('326587417','Joe','Stevens',37);
INSERT INTO employees(ssn,name,last_name,department) VALUES('332154719','Mary-Anne','Foster',14);
INSERT INTO employees(ssn,name,last_name,department) VALUES('332569843','George','O''Donnell',77);
INSERT INTO employees(ssn,name,last_name,department) VALUES('546523478','John','Doe',59);
INSERT INTO employees(ssn,name,last_name,department) VALUES('631231482','David','Smith',77);
INSERT INTO employees(ssn,name,last_name,department) VALUES('654873219','Zacary','Efron',59);
INSERT INTO employees(ssn,name,last_name,department) VALUES('745685214','Eric','Goldsmith',59);
INSERT INTO employees(ssn,name,last_name,department) VALUES('845657245','Elizabeth','Doe',14);
INSERT INTO employees(ssn,name,last_name,department) VALUES('845657246','Kumar','Swamy',14);