with employees as (
    select * from {{ ref('dim_employees') }}
),

fct_attrition as (
    select
        -- Dimensions
        department,
        job_role,
        age_group,
        gender,
        marital_status,
        salary_slab,
        income_band,
        tenure_band,
        business_travel,
        is_overtime,
        performance_band,
        training_band,

        -- Metrics
        count(employee_id)                                          as total_employees,
        sum(is_attrited)                                            as total_attrited,
        round(sum(is_attrited) * 100.0 / count(employee_id), 2)    as attrition_rate,
        round(avg(monthly_income), 2)                               as avg_monthly_income,
        round(avg(years_at_company), 2)                             as avg_years_at_company,
        round(avg(overall_satisfaction_score), 2)                   as avg_satisfaction_score,
        round(avg(age), 2)                                          as avg_age

    from employees
    group by
        department,
        job_role,
        age_group,
        gender,
        marital_status,
        salary_slab,
        income_band,
        tenure_band,
        business_travel,
        is_overtime,
        performance_band,
        training_band
)

select * from fct_attrition