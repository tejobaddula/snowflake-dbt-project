with employees as (
    select * from {{ ref('stg_hr_employees') }}
),

performance_analysis as (
    select
        employee_id,
        department,
        job_role,
        job_level,
        education_level,
        education_field,
        performance_rating,
        job_satisfaction,
        environment_satisfaction,
        relationship_satisfaction,
        work_life_balance,
        job_involvement,
        training_times_last_year,
        monthly_income,
        percent_salary_hike,
        stock_option_level,
        is_overtime,
        total_working_years,
        years_at_company,
        years_in_current_role,
        attrition,

        -- Derived fields
        case
            when performance_rating >= 4 then 'High Performer'
            when performance_rating = 3 then 'Average Performer'
            else 'Low Performer'
        end                             as performance_band,

        case
            when training_times_last_year = 0 then 'No Training'
            when training_times_last_year between 1 and 2 then 'Low Training'
            when training_times_last_year between 3 and 5 then 'Moderate Training'
            else 'High Training'
        end                             as training_band,

        -- Overall satisfaction score (average of all satisfaction metrics)
        round(
            (job_satisfaction + environment_satisfaction +
            relationship_satisfaction + work_life_balance) / 4.0
        , 2)                            as overall_satisfaction_score

    from employees
)

select * from performance_analysis