select * 
from covid_19.coronadeath;

-- selecting the columns that we are going to use
 
 select location, date, total_cases, new_cases, total_deaths, population
 from covid_19.coronadeath
 order by 1,2;
 
 -- total cases vs total deaths 

select date, location, total_cases, total_deaths, (total_deaths/ total_cases)*100 as deathpercent
from covid_19.coronadeath
Where location like '%Ind%'
order by 1,2 asc;

-- total cases vs population
-- Percentage of population got affected by covid
 
select date, location, population, total_cases, (total_cases/ population)*100 as InfectedPercent
from covid_19.coronadeath
Where location like '%Russ%'
order by 1,2 asc;

-- Country with high infection rate compared to population

select location, population, max(total_cases) as Infected, max((total_cases/ population))*100 as InfectedPercent
from covid_19.coronadeath
group by location, population
order by 4 desc;

-- Countries with highest death count per population

select location, max(cast(total_deaths as int)) as MaxTotalDeath
from covid_19.coronadeath
group by location
order by 2 desc;

 
