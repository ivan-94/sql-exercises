-- clean
DROP TABLE IF EXISTS
physicians,
departments,
affiliated_with,
procedures,
trained_in,
patients,
nurses,
appointments,
medications,
prescribes,
blocks,
on_call,
rooms,
staies,
undergoes;

-- 医师
CREATE TABLE physicians (
  id serial PRIMARY KEY,
  name text NOT NULL,
  position text NOT NULL,
  ssn integer NOT NULL
);

-- 部门
CREATE TABLE departments (
  id serial PRIMARY KEY,
  name text NOT NULL,
  -- 部门主管
  head integer NOT NULL REFERENCES physicians(id)
);

-- 医师和部门的关系, 多对多
CREATE TABLE affiliated_with (
  physician integer NOT NULL REFERENCES physicians(id),
  department integer NOT NULL REFERENCES departments(id),
  -- 主要隶属
  primary_affiliation boolean DEFAULT FALSE,
  PRIMARY KEY(physician, department)
);

-- 手续
CREATE TABLE procedures (
  code serial PRIMARY KEY,
  name text NOT NULL,
  cost double precision NOT NULL
);

-- 就诊, 一个手续可以经过多个医师就诊, 一个医生可以就诊多个手续
CREATE TABLE trained_in (
  physician integer NOT NULL REFERENCES physicians(id),
  treatment integer NOT NULL REFERENCES procedures(code),
  -- 单据时间
  certification_date timestamp NOT NULL,
  certification_expires timestamp NOT NULL,
  PRIMARY KEY(physician, treatment)
);

-- 患者
CREATE TABLE patients (
  ssn serial PRIMARY KEY,
  name text NOT NULL,
  address text NOT NULL,
  phone text NOT NULL,
  -- 保险
  insuranceID integer,
  -- 主治医生
  PCP integer NOT NULL REFERENCES physicians(id)
);

-- 护士
CREATE TABLE nurses (
  id serial PRIMARY KEY,
  name text NOT NULL,
  position text NOT NULL,
  registered boolean DEFAULT FALSE,
  ssn integer NOT NULL
);

-- 会诊
CREATE TABLE appointments(
  id serial PRIMARY KEY,
  patient integer NOT NULL REFERENCES patients(ssn),
  prepnurse integer REFERENCES nurses(id),
  physician integer NOT NULL REFERENCES physicians(id),
  date_start timestamp NOT NULL,
  date_end timestamp NOT NULL,
  examination_room text NOT NULL
);

-- 药物
CREATE TABLE medications (
  code serial PRIMARY KEY,
  name text NOT NULL,
  brand text NOT NULL,
  description text
);

-- 药方
CREATE TABLE prescribes (
  physician integer NOT NULL REFERENCES physicians(id),
  patient integer NOT NULL REFERENCES patients(ssn),
  medication integer NOT NULL REFERENCES medications(code),
  date timestamp NOT NULL,
  -- 会诊
  appointment integer REFERENCES appointments(id),
  -- 剂量
  dose text,
  PRIMARY KEY(physician, patient, medication, date)
);

-- 区域
CREATE TABLE blocks (
  -- 楼层
  floor integer NOT NULL,
  -- 区域
  code integer NOT NULL,
  PRIMARY KEY(floor, code)
);

-- 护士负责表
CREATE TABLE on_call (
  nurse integer NOT NULL REFERENCES nurses(id),
  -- 区域
  block_floor integer NOT NULL,
  block_code integer NOT NULL,
  date_start timestamp NOT NULL,
  date_end timestamp NOT NULL,
  PRIMARY KEY(nurse, block_floor, block_code, date_start, date_end),
  FOREIGN KEY (block_floor, block_code) REFERENCES blocks(floor, code)
);

-- 病房
CREATE TABLE rooms (
  number serial PRIMARY KEY,
  type text NOT NULL,
  -- 所属区域
  block_floor integer NOT NULL,
  block_code integer NOT NULL,
  unavailable boolean DEFAULT FALSE,
  FOREIGN KEY (block_floor, block_code) REFERENCES blocks(floor, code)
);

