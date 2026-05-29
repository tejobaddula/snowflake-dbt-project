with employees as (
    select * from {{ ref('stg_hr_employees') }}
),

attrition_analysis as (
    select
        employee_id,
        department,
        job_role,
        age,
        age_group,
        gender,
        marital_status,
        monthly_income,
        salary_slab,
        percent_salary_hike,
        years_at_company,
        years_in_current_role,
        years_since_last_promotion,
        years_with_curr_manager,
        num_companies_worked,
        total_working_years,
        distance_from_home,
        business_travel,
        is_overtime,
        job_satisfaction,
        environment_satisfaction,
        work_life_balance,
        relationship_satisfaction,
        job_involvement,
        attrition,

        -- Derived fields
        case
            when attrition = 'Yes' then 1
            else 0
        end                             as is_attrited,

        case
            when monthly_income < 3000 then 'Low'
            when monthly_income between 3000 and 7000 then 'Medium'
            when monthly_income > 7000 then 'High'
        end                             as income_band,

        case
            when years_at_company <= 2 then 'New'
            when years_at_company between 3 and 7 then 'Mid'
            when years_at_company > 7 then 'Senior'
        end                             as tenure_band

    from employees
)

select * from attrition_analysis