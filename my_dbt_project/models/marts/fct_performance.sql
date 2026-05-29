with employees as (
    select * from {{ ref('dim_employees') }}
),

fct_performance as (
    select
        -- Dimensions
        department,
        job_role,
        job_level,
        education_field,
        performance_band,
        training_band,
        income_band,
        tenure_band,
        is_overtime,

        -- Metrics
        count(employee_id)                                          as total_employees,
        round(avg(performance_rating), 2)                           as avg_performance_rating,
        round(avg(overall_satisfaction_score), 2)                   as avg_satisfaction_score,
        round(avg(monthly_income), 2)                               as avg_monthly_income,
        round(avg(percent_salary_hike), 2)                          as avg_salary_hike,
        round(avg(training_times_last_year), 2)                     as avg_training_times,
        round(avg(years_at_company), 2)                             as avg_years_at_company,
        sum(is_attrited)                                            as total_attrited,
        round(sum(is_attrited) * 100.0 / count(employee_id), 2)    as attrition_rate

    from employees
    group by
        department,
        job_role,
        job_level,
        education_field,
        performance_band,
        training_band,
        income_band,
        tenure_band,
        is_overtime
)

select * from fct_performance