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
where location like '%Russ%'
order by 1,2 asc;

-- Country with high infection rate compared to population

select location, population, max(total_cases) as Infected, max((total_cases/ population))*100 as InfectedPercent
from covid_19.coronadeath
group by location, population
order by 4 desc;

-- Countries with highest death count per population

select location, max(cast(total_deaths as float)) as MaxTotalDeath
from covid_19.coronadeath
group by location
order by 2 desc;


-- Gobal death percentage to infected 

select date, sum(new_cases) as total_cases, sum(cast(new_deaths as float)) as total_deaths, sum(cast(new_deaths as float))/ sum(new_cases)*100 as DeathPercent
from covid_19.coronadeath  
group by date
order by 1;

select sum(new_cases) as total_cases, sum(cast(new_deaths as float)) as total_deaths, sum(cast(new_deaths as float))/ sum(new_cases)*100 as DeathPercent
from covid_19.coronadeath;

-- Let's Explore info about vaccinations
-- Total Population vs vaccination 



select dae.location,dae.date, dae.population, vac.new_vaccinations, 
sum(vac.new_vaccinations) over (partition by dae.location order by dae.location, dae.date) as RollingPeopleVaccinated
from covid_19.coronadeath dae join covid_19.coronavaccine vac  
on dae.location = vac.location
and dae.date = vac.date
order by 1,2;

-- Use CTE to calculate RollingPeopleVaccinated percentage to population

with Popvsvac (location, date, population, new_vaccinations, RollingPeopleVaccinated)
as (
	select dae.location, dae.date, dae.population, vac.new_vaccinations, 
	sum(vac.new_vaccinations) over (partition by dae.location order by dae.location, dae.date) as RollingPeopleVaccinated
	from covid_19.coronadeath dae join covid_19.coronavaccine vac  
	on dae.location = vac.location
	and dae.date = vac.date
)
select *, round((RollingPeopleVaccinated/population)*100, 3) as Percent
From Popvsvac

 
