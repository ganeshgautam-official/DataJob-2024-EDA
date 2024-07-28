/* What are the most optimal skills to learn
hint: top demand skills AND top paying skills
*/


WITH top_demand AS(
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(job_postings_fact.job_id) AS demand_skill
    FROM
        job_postings_fact
    INNER JOIN
        skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN
        skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home 
    GROUP BY
        skills_dim.skill_id

), average_salary AS(
        SELECT
            skills_dim.skill_id,
            ROUND(AVG(salary_year_avg),2) AS avg_salary
        FROM
        job_postings_fact
        INNER JOIN
            skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN
            skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
        WHERE
            job_title_short = 'Data Analyst' AND
            salary_year_avg IS NOT NULL AND
            job_work_from_home 
        GROUP BY
            skills_dim.skill_id

)

SELECT
    top_demand.skill_id,
    top_demand.skills,
    demand_skill,
    avg_salary
FROM 
    top_demand
INNER JOIN 
    average_salary ON top_demand.skill_id = average_salary.skill_id
WHERE
    demand_skill > 15
ORDER BY
    avg_salary DESC,
    demand_skill DESC
LIMIT 25


-- Precisely this can be writtten as

SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(job_postings_fact.job_id) AS demand_skill,
        ROUND(AVG(salary_year_avg),2) AS avg_salary

    FROM
        job_postings_fact
    INNER JOIN
        skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN
        skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home 
    GROUP BY
        skills_dim.skill_id
    HAVING 
        COUNT(job_postings_fact.job_id)> 15

    ORDER BY
    avg_salary DESC,
    demand_skill DESC