with employee_attrition as (
    select * from {{ ref('int_employee_attrition') }}
),

employee_performance as (
    select * from {{ ref('int_employee_performance') }}
),

final as (
    select
        -- Identifiers
        a.employee_id,

        -- Demographics
        a.age,
        a.age_group,
        a.gender,
        a.marital_status,

        -- Job details
        a.department,
        a.job_role,
        p.job_level,
        a.business_travel,
        a.is_overtime,

        -- Education
        p.education_level,
        p.education_field,

        -- Compensation
        a.monthly_income,
        a.salary_slab,
        a.percent_salary_hike,
        p.stock_option_level,

        -- Satisfaction
        p.overall_satisfaction_score,
        p.job_satisfaction,
        p.environment_satisfaction,
        p.relationship_satisfaction,
        p.work_life_balance,

        -- Performance
        p.performance_band,
        p.performance_rating,
        p.training_band,
        p.training_times_last_year,

        -- Work history
        a.tenure_band,
        a.years_at_company,
        a.years_in_current_role,
        a.years_since_last_promotion,
        a.years_with_curr_manager,
        a.total_working_years,
        a.num_companies_worked,
        a.distance_from_home,

        -- Attrition
        a.attrition,
        a.is_attrited,
        a.income_band

    from employee_attrition a
    left join employee_performance p
        on a.employee_id = p.employee_id
)

select * from final