
--convert columns to float for caculations 
alter table coviddeaths alter column population float 

--view entire table 
SELECT *
FROM [coviddeaths]



--Total number of new cases and new deaths in the last 90 days by date only in the United States
SELECT TOP 90 location, date, new_cases, new_deaths
FROM [coviddeaths]
WHERE location = 'united states' 
ORDER BY 1,2 DESC

--Top 10 Global Total cases and Total deaths
SELECT TOP 10 location, MAX(total_cases) as Total_Cases, MAX(total_deaths) as Total_Deaths
FROM [coviddeaths]
WHERE location <> 'world' and location <> 'upper middle income' and location <> 'high income' and location <> 'lower middle income'
GROUP BY location
ORDER BY 3 DESC

--As of today the top 25 locations that have the highest percent of deaths from Covid
SELECT TOP 25 location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as TotalDeathPercentage
FROM [coviddeaths]
WHERE total_deaths <> 0 and total_cases <> 0 and date = '2022-03-28'
ORDER BY 5 desc

--The top 10 days you had the highest chance of dying from Covid in the United states
SELECT TOP 10 location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as TotalDeathPercentage
FROM [coviddeaths]
WHERE total_deaths <> 0 and total_cases <> 0 and location = 'united states'
ORDER BY 5 desc

--The top 10 days you had the highest chance of NOT dying from Covid in the United states
SELECT TOP 10 location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as TotalDeathPercentage
FROM [coviddeaths]
WHERE total_deaths <> 0 and total_cases <> 0 and location = 'united states'
ORDER BY 5 

--Top 10 locations with the highest percentage of population that has been infected 
SELECT TOP 10 location, MAX((total_cases/population))*100 as PercentageInfected
FROM [coviddeaths]
WHERE total_cases <> 0 and population <> 0
GROUP BY location
ORDER BY 2 desc

--Top 10 locations with the lowest percentage of population that has been infected 
SELECT TOP 10 location, MAX((total_cases/population))*100 as PercentageInfected
FROM [coviddeaths]
WHERE total_cases <> 0 and population <> 0
GROUP BY location
ORDER BY 2 




--Top 20 locations that have the highest percentage of population killed by Covid
SELECT TOP 20 location, population, MAX(total_deaths) as TotalDeaths, MAX((total_deaths/population))*100 as Percentagekilled
FROM [coviddeaths]
WHERE total_cases <> 0 and population <> 0 and location <> 'south america'
GROUP BY location, population
ORDER BY 4 desc

--Created view for later
CREATE VIEW KilledByCovid as
SELECT location, population, MAX(total_deaths) as TotalDeaths, MAX((total_deaths/population))*100 as Percentagekilled
FROM [coviddeaths]
WHERE total_cases <> 0 and population <> 0 
GROUP BY location, population
--ORDER BY 3 desc