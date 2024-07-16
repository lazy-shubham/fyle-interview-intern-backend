-- Write query to get number of graded assignments for each student:

SELECT COUNT(assignments.id) AS assignment_count FROM students 
LEFT JOIN assignments ON assignments.student_id = students.id AND assignments.state = "GRADED" AND assignments.grade IS NOT NULL
GROUP BY students.id;