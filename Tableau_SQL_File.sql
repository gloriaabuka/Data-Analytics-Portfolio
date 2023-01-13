-- 1. 

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From Test..Covid_Deaths$
--Where location like '%states%'
where continent is not null 
--Group By date
order by 1,2


-- 2. 

-- We take these out as they are not inluded in the above queries and want to stay consistent
-- European Union is part of Europe

Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From Test..Covid_Deaths$
Where continent is null and location not in ('High income', 'Upper middle income', 'Lower middle income', 'Low income')
and location not in ('World', 'European Union', 'International') --invalid continents that exist in the database
Group by location
order by TotalDeathCount desc

-- Vacination by location
select dea.location, sum(cast(vac.new_people_vaccinated_smoothed_per_hundred as numeric)) as Total_Vaccinations
from Test..Covid_Deaths$ as dea join
Test..Covid_Vaccinations$ as vac

on
dea.location = vac.location and
dea.date = vac.date
where dea.location not in ('World', 'European Union', 'International','High income', 'Upper middle income', 'Lower middle income', 'Low income')
group by dea.location





-- 3.

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From Test..Covid_Deaths$
--Where location like '%states%'
Group by Location, Population
order by PercentPopulationInfected desc


-- 4.


Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From Test..Covid_Deaths$
Group by Location, Population, date
order by PercentPopulationInfected desc
