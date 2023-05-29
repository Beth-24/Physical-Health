SELECT  
  REPLACE(LEFT(Date_and_Time, 10),'.','-') AS DATE,
  RIGHT(Date_and_Time,8) AS Time,
  Weight,
  Body_Fat,
  AVG(CAST(weight AS FLOAT64)) as AVERAGE_WEIGHT

FROM `personal-projects-387200.Wyze.Jose_Wyze` 

WHERE
  ( REPLACE( LEFT(Date_and_Time, 10),'.','-')
  BETWEEN
  "2023-01-01" AND "2023-05-01")
  AND
   RIGHT(Date_and_Time,8) BETWEEN "08:00" AND "23:00"

GROUP BY
  Date_and_Time,
  Weight,
  Body_Fat
  
ORDER BY
  Date_and_Time
