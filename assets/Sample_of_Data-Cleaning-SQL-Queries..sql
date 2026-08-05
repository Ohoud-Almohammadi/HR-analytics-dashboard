CREATE TABLE [dbo].[Employees](
	[EmpID] [int] NOT NULL,
	[Employee_Name] [varchar](255) NULL,
	[MarriedID] [int] NULL,
	[MaritalStatusID] [int] NULL,
	[GenderID] [int] NULL,
	[EmpStatusID] [int] NULL,
	[DeptID] [int] NULL,
	[PerfScoreID] [int] NULL,
	[FromDiversityJobFairID] [int] NULL,
	[Salary] [float] NULL,
	[Termd] [varchar](50) NULL,
	[PositionID] [int] NULL,
	[State] [varchar](100) NULL,
	[Zip] [varchar](50) NULL,
	[DOB] [date] NULL,
	[CitizenDesc] [varchar](100) NULL,
	[HispanicLatino] [varchar](100) NULL,
	[RaceDesc] [varchar](100) NULL,
	[DateofHire] [date] NULL,
	[DateofTermination] [date] NULL,
	[TermReason] [varchar](max) NULL,
	[ManagerID] [int] NULL,
	[RecruitmentSource] [varchar](255) NULL,
	[EngagementSurvey] [float] NULL,
	[EmpSatisfaction] [int] NULL,
	[SpecialProjectsCount] [int] NULL,
	[LastPerformanceReview_Date] [varchar](100) NULL,
	[DaysLateLast30] [int] NULL,
	[Absences] [int] NULL,
	)

SELECT *
FROM Employees; 


-- Data Cleaning

-- Remove Duplicates
SELECT *,
       ROW_NUMBER() OVER(PARTITION BY employee_name, empid, salary, dob) AS ROW_NUM
FROM Employees;



WITH duplicate_cte AS
(
SELECT *,
       ROW_NUMBER() OVER(PARTITION BY employee_name, empid, salary, dob) AS ROW_NUM
FROM Employees
)
SELECT *
FROM duplicate_cte
WHERE ROW_NUM > 1;




-- Convert data types

SELECT dob, 
    TRY_CONVERT(DATE, dob, 101) AS converted_dob
FROM Employees


UPDATE Employees
SET dob = TRY_CONVERT(DATE, dob, 101)
WHERE TRY_CONVERT(DATE, dob, 101) IS NOT NULL;

SELECT dob
FROM Employees;


ALTER TABLE Employees
ALTER COLUMN dob DATE;


-- Convert other Columns

SELECT 
    dateoftermination, 
    TRY_CONVERT(DATE, dateoftermination, 101) AS converted_termination,
    lastperformancereview_date, 
    TRY_CONVERT(DATE, lastperformancereview_date, 101) AS converted_review,
    dateofhire, 
    TRY_CONVERT(DATE, dateofhire, 101) AS converted_hire
FROM Employees;


UPDATE Employees
SET 
    dateoftermination = TRY_CONVERT(DATE, dateoftermination, 101),
    lastperformancereview_date = TRY_CONVERT(DATE, lastperformancereview_date, 101),
    dateofhire = TRY_CONVERT(DATE, dateofhire, 101);

-- تغيير نوع عمود تاريخ إنهاء الخدمة
ALTER TABLE Employees
ALTER COLUMN dateoftermination DATE;

-- تغيير نوع عمود تاريخ آخر تقييم
ALTER TABLE Employees
ALTER COLUMN lastperformancereview_date DATE;

-- تغيير نوع عمود تاريخ التعيين
ALTER TABLE Employees
ALTER COLUMN dateofhire DATE;


SELECT dateoftermination,
		lastperformancereview_date,
		dateofhire
FROM Employees;


-- check Missing/NULL Values 

SELECT *
FROM Employees

SELECT DISTINCT termreason
FROM Employees
WHERE termreason IS NULL


SELECT employee_name ,dateoftermination, termreason
FROM Employees
WHERE  dateoftermination IS NULL