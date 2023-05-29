SELECT 
 EXTRACT( DATE FROM CAST(update_time AS DATETIME) ) AS DATE,
  SUBSTR(CAST(DATETIME(update_time, "America/New_York") AS STRING),12,5) AS Time,
  distance,
  round(calorie) AS Calories,
  round(speed,2) AS Speed,
 
  count AS Step_count,
  (SELECT round(AVG(count)) FROM `personal-projects-387200.Jose_Samsung_Health.Jose_Steps`
) AS AVG_steps,
  (SELECT round(AVG(distance),2)
FROM `personal-projects-387200.Jose_Samsung_Health.Jose_Steps`) AS 
AVG_Distance

FROM `personal-projects-387200.Jose_Samsung_Health.Jose_Steps` 

WHERE

  (SUBSTR(CAST(DATETIME(update_time, "America/New_York") AS STRING),12,5) BETWEEN "08:00"  AND "23:59")
  AND 

  (EXTRACT( DATE FROM CAST(update_time AS DATETIME)) BETWEEN "2023-01-01" AND "2023-05-01")

ORDER BY
  Step_count DESC,
  DATE DESC
