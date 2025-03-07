/* query */

/* 
    1) Find the test# and plane_reg# for test which been done 
    before date “20231001” with the highest score. 
*/ 
SELECT test#, plane_reg#
FROM test NATURAL JOIN done_by 
WHERE done_date < '01-OCT-23' 
AND score = (
    SELECT MAX(score) 
    FROM test t1,done_by d1
    WHERE d1.test# = t1.test#
    AND d1.done_date < '01-OCT-23' 
);

/* 
    2) Find the employee_ID, tech_name, phone# of the technician 
    whose city is New York and skill_level is 8. 
*/
SELECT employee_ID, tech_name, phone#
FROM technician_table NATURAL JOIN technician_phone 
WHERE city = 'New York' 
AND skill_level = 8;

/* 
    3) Find the model#, capacity, weight of all models 
    which has airplanes more than 500. 
*/
SELECT model#, capacity, weight
FROM model NATURAL JOIN plane
GROUP BY model#, capacity, weight
HAVING COUNT(plane_reg#) > 500;

/* 
    4) Find the plane_reg#, test#, test_name of all the airplanes 
    which have NOT been tested during “Oct”. 
*/
SELECT plane_reg#, test#, test_name
FROM test NATURAL JOIN done_by
GROUP BY plane_reg#, test#, test_name, SUBSTR(TO_CHAR(done_date, 'MM'), 1, 2)
HAVING SUBSTR(TO_CHAR(done_date, 'MM'), 1, 2) <> '10';

/* 
    5) Find the plane_reg#, test#, score of all the tests 
    which test_name is “Controller System Test” 
    and been done by technician '12345678' but not '23456789'. 
    (In this place, '12345678' and '23456789' are the 
    sample employee_ID of technicians.) 
*/
(SELECT plane_reg#, test#, score
FROM test NATURAL JOIN done_by
WHERE test_name = 'Controller System Test'
AND employee_ID = '12345678')
minus
(SELECT plane_reg#, test#, score
FROM test NATURAL JOIN done_by
WHERE test_name = 'Controller System Test'
AND employee_ID = '23456789');
