-- using CTE with window functions

--using row_number
with ctepayroll as (
	select *, row_number() over(partition by dept_name order by salary desc) as row_dept
	from payroll
)
select * from ctepayroll
where row_dept <=2;

--using rank()
with ctepayroll as (
	select *, rank() over(partition by dept_name order by salary desc) as rank_dept
	from payroll
)
select * from ctepayroll
where rank_dept <=2;

--using dense_rank()
with ctepayroll as (
	select *, dense_rank() over(partition by dept_name order by salary desc) as dr_dept
	from payroll
)
select * from ctepayroll
where dr_dept <=2;

-- using generate_series 
select generate_series(1,10,2) as series
from payroll;

SELECT * FROM generate_series('2008-03-01 00:00'::timestamp,
                              '2008-03-01 12:00', '2 hours');
							  
WITH base_data AS (
	SELECT generate_series(1,20) AS series
)
SELECT 	*,
	(PERCENT_RANK() OVER (ORDER BY series))::DEC(8,2),	-- to determine the relative standing of a value within a set or rows
	(CUME_DIST() 	OVER (ORDER BY series))::DEC(8,2),	-- Perfect for a 10-90 split in data
	NTILE(2) 	OVER (ORDER BY series),			-- Split your dataset into x parts
	NTILE(3) 	OVER (ORDER BY series)
FROM base_data
ORDER BY series
;							  

-- using LAG() and lead ()
select *,
LAG(emp_no) over(partition by dept_name order by salary) as lg_ex,
lead(emp_no) over (partition by dept_name order by salary) as ld_ex
from payroll;