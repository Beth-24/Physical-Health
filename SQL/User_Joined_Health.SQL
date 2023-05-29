SELECT 
  #STEPS
  EXTRACT( DATE FROM CAST(joseSteps.update_time AS DATETIME) ) AS DATE_STEPS,
  FORMAT_DATE('%A',  EXTRACT( DATE FROM CAST(joseSteps.update_time AS DATETIME) )) AS day_of_the_Week,
  FORMAT_DATE('%B',  EXTRACT( DATE FROM CAST(joseSteps.update_time AS DATETIME) )) AS Month,
  SUBSTR(CAST(DATETIME(joseSteps.update_time, "America/New_York") AS STRING),12,5) AS Time_steps,
  ROUND((joseSteps.distance/ 1609),2)  AS Distance_miles, 
  joseSteps.distance  AS Distance_meters,
  round(joseSteps.calorie) AS Calories,
  round(joseSteps.speed,2) AS Speed,
  joseSteps.count AS Step_count,

  # WYZE
  joseWyze.AVG_WEIGHT,
  joseWyze.AVG_BODY_FAT,

  #Exercise
    joseExercise.AVG_CALORIES_BURNED,
    joseExercise.AVERAGE_HEART_RATE

FROM `personal-projects-387200.Jose_Samsung_Health.Jose_Steps` AS joseSteps 
  LEFT JOIN (
    SELECT 
     REPLACE( LEFT(Date_and_Time, 10),'.','-') AS DATE,
      AVG(CAST(REPLACE(Weight,"lb","") AS FLOAT64)) as AVG_WEIGHT,
      AVG(CAST(REPLACE(Body_Fat,"%","") as FLOAT64)) as AVG_BODY_FAT
      FROM `personal-projects-387200.Wyze.Jose_Wyze`
      WHERE Weight is not null and Weight != "BPM" and Weight != "78/min" and Body_Fat is not null and Body_Fat != "- -"
      GROUP BY REPLACE( LEFT(Date_and_Time, 10),'.','-')
  ) as joseWyze
    ON (CAST (EXTRACT(DATE FROM CAST(joseSteps.update_time AS DATETIME)) AS STRING)) = joseWyze.DATE
  
  
  LEFT JOIN (SELECT
    EXTRACT( DATE FROM CAST(com_samsung_health_exercise_max_heart_rate AS DATETIME) ) AS Exercise_DATE,
    AVG(routine_datauuid) AS AVG_CALORIES_BURNED,
    AVG(com_samsung_health_exercise_incline_distance) AS AVERAGE_HEART_RATE 
    FROM `personal-projects-387200.Jose_Samsung_Health.Jose_Exercise`
    GROUP BY
       EXTRACT( DATE FROM CAST(com_samsung_health_exercise_max_heart_rate AS DATETIME) )
  ) joseExercise ON  (CAST (EXTRACT(DATE FROM CAST(joseSteps.update_time AS DATETIME)) AS STRING)) =CAST(EXTRACT( DATE FROM CAST(joseExercise.     
   Exercise_DATE AS DATETIME) ) AS STRING)

WHERE 
  (SUBSTR(CAST(DATETIME(joseSteps.update_time, "America/New_York") AS STRING),12,5) BETWEEN "08:00"  AND "23:59")
  AND (EXTRACT( DATE FROM CAST(joseSteps.update_time AS DATETIME)) BETWEEN "2023-01-01" AND "2023-05-01")

ORDER BY
  Step_count DESC,
  DATE_STEPS DESC
