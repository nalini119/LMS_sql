USE LMS;

#1. List All Courses with Their Category Names
SELECT co.course_name,ca.category_name
FROM courses AS co INNER JOIN categories AS ca
ON co.category_id=ca.category_id;

#2. Count the Number of Courses in Each Category
SELECT ca.category_name,COUNT(co.course_name)
FROM courses AS co INNER JOIN categories AS ca
ON co.category_id=ca.category_id
GROUP BY ca.category_name;

#3. List All Students’ Full Names and Email Addresses
SELECT CONCAT(first_name," ",last_name) AS full_name,email
FROM user
WHERE role="student";

#4. Retrieve All Modules for a Specific Course Sorted by Module Order
SELECT c.course_id,m.module_name,m.module_order
FROM modules AS m INNER JOIN courses AS c
ON m.course_id=c.course_id
ORDER BY m.module_order;

#5. List All Content Items for a Specific Module
SELECT m.module_id,m.module_name,c.title
FROM modules AS m INNER JOIN content AS c
ON m.module_id=c.module_id;

#6. Find the Average Score for a Specific Assessment
SELECT assessment_id,ROUND(avg(score)) AS average_score
FROM assessment_submission
GROUP BY assessment_id;

#7. List All Enrollments with Student Names and Course Names
Select CONCAT(u.first_name," ",U.LAST_NAME) AS fullname,c.course_name,e.enrolled_at
FROM user AS u INNER JOIN enrollments AS e INNER JOIN courses AS c
ON u.user_id=e.user_id AND e.course_id=c.course_id;

#8. Retrieve All Instructors’ Full Names
SELECT CONCAT(first_name," ",last_name) AS full_name,email
FROM user
WHERE role="instructor";

#9. Count the Number of Assessment Submissions per Assessment
SELECT assessment_id,COUNT(submission_id) AS Number_of_assessments_submitted
FROM assessment_submission
GROUP BY assessment_id;

#10. List the Top Scoring Submission for Each Assessment
SELECT assessment_id,submission_id,max(score)
FROM assessment_submission
GROUP BY assessment_id,submission_id
HAVING max(score);

#11. Retrieve Courses Created After a Specific Date
SELECT course_name
FROM courses
WHERE created_at>"2023-04-01";

#12. Find Students Who Have Not Submitted Any Assessments
SELECT u.first_name,u.last_name
FROM user AS u LEFT JOIN assessment_submission as asub
ON u.user_id=asub.user_id
WHERE asub.user_id IS NULL;

#13. List the Content for Courses in the 'Programming' Category
SELECT m.course_id,c.title,ca.category_name
FROM modules AS m INNER JOIN content AS c INNER JOIN courses AS co INNER JOIN categories AS ca
ON m.module_id=c.module_id AND m.course_id=co.course_id AND co.category_id=ca.category_id
WHERE ca.category_name="Programming";

#14. Retrieve Modules That Have No Associated Content
SELECT m.module_id,m.module_name
FROM modules AS m LEFT JOIN content AS c
ON m.module_id=c.module_id
WHERE c.content_id IS NULL;

#15. List Courses with the Total Number of Enrollments
SELECT c.course_id,c.course_name,COUNT(e.enrollment_id) AS count_of_enrollments
FROM courses AS c INNER JOIN enrollments AS e
ON c.course_id=e.course_id
GROUP BY c.course_id;

#16. Find the Average Assessment Submission Score for Each Course
SELECT c.course_id,c.course_name,ass.assessment_id,ass.assessment_name,ROUND(AVG(asub.score)) AS avg_score
FROM courses AS c INNER JOIN modules AS m INNER JOIN assessments AS ass INNER JOIN assessment_submission AS asub
ON c.course_id=m.course_id AND m.module_id=ass.module_id AND ass.assessment_id=asub.assessment_id
GROUP BY c.course_id,ass.assessment_id;

#17. List Users with Their Number of Enrollments
SELECT u.user_id,CONCAT(u.first_name," ",u.last_name),COUNT(e.course_id) AS count_of_courses
FROM user AS u INNER JOIN enrollments AS e
ON u.user_id=e.user_id
GROUP BY u.user_id;

#18. Find the Assessment with the Highest Average Score
SELECT assessment_id,assessment_name,AVG(max_score)
FROM assessments
GROUP BY assessment_id
ORDER BY AVG(max_score) desc
LIMIT 1;

#19. List Courses Along with Their Modules and Content in Hierarchical Order
SELECT c.course_name,m.module_name,co.title
FROM courses AS c INNER JOIN modules AS m INNER JOIN content AS co
ON c.course_id=m.course_id AND m.module_id=co.module_id;

#20. Find the Total Number of Assessments Per Course
SELECT c.course_id,c.course_name,count(a.assessment_id)AS number_of_assessments
FROM courses AS c INNER JOIN assessments AS a INNER JOIN modules AS m
ON c.course_id=m.course_id AND m.module_id=a.module_id
GROUP BY c.course_id;

#21. List All Enrollments from May 2023
SELECT enrollment_iD,enrolled_at
FROM enrollments
WHERE enrolled_at<"2023-05-31";

#22. Retrieve Assessment Submission Details Along with Course and Student Information
SELECT asub.submission_id,asub.assessment_id,u.user_id,concat(u.first_name," ",u.last_name) AS full_name,asub.submitted_at,asub.score,asub.submission_data,c.course_name,a.assessment_name
FROM assessments AS a INNER JOIN assessment_submission AS asub INNER JOIN user AS u INNER JOIN enrollments AS e INNER JOIN courses AS c
ON a.assessment_id=asub.assessment_id AND asub.user_id=u.user_id AND u.user_id=e.user_id AND e.course_id=c.course_id;

#23. List All Users with Their Roles
SELECT CONCAT(first_name," ",last_name) AS full_name,role
FROM user;

#24. Find the Percentage of Passing Submissions for Each Assessment

#25. Find Courses That Do Not Have Any Enrollments
#Question: List the courses for which there are no enrollment records.
SELECT c.course_id,c.course_name
FROM courses AS c LEFT JOIN enrollments as e
ON c.course_id=e.course_id
WHERE e.enrollment_id IS NULL;