create database pro2 ;
use pro2;
select count(*) from hr_1;
select count(*) from hr_2;

select * from hr_1;
alter table hr_1
rename column ï»¿Age to Age;

select * from hr_2;
alter table hr_2
change column `ï»¿Employee ID` Employee_ID int;

select * from hr_1;
select * from hr_2;

#Average Attrition rate for all Departments
SELECT department ,COUNT(CASE WHEN attrition = 'yes' THEN 1 END) AS attrition_count,
COUNT(*) AS total_records,
CONCAT(ROUND((COUNT(CASE WHEN attrition = 'yes' THEN 1 END) / COUNT(*)) * 100, 2), '%') AS attrition_rate
FROM hr_1 
group by department;

#Average Hourly rate of Male Research Scientist
select avg(HourlyRate) as average_hourly_rate, gender, jobrole 
from hr_1
where gender="male" and JobRole="Research Scientist";

#Attrition rate Vs Monthly income stats
select department,
CONCAT(ROUND((COUNT(CASE WHEN attrition = 'yes' THEN 1 END) / COUNT(*)) * 100, 2), '%') AS attrition_rate ,
round(avg(MonthlyIncome),2) average_income 
from hr_1 inner join hr_2 
on (hr_1.EmployeeNumber=hr_2.Employee_ID)
group by department;

#Average working years for each Department
select department,
round(avg(Totalworkingyears),0) average_workingyears
from hr_1 inner join hr_2 
on (hr_1.EmployeeNumber=hr_2.Employee_ID)
group by department;

#Departmentwise No of Employees
select department, count(employeenumber) as employee_Number
from hr_1
group by department;

#Count of Employees based on Educational Fields
select educationfield, count(employeenumber) as employee_Number
from hr_1
group by educationfield;

#Job Role Vs Work life balance
select distinct(hr_1.jobrole),
(case when hr_2.WorkLifeBalance = 1 then "1.Poor" 
when hr_2.WorkLifeBalance = 2 then "2.Average" 
when hr_2.WorkLifeBalance = 3 then "3.Good" 
else "4.excellent"end) as worklifebal_status,
count(hr_2.WorkLifeBalance) as count_worklifebalance 
from hr_1 inner join hr_2
on hr_1.EmployeeNumber = hr_2.Employee_id
group by 1 ,2
order by worklifebal_status asc,count_worklifebalance desc;

#Attrition rate Vs Year since last promotion relation
select hr_1.department,
round((count(case when attrition='yes' then 1 end)/count(*))*100,2) as attrition_rate,
round(avg(hr_2.YearsSinceLastPromotion),2) as avg_years_since_last_promotion
from hr_1 inner join hr_2 
on (hr_1.EmployeeNumber=hr_2.Employee_ID)
group by department;

#Gender based Percentage of Employee
SELECT gender,
CONCAT(ROUND((COUNT(*) / (SELECT COUNT(*) FROM hr_1)) * 100, 2), '%') AS percent
FROM hr_1
GROUP BY gender;

#Job Role wise job satisfaction
select distinct jobrole,
(case when JobSatisfaction = 1 then "1.Poor" 
when JobSatisfaction = 2 then "2.Average" 
when JobSatisfaction = 3 then "3.Good" 
else "4.excellent"end) as JobSatisfaction_status,
count(JobSatisfaction) as count_JobSatisfaction
from hr_1
group by 1 ,2
order by 2 asc,3 desc;
