# 📊 Introduction

Dive into the data job market! Focusing on data analyst roles, this project explores top-paying jobs, in-demand skills, and where high demand meets high salary in data analytics.

# 🔥 Background

Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining the work to find optimal jobs.

Data hails from my [SQL Course] (https://lukebarousse.com/sql). It's packed with insights on job titles, salaries, locations, and essential skills.

### The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# 🛠️ Tools I Used

### The Analysis

### What I Learned

# 1. Top Paying Data Analyst Jobs

To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name

FROM
    job_postings_fact

LEFT JOIN company_dim
    ON job_postings_fact.company_id = company_dim.company_id

WHERE
    job_title_short = 'Data Analyst'
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL

ORDER BY
    salary_year_avg DESC

LIMIT 10;

2. Skills for Top Paying Jobs

To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into the skills data, providing employers value for high-compensation roles.
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst'
        AND job_location = 'Anywhere'
        AND salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT
    top_paying_jobs.*,
    skills
FROM
    top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;
    Here's the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023:
SQL is leading with a bold count of 8.
Python follows closely with a bold count of 7.
Tableau is also highly sought after, with a bold count of 6. Other skills like R, Snowflake, Pandas, and Excel show varying levels of demand.
Skill Count for Top 10 Paying Data Analyst Jobs in 2023

The graph contains:

Skill	Count
SQL	8
Python	7
Tableau	6
R	4
Snowflake	3
Pandas	3
Excel	3
Azure	2
Bitbucket	2
Go	2
Skill Count for Top 10 Paying Data Analyst Jobs in 2023

Skill frequency among the top 10 paying data analyst jobs.

0
3
6
9
SQL
Python
Tableau
R
Snowflake
Pandas
Excel
Azure
Bitbucket
Go


3. In-Demand Skills for Data Analysts

This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.
SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND job_work_from_home = True
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;  
Here's the breakdown of the most demanded skills for data analysts in 2023:
SQL and Excel remain fundamental, emphasizing the need for strong foundational skills in data processing and data manipulation.
Programming and Visualization Tools like Python, Tableau, and Power BI are essential, pointing towards the importance of technical skills in data storytelling and decision support.
Table of the demand for the top 5 skills in data analyst job postings
Skills	Demand Count
SQL	7291
Excel	4611
Python	4330
Tableau	3745
Power BI	2609


4. Skills Based on Salary

Exploring the average salaries associated with different skills revealed which skills are the highest paying.
Bar graph visualizing the count of skills for the top 10 paying jobs for data analysts; ChatGPT generated this graph from the results.\
SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;

Here's a breakdown of the results for top paying skills for Data Analysts:
High Demand for Big Data & ML Skills: Top salaries are commanded by analysts skilled in big data technologies (Couchbase), machine learning tools (DataRobot, Jupyter), and Python libraries (Pandas, NumPy), reflecting the industry's high valuation of data processing and predictive modeling capabilities.
Software Development & Deployment Proficiency: Knowledge in development and deployment tools (GitLab, Kubernetes, Airflow) indicates a lucrative crossover between data analysis and engineering, with a premium on skills that facilitate automation and efficient data pipeline management.
Cloud Computing Expertise: Familiarity with cloud and data engineering tools (Elasticsearch, Databricks, GCP) underscores the growing importance of cloud-based analytics environments, suggesting that cloud proficiency significantly boosts earning potential in data analytics.
Skills — Average Salary ($)
Skills	Average Salary ($)
pyspark	208,172
bitbucket	189,155
couchbase	160,515
watson	160,515
datarobot	155,486
gitlab	154,500
swift	153,750
jupyter	152,777
pandas	151,821
elasticsearch	145,000

Table of the average salary for the top 10 paying skills for data analysts

5. Most Optimal Skills to Learn

Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salary, offering a strategic focus for skill development.

SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;

Result
Skill ID	Skills	Demand Count	Average Salary ($)
8	go	27	115,320
Table of the most optimal skills for data analyst sorted by salary

Here's a breakdown of the most optimal skills for Data Analysts in 2023:

High-Demand Programming Languages: Python and R stand out for their high demand. Despite their high demand, their average salaries are around $101,397 for Python and approximately $100,4xx for R. Proficiency in these languages is highly valued but also widely available.
Cloud Tools and Technologies: Skills in specialized technologies such as Snowflake, Azure, AWS, and BigQuery show relatively high average salaries, pointing towards the growing importance of cloud platforms in data analytics.
Most Optimal Skills – Salary Table
Skill ID	Skills	Demand Count	Average Salary ($)
234	confluence	11	114,210
97	hadoop	22	113,193
80	snowflake	37	112,948
74	azure	34	111,225
77	bigquery	13	109,654
76	aws	32	108,317
4	java	17	106,906
194	ssis	12	106,683
233	jira	20	104,918

Table of the most optimal skills for data analyst sorted by salary

Additional Salary Results
Skills	Average Salary ($)
watson	160,515
datarobot	155,486
gitlab	154,500
swift	153,750
jupyter	152,777
pandas	151,821
elasticsearch	145,000
Most Optimal Skills to Learn – Conclusion

Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salary, offering a strategic focus for skill development.

Important note

The photos have a few areas where the screen is covered by the video controls, face-cam, or cropped at the edge. I have not invented the missing values. In particular, the first salary bar graph's individual values aren't fully readable from the uploaded photo, so I preserved its description rather than making up numbers.
