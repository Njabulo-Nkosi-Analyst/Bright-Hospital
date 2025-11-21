--checking column names
Select * 
from workspace.patient.hospitals
;limit 50;

--checking data type
describe workspace.patient.hospitals;

---count row 
select count (*) as `total row` 
from workspace.patient.hospitals;---3000

--checking for duplicates

select count(`Patient ID`) as normal
, count(distinct `Patient ID`) as distinct
from workspace.patient.hospitals;---3000

---checking for null value 

select *
from workspace.patient.hospitals
where 
      `Patient ID` is null or `Age` is null or `Gender` is null or 
      `Admission Type` is null or `Length of Stay` is null or `Number of Diagnoses` 
      is null or `Blood Pressure` is null or `Blood Sugar Levels` is null or `Previous 
      Admissions` is null or `Readmission` is null;---0 no null value

---final 

--QUESTION 1 & 2

select 
      count(distinct `Patient ID`) as `Total patient`,
      `Admission Type`
      ,gender
      ,Readmission
      ,
      --age basket
case 
      when age between 18 and 32 then '18-32 Young adults'
      when age between 33 and 47 then '33-47 Middle age'
      when age between 48 and 62 then '48-62 PreSenior'
      when age between 63 and 77 then '63-77 Senior'
      else '>77 Elderly'
      end as `age group`
      ,
      --QUESTION 2.2
     --LOS Basket
case 
      WHEN `Length of Stay` <= 2 THEN '0-2 Short Stay'
      WHEN `Length of Stay` BETWEEN 3 AND 5 THEN '3-5 Standard Stay'
      WHEN `Length of Stay` BETWEEN 6 AND 10 THEN '6-10 Medium Stay'
      ELSE '>= 11 Prolonged'
      end as `LOS Group`
      ,
      --QUESTION 2.3
 round(avg(`number of diagnoses` ),0) as `Average Diagnoses`
,round(avg(`Age` ),0) as `Average Age`
      ,
      --QUESTION 3.1
       --BLP Basket
       CASE
          WHEN `Blood Pressure` <= 120 then '0-120 Normal'  WHEN `Blood Pressure` between 121 and 129 then '121-129 Elevated'   
          WHEN `Blood Pressure` between 130 and 139 then  '130-139 high'  
          ELSE '>139 Crisis'
         end as `BP Group`
      ,   
      --BS Basket  
       CASE
          WHEN `blood sugar levels` <= 69 then '0-100 Hypoglycemia'  
          WHEN `blood sugar levels` between 70 and 125 then '70-125 Normal'   
          else '>125 Hyperglycemia'
          end as `BS Group`
         ,
         --QUESTION 3.2
         `number of diagnoses`
         ,
         --Question 4
     CASE 
          WHEN `Previous Admissions` = 0 then ' 0 First time' 
          WHEN `Previous Admissions` between 1 and 2 then '1-2 Occasional ' 
          else '>2 Frequent Patient' 
          end as `PD Group`

     from workspace.patient.hospitals

     group by
               `Admission Type`,`readmission`,`age`,
                Gender,`Lenght of Stay`,`blood pressure `,`Blood Sugar 
                Levels`,`Previous Admissions`,`number of diagnoses`,
               `patient id`
          ;
