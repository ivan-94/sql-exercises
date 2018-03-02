-- https://en.wikibooks.org/wiki/SQL_Exercises/Scientists
-- 6.1 List all the scientists' names, their projects' names, 
    -- and the hours worked by that scientist on each project, 
    -- in alphabetical order of project name, then scientist name.
SELECT scientists.name, projects.name, projects.hours
FROM scientists INNER JOIN assigned_to ON scientists.ssn = assigned_to.scientist
                INNER JOIN projects ON assigned_to.project = projects.code
ORDER BY projects.name, scientists.name;


-- 6.2 Select the project names which are not assigned yet
SELECT name
FROM projects 
WHERE code NOT IN (
  SELECT project FROM assigned_to 
  WHERE projects.code = project);
-- or
SELECT name
FROM projects LEFT OUTER JOIN assigned_to
ON code = project
WHERE scientist IS NULL;
