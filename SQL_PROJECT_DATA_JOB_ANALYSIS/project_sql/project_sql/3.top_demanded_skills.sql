/*
- what are the most in-demand skills for data analysis?
- join job postings to innner join table similar to query 2 to get the skills for the top-paying data analyst jobs
- identify the top 5 in-demanded skills for data analyst.
- focus on all job postings
- why? retrive the top 5 skills with the highest demand for data analyst roles, helping job seekers to focus on the most relevant skills for high-paying data analyst roles proving insights to the most valuable skills in the market.
*/


select 
skills,
count(skills_jobs_dim.job_id) as demand_count

from job_postings_fact
inner join skils_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
inner join skills_dim on skills_job_dim.skill_id = skills_dim.skill_id

where 
job_title_short='Data Analyst' and 
job_work_from_home=True
group by skills
order by 
demand_count DESC
limit 5
