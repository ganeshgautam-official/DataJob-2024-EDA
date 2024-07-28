/*
 What skills are required for top paying data analyst roles
 -Use the query from previous results and join it with the skills table
 -why? Identifying top skills helps to align job seeker's skill with higher paying data analyst role.
*/
 
    --Retrieving job along with high demand skills(1.0)

    SELECT 
        job_postings.*,
        skills
    FROM
        ((
        SELECT 
            job_id,
            name AS company_name,
            job_title,
            salary_year_avg
        FROM
            job_postings_fact
        LEFT  JOIN
            company_dim ON job_postings_fact.company_id = company_dim.company_id
        WHERE
            job_title_short = 'Data Analyst' AND
            job_location = 'Anywhere' AND
            salary_year_avg IS NOT NULL
        ORDER BY
            salary_year_avg DESC
        LIMIT 10
        ) AS job_postings
    INNER JOIN skills_job_dim ON job_postings.job_id = skills_job_dim.job_id)
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id;
   


--Count occurence of each skills for top paying data analyst role(1.1).

    SELECT 
        skills,
        COUNT(skills ) AS count
    
    FROM
        ((
        SELECT 
            job_id,
            name AS company_name,
            job_title,
            salary_year_avg
        FROM
            job_postings_fact
        LEFT  JOIN
            company_dim ON job_postings_fact.company_id = company_dim.company_id
        WHERE
            job_title_short = 'Data Analyst' AND
            job_location = 'Anywhere' AND
            salary_year_avg IS NOT NULL
        ORDER BY
            salary_year_avg DESC
        LIMIT 10
        ) AS job_postings
    INNER JOIN skills_job_dim ON job_postings.job_id = skills_job_dim.job_id)
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    GROUP BY skills
    ORDER BY count DESC;


--Count skills based on type for top paying data analyst role(2.2).

SELECT 
        skills,
        COUNT(skills ) AS count
    
    FROM
        ((
        SELECT 
            job_id,
            name AS company_name,
            job_title,
            salary_year_avg
        FROM
            job_postings_fact
        LEFT  JOIN
            company_dim ON job_postings_fact.company_id = company_dim.company_id
        WHERE
            job_title_short = 'Data Analyst' AND
            job_location = 'Anywhere' AND
            salary_year_avg IS NOT NULL
        ORDER BY
            salary_year_avg DESC
        LIMIT 10
        ) AS job_postings
    INNER JOIN skills_job_dim ON job_postings.job_id = skills_job_dim.job_id)
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    GROUP BY skills
    ORDER BY count DESC;