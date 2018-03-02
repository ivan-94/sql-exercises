-- 清理
DROP TABLE IF EXISTS movies, theaters;

CREATE TABLE movies (
    code serial PRIMARY KEY,
    title text NOT NULL,
    rating text
);

CREATE TABLE theaters (
    code serial PRIMARY KEY,
    name text NOT NULL,
    movie integer REFERENCES movies(code)
);


-- samples
 INSERT INTO movies(code,title,rating) VALUES(9,'Citizen King','G');
 INSERT INTO movies(code,title,rating) VALUES(1,'Citizen Kane','PG');
 INSERT INTO movies(code,title,rating) VALUES(2,'Singin'' in the Rain','G');
 INSERT INTO movies(code,title,rating) VALUES(3,'The Wizard of Oz','G');
 INSERT INTO movies(code,title,rating) VALUES(4,'The Quiet Man',NULL);
 INSERT INTO movies(code,title,rating) VALUES(5,'North by Northwest',NULL);
 INSERT INTO movies(code,title,rating) VALUES(6,'The Last Tango in Paris','NC-17');
 INSERT INTO movies(code,title,rating) VALUES(7,'Some Like it Hot','PG-13');
 INSERT INTO movies(code,title,rating) VALUES(8,'A Night at the Opera',NULL);
 
 INSERT INTO theaters(code,name,movie) VALUES(1,'Odeon',5);
 INSERT INTO theaters(code,name,movie) VALUES(2,'Imperial',1);
 INSERT INTO theaters(code,name,movie) VALUES(3,'Majestic',NULL);
 INSERT INTO theaters(code,name,movie) VALUES(4,'Royale',6);
 INSERT INTO theaters(code,name,movie) VALUES(5,'Paraiso',3);
 INSERT INTO theaters(code,name,movie) VALUES(6,'Nickelodeon',NULL);