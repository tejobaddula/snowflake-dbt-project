with source as (
    select * from {{ ref('HR_Analytics') }}
),

deduplicated as (
    select *,
        row_number() over (
            partition by EmpID
            order by EmpID
        ) as row_num
    from source
),

cleaned as (
    select * from deduplicated
    where row_num = 1
),

renamed as (
    select
        -- Employee identifiers
        EmpID                                           as employee_id,
        EmployeeNumber                                  as employee_number,

        -- Demographics
        Age                                             as age,
        AgeGroup                                        as age_group,
        Gender                                          as gender,
        MaritalStatus                                   as marital_status,
        Over18                                          as is_over_18,

        -- Job details
        Department                                      as department,
        JobRole                                         as job_role,
        JobLevel                                        as job_level,
        BusinessTravel                                  as business_travel,
        OverTime                                        as is_overtime,

        -- Education
        Education                                       as education_level,
        EducationField                                  as education_field,

        -- Compensation
        DailyRate                                       as daily_rate,
        HourlyRate                                      as hourly_rate,
        MonthlyRate                                     as monthly_rate,
        MonthlyIncome                                   as monthly_income,
        SalarySlab                                      as salary_slab,
        PercentSalaryHike                               as percent_salary_hike,
        StockOptionLevel                                as stock_option_level,

        -- Satisfaction scores
        EnvironmentSatisfaction                         as environment_satisfaction,
        JobInvolvement                                  as job_involvement,
        JobSatisfaction                                 as job_satisfaction,
        RelationshipSatisfaction                        as relationship_satisfaction,
        WorkLifeBalance                                 as work_life_balance,

        -- Performance
        PerformanceRating                               as performance_rating,
        TrainingTimesLastYear                           as training_times_last_year,

        -- Work history
        NumCompaniesWorked                              as num_companies_worked,
        TotalWorkingYears                               as total_working_years,
        YearsAtCompany                                  as years_at_company,
        YearsInCurrentRole                              as years_in_current_role,
        YearsSinceLastPromotion                         as years_since_last_promotion,
        YearsWithCurrManager                            as years_with_curr_manager,
        StandardHours                                   as standard_hours,
        DistanceFromHome                                as distance_from_home,

        -- Attrition
        Attrition                                       as attrition

    from cleaned
)

select * from renamed