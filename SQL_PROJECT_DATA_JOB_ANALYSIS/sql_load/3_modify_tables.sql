SELECT * from job_postings_fact
limit 100;

SELECT job_posting_date FROM job_posting_fact
limit 10;


select  
job_title_short as title,
job_location as location,
job_posted_date as date      
from job_posting_fact