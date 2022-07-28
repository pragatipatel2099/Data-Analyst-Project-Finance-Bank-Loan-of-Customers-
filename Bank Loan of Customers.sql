create database Bank_loan;
use Bank_loan;
select * from Book1;
select * from  Book2;

##### KPI 1 (YEAR WISE LOAN AMOUNT STATS) #####
select year as issue_d, sum(loan_amnt) as Total_Loan_amnt from Book1 group by year;

##### KPI 2 (GRADE AND SUB GRADE WISE REVOL_BAL) #####
select grade, sub_grade,sum(revol_bal) as total_revol_bal
from Book1 B1 inner join Book2 B2 
on(B1.id = B2.id) 
group by grade,sub_grade
order by grade;


##### KPI 3 (Total Payment for Verified Status Vs Total Payment for Non Verified Status) #####
select verification_status, round(sum(total_pymnt),2) as Total_payment
from Book1 B1 inner join Book2 B2 
on(B1.id = B2.id) 
where verification_status in('Verified', 'Not Verified')
group by verification_status;



##### KPI 4 (State wise and last_credit_pull_d wise loan status) #####
select addr_state, last_credit_pull_d ,loan_status
from Book1 B1 inner join Book2 B2 
on(B1.id = B2.id) 
group by addr_state, last_credit_pull_d
order by addr_state;

##### KPI 5 (Home ownership Vs last payment date stats) #####
select home_ownership, last_pymnt_d as last_payment_date, sum(last_pymnt_amnt)
from Book1 B1 inner join Book2 B2 
on(B1.id = B2.id) 
where last_pymnt_d in(select max(STR_TO_DATE(B2.last_pymnt_d,'%d/%m/%Y')) from Book2)
group by  last_pymnt_d,home_ownership
having sum(last_pymnt_amnt) =
(	Select sum(last_pymnt_amnt)
	from Book2 B2 join Book1 B1
    on(B1.id=B2.id)
    group by last_pymnt_d, home_ownership
);


Select sum(last_pymnt_amnt) ,home_ownership
	from Book2 B2 join Book1 B1
    on(B1.id=B2.id)
    group by  last_pymnt_d,home_ownership order by last_pymnt_amnt desc;
