-- 病房占用表
CREATE TABLE staies (
  id serial PRIMARY KEY,
  patient integer NOT NULL REFERENCES patients(ssn),
  room integer NOT NULL REFERENCES rooms(number),
  date_start timestamp NOT NULL,
  date_end timestamp NOT NULL
);

-- 病例
CREATE TABLE undergoes (
  patient integer NOT NULL REFERENCES patients(ssn),
  procedure integer NOT NULL REFERENCES procedures(code),
  -- 有些不需要住院
  stay integer REFERENCES staies(id),
  date timestamp NOT NULL,
  physician integer NOT NULL REFERENCES physicians(id),
  assisting_nurse integer REFERENCES nurses(id),
  PRIMARY KEY(patient, procedure, stay, date)
);


-- samples
INSERT INTO physicians VALUES(1,'John Dorian','Staff Internist',111111111);
INSERT INTO physicians VALUES(2,'Elliot Reid','Attending physicians',222222222);
INSERT INTO physicians VALUES(3,'Christopher Turk','Surgical Attending physicians',333333333);
INSERT INTO physicians VALUES(4,'Percival Cox','Senior Attending physicians',444444444);
INSERT INTO physicians VALUES(5,'Bob Kelso','Head Chief of Medicine',555555555);
INSERT INTO physicians VALUES(6,'Todd Quinlan','Surgical Attending physicians',666666666);
INSERT INTO physicians VALUES(7,'John Wen','Surgical Attending physicians',777777777);
INSERT INTO physicians VALUES(8,'Keith Dudemeister','MD Resident',888888888);
INSERT INTO physicians VALUES(9,'Molly Clock','Attending Psychiatrist',999999999);

INSERT INTO departments VALUES(1,'General Medicine',4);
INSERT INTO departments VALUES(2,'Surgery',7);
INSERT INTO departments VALUES(3,'Psychiatry',9);

INSERT INTO affiliated_with VALUES(1,1,TRUE);
INSERT INTO affiliated_with VALUES(2,1,TRUE);
INSERT INTO affiliated_with VALUES(3,1,FALSE);
INSERT INTO affiliated_with VALUES(3,2,TRUE);
INSERT INTO affiliated_with VALUES(4,1,TRUE);
INSERT INTO affiliated_with VALUES(5,1,TRUE);
INSERT INTO affiliated_with VALUES(6,2,TRUE);
INSERT INTO affiliated_with VALUES(7,1,FALSE);
INSERT INTO affiliated_with VALUES(7,2,TRUE);
INSERT INTO affiliated_with VALUES(8,1,TRUE);
INSERT INTO affiliated_with VALUES(9,3,TRUE);

INSERT INTO procedures VALUES(1,'Reverse Rhinopodoplasty',1500.0);
INSERT INTO procedures VALUES(2,'Obtuse Pyloric Recombobulation',3750.0);
INSERT INTO procedures VALUES(3,'Folded Demiophtalmectomy',4500.0);
INSERT INTO procedures VALUES(4,'Complete Walletectomy',10000.0);
INSERT INTO procedures VALUES(5,'Obfuscated Dermogastrotomy',4899.0);
INSERT INTO procedures VALUES(6,'Reversible Pancreomyoplasty',5600.0);
INSERT INTO procedures VALUES(7,'Follicular Demiectomy',25.0);

INSERT INTO patients VALUES(100000001,'John Smith','42 Foobar Lane','555-0256',68476213,1);
INSERT INTO patients VALUES(100000002,'Grace Ritchie','37 Snafu Drive','555-0512',36546321,2);
INSERT INTO patients VALUES(100000003,'Random J. patients','101 Omgbbq Street','555-1204',65465421,2);
INSERT INTO patients VALUES(100000004,'Dennis Doe','1100 Foobaz Avenue','555-2048',68421879,3);

INSERT INTO nurses VALUES(101,'Carla Espinosa','Head nurses',TRUE,111111110);
INSERT INTO nurses VALUES(102,'Laverne Roberts','nurses',TRUE,222222220);
INSERT INTO nurses VALUES(103,'Paul Flowers','nurses',FALSE,333333330);

