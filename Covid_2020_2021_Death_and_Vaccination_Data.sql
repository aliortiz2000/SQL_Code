SELECT *
FROM PortfolioProject1..CovidDeaths

SELECT *
FROM PortfolioProject1..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 3,4

SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject1..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1,2 


-- Total Cases VS Total Deaths
-- Shows likelihood of dying if you contract covid in your country

SELECT Location, date, total_cases,total_deaths, ROUND((CAST (total_deaths AS int)/CAST (total_cases AS int))*100, 2) as Death_Percentage
FROM PortfolioProject1..CovidDeaths
WHERE continent IS NOT NULL
AND location LIKE '%Venezuela%' -- It shows the probability of dying if you were infected with covid in my country between 03-2020 and 04-2021.
ORDER BY 1,2 


-- Total Cases vs Population
-- Shows what percentage of population infected with Covid

SELECT Location, date, Population, total_cases,   ROUND((CAST (total_cases AS int)/CAST (population AS int))*100, 2) as Percent_Population_Infected
FROM PortfolioProject1..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1,2 


-- Countries with Highest Infection Rate compared to Population

SELECT Location, Population, MAX(CAST (total_cases AS int)) AS Highest_Infection_Count,   ROUND( MAX((CAST (total_cases AS int)/CAST (population AS int)))*100, 2) AS Percent_Population_Infected
FROM PortfolioProject1..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY Location, Population
ORDER BY Percent_Population_Infected DESC


-- Countries with Highest Death Count per Population

SELECT Location, MAX (CAST (total_deaths AS int)) AS Total_Death_Count
FROM PortfolioProject1..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY Location
ORDER BY Total_Death_Count DESC


-- Continents with Highest Death Count per Population

SELECT continent, MAX (CAST (total_deaths AS int)) AS Total_Death_Count
FROM PortfolioProject1..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY Total_Death_Count DESC


-- Global Number

SELECT Location, SUM(new_cases) AS Total_Cases, SUM( CAST (new_deaths AS int)) AS Total_Deaths, ROUND ( SUM ( CAST (new_deaths AS int))/SUM(new_cases) * 100 , 2 ) AS Deaths_Percentage
FROM PortfolioProject1..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY Location
ORDER BY Deaths_Percentage DESC, Total_Cases DESC, Total_Deaths DESC


-- Total of vaccinated by country

SELECT dea.Location, dea.Population, SUM ( CONVERT (int, vac.new_vaccinations)) AS Total_Vaccinated
FROM PortfolioProject1..CovidDeaths dea JOIN PortfolioProject1..CovidVaccinations vac
    ON dea.Location = vac.Location AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
GROUP BY dea.Location, dea.Population
ORDER BY 1


-- Total Population VS Vaccinations

SELECT dea.continent, dea.Location, dea.date, dea.Population, vac.new_vaccinations, 
    SUM ( CONVERT (int,vac.new_vaccinations)) OVER (PARTITION BY dea.Location ORDER BY dea.Location, dea.Date) AS Rolling_People_Vaccinated
FROM PortfolioProject1..CovidDeaths dea JOIN PortfolioProject1..CovidVaccinations vac
	ON dea.Location = vac.Location AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3


-- Using CTE to perform Calculation on Partition By in previous query

WITH PopVsVac (Continent, Location, Date, Population, New_Vaccinations, Rolling_People_Vaccinated) AS 
(
    SELECT dea.continent, dea.Location, dea.date, dea.Population, vac.new_vaccinations, 
        SUM ( CONVERT (int,vac.new_vaccinations)) OVER (PARTITION BY dea.Location ORDER BY dea.Location, dea.Date) AS Rolling_People_Vaccinated
    FROM PortfolioProject1..CovidDeaths dea JOIN PortfolioProject1..CovidVaccinations vac
        ON dea.Location = vac.Location AND dea.date = vac.date
    WHERE dea.continent IS NOT NULL
)

SELECT ROUND ((Rolling_People_Vaccinated/population)*100, 2) AS Percentage_Rolling_People_Vaccinated
FROM PortfolioProject1..PopVsVac


-- Using Temp Table to perform Calculation on Partition By in previous query

DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated (
    Continent nvarchar(255),
    Location nvarchar(255),
    Date datetime,
    Population numeric,
    New_vaccinations numeric,
    Rolling_People_Vaccinated numeric
)

INSERT INTO #PercentPopulationVaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
    SUM ( CONVERT (int,vac.new_vaccinations) ) OVER (PARTITION BY dea.Location ORDER BY dea.location, dea.Date) AS Rolling_People_Vaccinated
FROM PortfolioProject1..CovidDeaths dea JOIN PortfolioProject1..CovidVaccinations vac
	ON dea.location = vac.location AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3

SELECT *, ROUND ((Rolling_People_Vaccinated/population)*100, 2) AS Percentage_Rolling_People_Vaccinated
FROM #PercentPopulationVaccinated


-- Creating a View to store data for later visualization

CREATE VIEW PercentagePopulationVaccinated AS
	SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
        SUM ( CONVERT (int,vac.new_vaccinations) ) OVER (PARTITION BY dea.Location ORDER BY dea.location, dea.Date) AS Rolling_People_Vaccinated
    FROM PortfolioProject1..CovidDeaths dea JOIN PortfolioProject1..CovidVaccinations vac
        ON dea.location = vac.location AND dea.date = vac.date
    WHERE dea.continent IS NOT NULL

SELECT * FROM PercentagePopulationVaccinated