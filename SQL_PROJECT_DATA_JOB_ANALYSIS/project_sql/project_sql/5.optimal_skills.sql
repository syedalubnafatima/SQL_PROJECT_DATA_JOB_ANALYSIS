
with skills_demand as  ( 

select 
skills_job_dim.job_id
skills,
count(skills_jobs_dim.job_id) as demand_count

from job_postings_fact
inner join skils_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id

where 
job_title_short='Data Analyst' and 
salary_year_avg is not null and 
job_work_from_home=True
group by skill_id

), average_salary as (
    
select 
skill_id,
skills,
round(avg(salary_year_avg), 0) as avg_salary

from job_postings_fact
inner join skils_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id

where 
job_title_short='Data Analyst' and 
salary_year_avg is not null and job_work_from_home=True

group by 
 skill_id


)

SELECT
skills_demand.skill_id,
skills_deamnd.skill,
demand_count,
avg_salary
from
skills_demand
inner join average salary on skills_demand.skill_id = average_salary.skill_id
order by
demand_count DESC, 
avg_salary DESC
limit 25