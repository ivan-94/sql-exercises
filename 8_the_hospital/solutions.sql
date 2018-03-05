-- 8.1 Obtain the names of all physicians that have performed a medical procedure they have never been certified to perform.
-- 检索所有已久会诊过, 但是没有被证明的医生名字
-- 子查询方式
SELECT name
FROM physicians
WHERE id IN (
  SELECT physician
  FROM undergoes
  WHERE physician = id
    AND procedure NOT IN (SELECT treatment
                          FROM trained_in
                          WHERE procedure = treatment
                            AND physician = id) 
);
-- or
SELECT name
FROM physicians
WHERE id IN (
  SELECT U.physician
  FROM undergoes AS U LEFT OUTER JOIN trained_in AS T
  ON U.physician = id
    AND U.physician = T.physician
    AND U.procedure = T.treatment
  WHERE T.physician IS NULL
);
--or
SELECT P.name
FROM physicians AS P,
(
  -- 获取所有执行的, 但没有证明的会诊
  SELECT U.physician
  FROM undergoes AS U LEFT OUTER JOIN trained_in AS T
  ON U.physician = T.physician
    AND U.procedure = T.treatment
  WHERE T.physician IS NULL
) AS Q
WHERE P.id = Q.physician;


-- 8.2 Same as the previous query, but include the following information in the results: Physician name, name of procedure, date when the procedure was carried out, name of the patient the procedure was carried out on.
SELECT Q.name, R.name, P.date, S.name
FROM  (
    -- 获取所有执行的, 但没有证明的会诊
    SELECT U.physician, U.procedure, U.date, U.patient
    FROM undergoes AS U LEFT OUTER JOIN trained_in AS T
    ON U.physician = T.physician
      AND U.procedure = T.treatment
    WHERE T.physician IS NULL
  ) AS P
INNER JOIN physicians AS Q
  ON Q.id = P.physician
-- 联结会诊单
INNER JOIN procedures AS R
  ON R.code = P.procedure
-- 联结患者
INNER JOIN patients AS S
  ON P.patient = S.ssn;
-- or
SELECT P.name, Q.name, R.date, S.name
FROM physicians AS P,
     procedures AS Q,
     undergoes AS R,
     patients AS S
WHERE P.id = R.physician
  AND R.procedure = Q.code
  AND R.patient = S.ssn
  AND R.procedure NOT IN (
    SELECT treatment
    FROM trained_in AS T
    WHERE P.id = T.physician
      AND T.treatment = R.procedure
  );


-- 8.3 Obtain the names of all physicians that have performed a medical procedure that they are certified to perform, but such that the procedure was done at a date (Undergoes.Date) after the physician's certification expired (Trained_In.CertificationExpires).
SELECT P.name
FROM physicians AS P 
  INNER JOIN undergoes AS Q 
     ON P.id = Q.physician
  INNER JOIN trained_in AS R
     ON R.treatment = Q.procedure
    AND Q.date > R.certification_expires;
-- or
SELECT name
FROM physicians
WHERE id IN (
  SELECT P.physician
  FROM undergoes AS P
  WHERE P.physician = id
    AND P.date > (SELECT certification_expires
                  FROM trained_in AS Q
                  WHERE P.procedure = Q.treatment
                    AND P.physician = Q.physician
                  )
);



-- 8.4 Same as the previous query, but include the following information in the results: Physician name, name of procedure, date when the procedure was carried out, name of the patient the procedure was carried out on, and date when the certification expired.
SELECT P.name, S.name, Q.date, T.name, R.certification_expires
FROM physicians AS P 
  INNER JOIN undergoes AS Q 
     ON P.id = Q.physician
  INNER JOIN trained_in AS R
     ON R.treatment = Q.procedure
    AND Q.date > R.certification_expires
  INNER JOIN procedures AS S
     ON R.treatment = S.code
  INNER JOIN patients AS T
     ON Q.patient = T.ssn;


-- 8.5 Obtain the information for appointments where a patient met with a physician other than his/her primary care physician. Show the following information: Patient name, physician name, nurse name (if any), start and end time of appointment, examination room, and the name of the patient's primary care physician.
-- 8.6 The Patient field in Undergoes is redundant, since we can obtain it from the Stay table. There are no constraints in force to prevent inconsistencies between these two tables. More specifically, the Undergoes table may include a row where the patient ID does not match the one we would obtain from the Stay table through the Undergoes.Stay foreign key. Select all rows from Undergoes that exhibit this inconsistency.
-- 8.7 Obtain the names of all the nurses who have ever been on call for room 123.
-- 8.8 The hospital has several examination rooms where appointments take place. Obtain the number of appointments that have taken place in each examination room.
-- 8.9 Obtain the names of all patients (also include, for each patient, the name of the patient's primary care physician), such that \emph{all} the following are true:
    -- The patient has been prescribed some medication by his/her primary care physician.
    -- The patient has undergone a procedure with a cost larger that $5,000
    -- The patient has had at least two appointment where the nurse who prepped the appointment was a registered nurse.
    -- The patient's primary care physician is not the head of any department.