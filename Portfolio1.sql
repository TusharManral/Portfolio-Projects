SELECT * FROM gdb0041.fact_act_est;

-- Selecting the Database
create database portfolio;
use portfolio;

select * from covidd
where continent is not null;

Select location, date,total_cases,new_cases, total_deaths, population from covidd1
order by 1,2;

-- looking for total Cases vs total Deaths
-- shows likelihood of dying if you contract covid in your country
Select location, date,total_cases, total_deaths, round((total_deaths/total_cases)*100,2) as Death_percentage from covidd1
where location like "%Kingdom%" and continent is not null;


-- Looking at Total Cases VS population
-- shows what percentage of population got covid
Select location, date,total_cases,population, total_deaths, round((total_cases/population)*100,2) as per_pop_infected from covidd1
where location like "%Kingdom%" and continent is not null;

-- looking at countries with highest infection rate compared to pupulation

Select location,population, max(total_cases) as total_cases,max(round((total_cases/population)*100,2)) as per_pop_infected from covidd1
where continent is not null
group by location,population
order by per_pop_infected desc ;

-- LETS BREAK THE THINGS DOWN BY CONTINENT

-- showing countries with the highest death count per population.

Select location,population, max(cast(total_deaths as signed)) as total_deaths from covidd1
where continent is not null
group by location,population
order by total_deaths desc;

-- LETS BREAK THE THINGS DOWN BY CONTINENT

SELECT continent, 
       MAX(CAST(total_deaths AS SIGNED)) AS total_deaths
FROM covidd1
WHERE TRIM(continent) IS not  NULL 
  AND continent != ''
  AND total_deaths IS not NULL
GROUP BY continent
ORDER BY total_deaths DESC;

-- GLOBAL NUMBERS

SELECT 
    
    SUM(CAST(new_deaths AS SIGNED)) AS new_deaths,
    SUM(new_cases) AS total_cases,
    ROUND(SUM(CAST(new_deaths AS SIGNED)) / SUM(new_cases) * 100,
            2)
FROM
    covidd1
WHERE
    continent IS NOT NULL
GROUP BY date
order by date desc;

-- Looking at total population VS vaccinations


with CTE1 as (
SELECT 
    m1.continent,
    m1.location,
    m1.date,
    m1.population,
    m2.new_vaccinations,
    sum(new_vaccinations) over(partition by m1.location order by m1.location,m2.date) as rollingPeopleVaccinated
FROM
    covidd1 m1
        JOIN
    cleaned m2 ON m1.location = m2.location
        AND m1.date = m2.date
where m1.continent is not null)

select *, (rollingPeopleVaccinated/population)*100 from CTE1;

drop table if exists rolling_vacinnations;

create Temporary Table rolling_vacinnations as (with CTE1 as (
SELECT 
    m1.continent,
    m1.location,
    m1.date,
    m1.population,
    m2.new_vaccinations,
    sum(new_vaccinations) over(partition by m1.location order by m1.location,m2.date) as rollingPeopleVaccinated
FROM
    covidd1 m1
        JOIN
    cleaned m2 ON m1.location = m2.location
        AND m1.date = m2.date
where m1.continent is not null)

select *, (rollingPeopleVaccinated/population)*100 from CTE1);

select * from rolling_vacinnations;


-- creating View to store data for later visulisation
create view percentpopulationVaccinated as (SELECT 
    m1.continent,
    m1.location,
    m1.date,
    m1.population,
    m2.new_vaccinations,
    sum(new_vaccinations) over(partition by m1.location order by m1.location,m2.date) as rollingPeopleVaccinated
FROM
    covidd1 m1
        JOIN
    cleaned m2 ON m1.location = m2.location
        AND m1.date = m2.date
where m1.continent is not null)

