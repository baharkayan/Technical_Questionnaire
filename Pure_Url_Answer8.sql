----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                                                   Q   U   E   S   T   I   O   N    8																					 */
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*  Assume any database includes below columns and you are requested to process Stats_Access_Link column and extract pure url information inside per device type. 

    Rules: 
-   Xml tags and protocol parts is guaranteed to be lower case  
-   Access link part that we are interested in can have alpha-numeric, case insensitive characters, underscore ( _ ) character and dot ( . ) character only.  

What would you use for this task, please write your detailed answer with exact solution? Please  provide the link to your code as answer to this question 

Example: for the device type AXO145, we would like to get xcd32112.smart_meter.com regardless from its access protocol is SSL secured or not.  */
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------
/*               I'll create DEVICE_LINK table                                 */
---------------------------------------------------------------------------------
CREATE TABLE DEVICE_LINK(
Device_Type varchar(50) not null,
Stats_Access_Link nvarchar(max) not null,
);




--------------------------------------------------------------------------------------------------------------------------
/*                                  I'll INSERT data to the table								                        */
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO DEVICE_LINK(Device_Type,Stats_Access_Link) VALUES ('AXO145','<url>https://xcd32112.smart_meter.com</url>')
INSERT INTO DEVICE_LINK(Device_Type,Stats_Access_Link) VALUES ('TRU151','<url>http://tXh67.dia_meter.com</url>')
INSERT INTO DEVICE_LINK(Device_Type,Stats_Access_Link) VALUES ('ZOD231','<url>http://yT5495.smart_meter.com</url>')
INSERT INTO DEVICE_LINK(Device_Type,Stats_Access_Link) VALUES ('YRT326','<url>https://ret323_TRu.crown.com</url>')
INSERT INTO DEVICE_LINK(Device_Type,Stats_Access_Link) VALUES ('LWR245','<url>https://luwr3243.celcius.com</url>')



----------------------------------
/*   I'll check the records     */
----------------------------------
SELECT * FROM DEVICE_LINK



--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
/*                                                I'll extract pure url information for per device type						                                                                                      */
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
select Device_Type, 
   left (SUBSTRING(Stats_Access_Link, CHARINDEX('/',Stats_Access_Link) + 2, len(Stats_Access_Link)), len(SUBSTRING(Stats_Access_Link, CHARINDEX('/',Stats_Access_Link) + 2, len(Stats_Access_Link)))-6) AS Pure_Url 
   from DEVICE_LINK


