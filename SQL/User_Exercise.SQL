SELECT   
  EXTRACT( DATE FROM CAST(com_samsung_health_exercise_max_heart_rate AS       
    DATETIME) ) AS DATE,
    SUBSTR 
    (CAST
      (DATETIME
        (com_samsung_health_exercise_max_heart_rate, "America/New_York") AS   
         STRING),12,5
    )  AS Time,
 
  routine_datauuid AS Calories_burned,
  com_samsung_health_exercise_incline_distance AS Avg_heart_rate,


FROM `personal-projects-387200.Jose_Samsung_Health.Jose_Exercise`

WHERE
  (EXTRACT( DATE FROM CAST(com_samsung_health_exercise_max_heart_rate AS    
    DATETIME)) BETWEEN "2023-01-01" AND "2023-05-01")


ORDER BY
  com_samsung_health_exercise_max_heart_rate

