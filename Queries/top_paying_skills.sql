/*
    What are the top 25 skills based on salary?
    -look at the average salary associated with each skill for Data Analyst Positions
    -Focuses on roles with specified salaries, regardless of location
    -why? It reveals how different skills impact salary level for Data Analysts and help identify the most financially rewarding skills to acquire or improve

*/

SELECT 
    skills,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
    
FROM
    (SELECT 
        skills,
        job_id
    FROM
        skills_dim
    INNER JOIN 
        skills_job_dim ON skills_dim.skill_id = skills_job_dim.skill_id) AS temp_table
INNER JOIN 
    job_postings_fact ON temp_table.job_id = job_postings_fact.job_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_work_from_home = TRUE
GROUP BY 
    skills
ORDER BY
    avg_salary DESC
LIMIT 25

