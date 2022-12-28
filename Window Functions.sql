-- using the over() window function

-- using over() for basic count comparison between total and dept
select *, 
count(*) over() as total_count,
count(*) over(partition by dept_name) as dept_count
from payroll;

--using over() for particular dept
select *, 
count(*) over() as total_count,
count(*) over(partition by dept_name) as dept_count
from payroll
where dept_name='IT';

-- now calculating the salarie percentage using window () for comparing the salary of all employees vs salary per dept

select *,
(salary/sum(salary) over(partition by dept_name))*100 as sal_dept,
(salary/sum(salary) over())*100 as total_sal
from payroll
order by 4;

-- now checking the same condition as above and using scope resolution to round up the values post decimal point

select *,
(salary/(sum(salary) over(partition by dept_name))*100) ::decimal(18,2) as sal_dept,
(salary/(sum(salary) over())*100) :: decimal(18,2) as total_sal
from payroll
order by 5;

-- using the row number function to the table
select *, row_number() over () as row_num
from payroll;

--adding row number to the result set
select *,
row_number() over(order by dept_name) as rn_dpt
from payroll;

--using partition by
select *,
row_number() over(partition by dept_name order by salary) as rn
from payroll;

----Using rank function
select *,
rank() over() as rank_ex
from payroll;

-- using rank function, along with the partition by in over ()
select *,
rank() over(partition by salary) as rank_ex
from payroll;

--using rank function, along with the partition by and order by in over()
select *,
rank() over(partition by salary order by dept_name) as rank_ex
from payroll;

--using rank function, along with the order by in over()
select *,
rank() over(order by salary) as rank_ex
from payroll;

--using dense rank function
select *,
dense_rank() over() as dn_ex
from payroll;

--using dense rank function along with order by
select *,
dense_rank() over(order by dept_name) as dn_ex
from payroll;

--using dense rank () along with partition by
select *,
dense_rank() over (partition by dept_name order by salary) as dn_ex
from payroll;
-- the output for the above has ranks assigned based on the serial numbering, as opposed to the row index value.