INSERT INTO appointments VALUES(13216584,100000001,101,1,'2008-04-24 10:00','2008-04-24 11:00','A');
INSERT INTO appointments VALUES(26548913,100000002,101,2,'2008-04-24 10:00','2008-04-24 11:00','B');
INSERT INTO appointments VALUES(36549879,100000001,102,1,'2008-04-25 10:00','2008-04-25 11:00','A');
INSERT INTO appointments VALUES(46846589,100000004,103,4,'2008-04-25 10:00','2008-04-25 11:00','B');
INSERT INTO appointments VALUES(59871321,100000004,NULL,4,'2008-04-26 10:00','2008-04-26 11:00','C');
INSERT INTO appointments VALUES(69879231,100000003,103,2,'2008-04-26 11:00','2008-04-26 12:00','C');
INSERT INTO appointments VALUES(76983231,100000001,NULL,3,'2008-04-26 12:00','2008-04-26 13:00','C');
INSERT INTO appointments VALUES(86213939,100000004,102,9,'2008-04-27 10:00','2008-04-21 11:00','A');
INSERT INTO appointments VALUES(93216548,100000002,101,2,'2008-04-27 10:00','2008-04-27 11:00','B');

INSERT INTO medications VALUES(1,'Procrastin-X','X','N/A');
INSERT INTO medications VALUES(2,'Thesisin','Foo Labs','N/A');
INSERT INTO medications VALUES(3,'Awakin','Bar Laboratories','N/A');
INSERT INTO medications VALUES(4,'Crescavitin','Baz Industries','N/A');
INSERT INTO medications VALUES(5,'Melioraurin','Snafu Pharmaceuticals','N/A');

INSERT INTO prescribes VALUES(1,100000001,1,'2008-04-24 10:47',13216584,'5');
INSERT INTO prescribes VALUES(9,100000004,2,'2008-04-27 10:53',86213939,'10');
INSERT INTO prescribes VALUES(9,100000004,2,'2008-04-30 16:53',NULL,'5');

INSERT INTO blocks VALUES(1,1);
INSERT INTO blocks VALUES(1,2);
INSERT INTO blocks VALUES(1,3);
INSERT INTO blocks VALUES(2,1);
INSERT INTO blocks VALUES(2,2);
INSERT INTO blocks VALUES(2,3);
INSERT INTO blocks VALUES(3,1);
INSERT INTO blocks VALUES(3,2);
INSERT INTO blocks VALUES(3,3);
INSERT INTO blocks VALUES(4,1);
INSERT INTO blocks VALUES(4,2);
INSERT INTO blocks VALUES(4,3);

INSERT INTO rooms VALUES(101,'Single',1,1,FALSE);
INSERT INTO rooms VALUES(102,'Single',1,1,FALSE);
INSERT INTO rooms VALUES(103,'Single',1,1,FALSE);
INSERT INTO rooms VALUES(111,'Single',1,2,FALSE);
INSERT INTO rooms VALUES(112,'Single',1,2,TRUE);
INSERT INTO rooms VALUES(113,'Single',1,2,FALSE);
INSERT INTO rooms VALUES(121,'Single',1,3,FALSE);
INSERT INTO rooms VALUES(122,'Single',1,3,FALSE);
INSERT INTO rooms VALUES(123,'Single',1,3,FALSE);
INSERT INTO rooms VALUES(201,'Single',2,1,TRUE);
INSERT INTO rooms VALUES(202,'Single',2,1,FALSE);
INSERT INTO rooms VALUES(203,'Single',2,1,FALSE);
INSERT INTO rooms VALUES(211,'Single',2,2,FALSE);
INSERT INTO rooms VALUES(212,'Single',2,2,FALSE);
INSERT INTO rooms VALUES(213,'Single',2,2,TRUE);
INSERT INTO rooms VALUES(221,'Single',2,3,FALSE);
INSERT INTO rooms VALUES(222,'Single',2,3,FALSE);
INSERT INTO rooms VALUES(223,'Single',2,3,FALSE);
INSERT INTO rooms VALUES(301,'Single',3,1,FALSE);
INSERT INTO rooms VALUES(302,'Single',3,1,TRUE);
INSERT INTO rooms VALUES(303,'Single',3,1,FALSE);
INSERT INTO rooms VALUES(311,'Single',3,2,FALSE);
INSERT INTO rooms VALUES(312,'Single',3,2,FALSE);
INSERT INTO rooms VALUES(313,'Single',3,2,FALSE);
INSERT INTO rooms VALUES(321,'Single',3,3,TRUE);
INSERT INTO rooms VALUES(322,'Single',3,3,FALSE);
INSERT INTO rooms VALUES(323,'Single',3,3,FALSE);
INSERT INTO rooms VALUES(401,'Single',4,1,FALSE);
INSERT INTO rooms VALUES(402,'Single',4,1,TRUE);
INSERT INTO rooms VALUES(403,'Single',4,1,FALSE);
INSERT INTO rooms VALUES(411,'Single',4,2,FALSE);
INSERT INTO rooms VALUES(412,'Single',4,2,FALSE);
INSERT INTO rooms VALUES(413,'Single',4,2,FALSE);
INSERT INTO rooms VALUES(421,'Single',4,3,TRUE);
INSERT INTO rooms VALUES(422,'Single',4,3,FALSE);
INSERT INTO rooms VALUES(423,'Single',4,3,FALSE);

