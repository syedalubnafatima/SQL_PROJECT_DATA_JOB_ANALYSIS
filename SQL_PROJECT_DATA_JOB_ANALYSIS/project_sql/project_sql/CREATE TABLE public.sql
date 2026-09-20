CREATE TABLE public.skills_job_dim (
	job_id int4 NOT NULL,
	skill_id int4 NOT NULL,
	CONSTRAINT skills_job_dim_pkey PRIMARY KEY (job_id, skill_id),
	CONSTRAINT skills_job_dim_job_id_fkey FOREIGN KEY (job_id) REFERENCES job_postings_fact(job_id),
	CONSTRAINT skills_job_dim_skill_id_fkey FOREIGN KEY (skill_id) REFERENCES skills_dim(skill_id)
)