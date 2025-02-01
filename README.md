**COVID-19 Data Analysis and Visualization 📊**

Overview
This project analyses COVID-19 data using SQL and visualises key insights with Tableau. The dataset includes global COVID-19 statistics,
and the analysis helps uncover trends related to infection rates, mortality, and vaccinations.

-- Files in This Repository

covid_analysis.sql → SQL queries used for data extraction and transformation.

dashboard.png → Tableau visualization of COVID-19 insights.

--SQL Analysis
The SQL script includes:
* Global and country-wise COVID-19 statistics
* Total cases vs. total deaths (likelihood of death upon infection)
* Infection rate by country (total cases vs. population)
* Highest infection and death rates by continent
* Vaccination progress (using CTEs and views for rolling calculations)

-- Tableau Dashboard
After extracting data using SQL, Tableau was used to create a dashboard showcasing:
*Global case and death numbers
*Total deaths per continent
*Percent population infected per country
*Infection trends over time
