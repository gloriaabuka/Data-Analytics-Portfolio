
select *
from Test..Covid_Deaths$
order by 3, 4


--select *
--from Test..Covid_Vaccinations$
--order by 3, 4

select location, date, total_cases, total_deaths, population
from Test..Covid_Deaths$
order by 1, 2

-- Examine the Percentage death rate in the united states
select location, date, total_cases, total_deaths, population, (total_deaths / total_cases) * 100 as Death_Rate
from Test..Covid_Deaths$
where location like 'united states'

--Examine percentage of infected people in the united states
select location, date, total_cases, population, (total_cases / population) * 100 as Percentage_infection_rate
from Test..Covid_Deaths$
where location like 'united states'

-- Contries with highest infection rates compared with population
select location, population, max(total_cases) as highestCount, max((total_cases / population) * 100) as Percentage_infection_rate
from Test..Covid_Deaths$
group by location, population
order by Percentage_infection_rate desc

-- Total death by countries
select location, max(total_deaths) as highestDeathCount
from Test..Covid_Deaths$
where continent is not null
group by location
order by highestDeathCount desc

-- Total deaths by continents
select continent, max(total_deaths) as highestDeathCount
from Test..Covid_Deaths$
where continent is not null
group by continent
order by highestDeathCount desc


-- Global Numbers by dates 
Select date, sum(new_cases) as global_cases, sum(cast(new_deaths as int)) as global_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as GlobalDeathRate
from Test..Covid_Deaths$
where continent is not null
group by date
order by 1, 2

-- Global Numbers(Total)
Select sum(new_cases) as global_cases, sum(cast(new_deaths as int)) as global_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as GlobalDeathRate
from Test..Covid_Deaths$


-- Take a look at the vaccination table
select *
from Test..Covid_Vaccinations$


-- Population Vs vaccination
Drop Table if exists #VaccinatedPopulation
create Table #VaccinatedPopulation 
(
continent varchar(255),
location varchar(255),
Date datetime,
population numeric, 
New_vaccinations numeric,
accumulated_vaxx numeric
)

insert into #VaccinatedPopulation
select dea.continent, dea.location, dea.date, dea.population, vacx.new_vaccinations,
SUM(cast(vacx.new_vaccinations as numeric)) OVER (partition by dea.location order by dea.location, dea.date) as accumulated_vaxx
from Test..Covid_deaths$ as dea join
Test..Covid_Vaccinations$ as vacx 
on
dea.location = vacx.location and
dea.date = vacx.date
--where dea.continent is not null
--order by 2, 3

select*,  (accumulated_vaxx/population)*100
from #VaccinatedPopulation


--- create a view
create view Global_Numbers_View as
Select sum(new_cases) as global_cases, sum(cast(new_deaths as int)) as global_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as GlobalDeathRate
from Test..Covid_Deaths$

-- take a look at view
select * from Global_Numbers_View

-- Total deaths per continent
Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From Test..Covid_Deaths$
Where continent is null and location not in ('High income', 'Upper middle income', 'Lower middle income', 'Low income')
and location not in ('World', 'European Union', 'International') 
Group by location
order by TotalDeathCount desc








