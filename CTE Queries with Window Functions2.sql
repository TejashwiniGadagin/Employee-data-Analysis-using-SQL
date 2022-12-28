--- using CTEs
with ctepayroll as(
select (LAG(emp_no,2) over(partition by dept_name order by salary)) as lg_ex, --offset values define the rows that come before current row
(lead(emp_no,3) over (partition by dept_name order by salary)) as ld_ex
	from payroll
)
select * from ctepayroll;
--order by payroll.salary;

-- using LAG() and lead () with offset values
select *,
LAG(emp_no,2) over(partition by dept_name order by salary) as lg_ex, --offset values define the rows that come before current row
lead(emp_no,3) over (partition by dept_name order by salary) as ld_ex
from payroll;

--using the first_value and last_value


