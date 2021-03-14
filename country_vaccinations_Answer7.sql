--------------------------------------------------------------------------------------------------------------------------------------------------
/*											Q   U   E   S   T   I   O   N    7																	*/
--------------------------------------------------------------------------------------------------------------------------------------------------
/* Code Implementation Task: If this list would be a database table, please provide SQL query to fill in the missing daily vaccination numbers 
   with discrete median of country as similar to question a.  

   Please  provide the link to your code as answer to this question. 

   Note: This time SQL equivalent is requested, and imputation value is median of each country, not minimum. 
   Please remember filling countries with zero if they do not have any valid daily_vaccination records like Kuwait. */
---------------------------------------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------------------
/*     First of all, I created a 'country_vaccination' table from excel file via SQL Server Import and Export Wizard        */
-------------------------------------------------------------------------------------------------------------------------------



---------------------------------------------------------------------------------
/*        I'll add 'filled_daily_vaccinations' as column                       */
---------------------------------------------------------------------------------
ALTER TABLE country_vaccination
ADD filled_daily_vaccinations float;




---------------------------------------------------------------------------------
/*   I'll check the 'filled_daily_vaccinations' column can be added or not.    */
---------------------------------------------------------------------------------
SELECT *
  FROM [VACCINATION].[dbo].[country_vaccination]




------------------------------------------------------------------------------------------
/* I'll fill the values of 'filled_daily_vaccinations' from 'daily_vaccinations' column.*/ 
------------------------------------------------------------------------------------------
UPDATE country_vaccination SET filled_daily_vaccinations = daily_vaccinations




------------------------------------------------------------------------------------------
/*           I'll check the values of 'filled_daily_vaccinations' column                */
------------------------------------------------------------------------------------------
SELECT *
  FROM [VACCINATION].[dbo].[country_vaccination]




------------------------------------------------------------------------------------------
/*         I will check the median values of 'daily_vaccinations' by country.           */
------------------------------------------------------------------------------------------
SELECT country, 
       daily_vaccinations, 
       PERCENTILE_CONT(0.5) 
         WITHIN GROUP (ORDER BY daily_vaccinations) OVER ( 
           PARTITION BY country) AS Median
FROM   country_vaccination
ORDER  BY country ASC





---------------------------------------------------------------------------------------------------
/*  I will fill the 'filled_daily_vaccinations' values with the median values of the countries. */
---------------------------------------------------------------------------------------------------

WITH temp AS (

SELECT country, 
       filled_daily_vaccinations, 
       PERCENTILE_CONT(0.5) 
         WITHIN GROUP (ORDER BY daily_vaccinations) OVER ( 
           PARTITION BY country) AS Median
FROM   country_vaccination
)

UPDATE temp SET filled_daily_vaccinations = Median WHERE filled_daily_vaccinations IS NULL





------------------------------------------------------------------------------------------------------------------------------
/*          If there is a missing data in the filled_daily_vaccinations column, it means that the country does              */
/*          not have any valid vaccination number yet for the corresponding row. I'll fill it with 0.                       */
------------------------------------------------------------------------------------------------------------------------------
SELECT *
  FROM [VACCINATION].[dbo].[country_vaccination] WHERE filled_daily_vaccinations IS NULL

-- I will fill it 0.
UPDATE [VACCINATION].[dbo].[country_vaccination] SET filled_daily_vaccinations = 0 WHERE filled_daily_vaccinations IS NULL

-- I'll check the Kuwait data.
SELECT * FROM [VACCINATION].[dbo].[country_vaccination] WHERE country = 'Kuwait'