INSERT INTO on_call VALUES(101,1,1,'2008-11-04 11:00','2008-11-04 19:00');
INSERT INTO on_call VALUES(101,1,2,'2008-11-04 11:00','2008-11-04 19:00');
INSERT INTO on_call VALUES(102,1,3,'2008-11-04 11:00','2008-11-04 19:00');
INSERT INTO on_call VALUES(103,1,1,'2008-11-04 19:00','2008-11-05 03:00');
INSERT INTO on_call VALUES(103,1,2,'2008-11-04 19:00','2008-11-05 03:00');
INSERT INTO on_call VALUES(103,1,3,'2008-11-04 19:00','2008-11-05 03:00');

INSERT INTO staies VALUES(3215,100000001,111,'2008-05-01','2008-05-04');
INSERT INTO staies VALUES(3216,100000003,123,'2008-05-03','2008-05-14');
INSERT INTO staies VALUES(3217,100000004,112,'2008-05-02','2008-05-03');

INSERT INTO undergoes VALUES(100000001,6,3215,'2008-05-02',3,101);
INSERT INTO undergoes VALUES(100000001,2,3215,'2008-05-03',7,101);
INSERT INTO undergoes VALUES(100000004,1,3217,'2008-05-07',3,102);
INSERT INTO undergoes VALUES(100000004,5,3217,'2008-05-09',6,NULL);
INSERT INTO undergoes VALUES(100000001,7,3217,'2008-05-10',7,101);
INSERT INTO undergoes VALUES(100000004,4,3217,'2008-05-13',3,103);

INSERT INTO trained_in VALUES(3,1,'2008-01-01','2008-12-31');
INSERT INTO trained_in VALUES(3,2,'2008-01-01','2008-12-31');
INSERT INTO trained_in VALUES(3,5,'2008-01-01','2008-12-31');
INSERT INTO trained_in VALUES(3,6,'2008-01-01','2008-12-31');
INSERT INTO trained_in VALUES(3,7,'2008-01-01','2008-12-31');
INSERT INTO trained_in VALUES(6,2,'2008-01-01','2008-12-31');
INSERT INTO trained_in VALUES(6,5,'2007-01-01','2007-12-31');
INSERT INTO trained_in VALUES(6,6,'2008-01-01','2008-12-31');
INSERT INTO trained_in VALUES(7,1,'2008-01-01','2008-12-31');
INSERT INTO trained_in VALUES(7,2,'2008-01-01','2008-12-31');
INSERT INTO trained_in VALUES(7,3,'2008-01-01','2008-12-31');
INSERT INTO trained_in VALUES(7,4,'2008-01-01','2008-12-31');
INSERT INTO trained_in VALUES(7,5,'2008-01-01','2008-12-31');
INSERT INTO trained_in VALUES(7,6,'2008-01-01','2008-12-31');
INSERT INTO trained_in VALUES(7,7,'2008-01-01','2008-12-31');