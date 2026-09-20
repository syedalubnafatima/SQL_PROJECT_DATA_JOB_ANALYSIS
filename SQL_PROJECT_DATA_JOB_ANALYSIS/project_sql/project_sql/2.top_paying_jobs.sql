/* 
- WHAT SKILLS ARE REQUIRED FOR THE TOP-PAYING DATA ANALYST JOBS?
- USE THE TOP-10  HEIGHEST-PAYING DATA ANALYST JOB FROM FIRST QUERY 
- ADD THE SPECIFIC SKILLS REQUIRED FOR THESE ROLES
- WHY? IT PROVIDES A DETAILED LOOK AT WHICH HIGH- PAYING JOBS DEMAND CERTAIN SKILLS, HELPING JOB SEEKERS TO FOCUS ON THE MOST RELEVANT SKILLS FOR HIGH-PAYING DATA ANALYST ROLES
HELPING JOB SEEKERS UNDERSTANDF WHICH SKILLS TO DEVELOP THAT ALIGN WITH TOP SLARIES
*/ 



WITH TOP_PAYING_JOBS AS (
SELECT
job_id,
job_title,
salary_year_avg,
NAME AS COMPANY_NAME

FROM
job_postings_fact
left join company_dim on job_postings_fact.company_id = company_dim.company_id

where 
job_title = 'Data Analyst' and 
job_location = 'Anywhere'
and salary_year_avg is not null and job_location='Anywhere' 
order by
salary_year_avg desc
limit 10
)
SELECT 
TOP_PAYING_JOBS.*,SKILLS

FROM TOP_PAYING_JOBS
INNER JOIN 
skills_job_dim ON TOP_PAYING_JOBS.job_id = skills_job_dim.job_id
INNER JOIN 
SKILLS_DIM ON skills_job_dim.skill_id = skills_dim.skill_id

ORDER BY SALARY_YEAR_AVG DESC