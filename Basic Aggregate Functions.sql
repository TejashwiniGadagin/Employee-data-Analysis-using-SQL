select * from payroll;
-- using basic aggregate functions with dept_name data
select *,
dept_name,
count(*) as nb_dept_name,
min(salary) as minimum_salary,
max(salary) as maximum_salary,
round(avg(salary)) as average_salary,
round(sum(salary)) as total_dept_salary
from payroll
group by dept_name
order by dept_name;

--using window function over() for basic aggregate functions
select *,
count(*) over() as nb_emp_count,
count(*) over(partition by dept_name) as nb_count_dept,
min(salary) over(partition by dept_name) as min_salary,
max(salary) over(partition by dept_name) as maximum_salary,
avg(salary) over(partition by dept_name) as average_salary,
sum(salary) over(partition by dept_name) as total_dept_salary
from payroll
order by dept_name;


