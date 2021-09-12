select *
From ['data set$']

--- Question 1
--- Table uploaded to Excel for Viz
With ROI (date, Marketing_Spend, RevenueD0,RevenueD1,RevenueD7,RevenueD10,RevenueD30)
as
(
Select date, sum(spend) as 'Marketing_Spend', 
	sum(Deposit_Amount_D0) as 'RevenueD0',
	sum(Deposit_Amount_D1) as 'RevenueD1',
	sum(Deposit_Amount_D7) as 'RevenueD7',
	sum(Deposit_Amount_D10) as 'RevenueD10',
	sum(Deposit_Amount_D30) as 'RevenueD30'
from ['data set$']
group by date)
select *, round((RevenueD30/Marketing_Spend)*100,1) as ROIRate
from ROI
Order by Date

--- QUESTION 2 - Analysing data to understand completion tutorial rates 
With Tutorial_comptut (date, country, Regs, Comp_tut)
as (
select date, country, sum(regs) as Regs, sum(complete_tutorial) as Comp_tut
from ['data set$']
group by country, date
)
select *, Comp_tut/Regs as Comptut_rate
from Tutorial_comptut
order by date

--- Question 3 - Preparing Data to calculate ARPDAU and KPIs
--- Trends Per month

Select DATENAME(MONTH, date) as [Month], 
sum(Regs) as TotalRegs, 
sum(deposits_D30) as TotalDepCount, 
sum(Depositors_D30) as Total_Depositors, 
sum(Deposit_Amount_D30) as Total_Income,
Sum(spend) as TotalSpentMarketing,
sum(ret_day1) as DAU_D1,
sum(ret_day7) as DAU_D7,
sum(Deposits_D30) as Paying_user
from ['data set$']
group by date, country

--- Question 4 - Preparing Data to understand Retention rates

With Ret_Rate (Date, country, TotalRegs, TotalRD1, TotalRD7)
as
(
Select Date, country,
sum(Regs) as 'TotalRegs', 
sum(Ret_Day1) as 'TotalRD1', 
sum(Ret_Day7) as 'TotalRD7'
from ['data set$']
group by Date, country)
select *,round((TotalRD1/TotalRegs)*100,1) as Ret_RateD1,
		round((TotalRD7/TotalRegs)*100,1) as Ret_RateD7
From Ret_Rate
order by date
