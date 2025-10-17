create database workforce;

select * from emp_info;

-- --1)Find the second highest salary from table--

select max(salary) from emp_info
where salary<(select max(salary) from emp_info);

select salary from (select salary, dense_rank() over(order by salary desc)as rnk from emp_info)
as ranked where rnk=2;

select distinct salary from emp_info
order by salary desc limit 1 offset 1;

-- 2)Find the second highest salary for each department?

select department, salary from(select department, salary, dense_rank() over(partition by department
order by salary desc) as rnk from emp_info) as Ranked where rnk=2;

-- 3)Find the maximum salary of the top 5 highest-paid employees in
-- each department?

SELECT department, max(salary) FROM (SELECT department, salary, DENSE_RANK() OVER (PARTITION BY department
ORDER BY salary DESC) AS rnk
FROM emp_info) AS ranked
WHERE rnk <= 5
group by Department limit 5;

-- 4)Find the department with the highest number of employees?

select department, count(*) from emp_info
group by Department
order by count(*) desc limit 1;

-- 5)Fetch all employees whose salary is greater than the minimum salary?

select * from emp_info
where salary >(select min(salary) from emp_info);

-- 6)Write a query to find all employees who joined in the year 2020? 

select * from emp_info where Year(str_to_date(Hire_date,'%d/%m/%Y'))=2020;

-- 7.Fetch the first and last record from a table?

(select * from emp_info order by emp_id asc limit 1)
Union
(select * from emp_info order by emp_id desc limit 1);

-- 8.Display all employees grouped by their age brackets (e.g.,
-- 20-30, 31-40, etc.).

select case
when age between 20 and 30 then '20-30'
when age between 31 and 40 then '31-40'
else '41+'
end as age_bracket,
count(*) from emp_info
group by age_bracket;

-- 9.Fetch the details of employees with the same salary.

SELECT * FROM emp_info
WHERE salary IN (SELECT salary FROM emp_info
GROUP BY salary
HAVING COUNT(*) > 1);

-- 10.Retrieve employee names and salaries in a single string?

select concat(Full_name, salary) as employees_information from emp_info;











