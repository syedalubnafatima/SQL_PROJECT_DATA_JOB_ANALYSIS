/*
question:  what are the top-paying data analyst jobs?
- identify the top 10 high-paying data-analyst roles that are available remotely.
- focus on job postings with specified salaries (remove null)
- why? highlight the top paying opportunities for data analysis offering insights to employees 
*/

SELECT
job_id,
job_title,
job_location,
job_schedule_type,
salary_year_avg,
job_posted_date

FROM
job_postings_fact
left join company_dim on job_postings_fact.company_id = company_dim.company_id

where 
job_title = 'Data Analyst' and 
job_location
AND salary_year_avg is not null and job_location='Anywhere' 
order by
salary_year_avg desc
limit 10;
