use sakila;
select count(distinct address2) from address;
alter table address drop column address2;

select * from address;
#concat
select address_id, address,district, concat(address,', ',district) as full_address from address;

#substring
select customer_id,first_name,last_name,
substring(first_name,1,2) as Nick_Name,
substring(last_name,1,2) as Nick_Sur
from customer;
#concat password
select customer_id,first_name,last_name,
concat(substring(first_name,1,2),
substring(last_name,1,2)) as password
from customer;

select customer_id, first_name,last_name,
substring(first_name,-3,2) as Nick_name
from customer;
#upper case and lower function
select first_name, last_name,
upper(first_name) UFN,
lower(last_name) LLN
from customer;

#lenght
select first_name, last_name,
 length(last_name) as Len_Last_Name
from customer;

# capitalize only the first letter
select first_name, last_name,
concat(upper(substring(first_name,1,1)),
lower(substring(first_name,2,length(first_name)-1))) as Name_Format
from customer;

#replace
select address, replace(address,"Drive","Nothing") 
from address;

#left right
select address, district, 
left(district,2) as first_two,
right(district,2) as last_two
from address;

#trim function
 update customer
 set first_name = "   LINDA     "
 where customer_id = 3;
 
 select customer_id,store_id,
 trim(first_name) as first_name, last_name
 from customer;
 
  update customer
 set first_name = "LINDA"
 where customer_id = 3;
 
 #logical functions
 
 select * from rental;
 
 select 
 if(datediff(return_date,rental_date) > 7,"Delayed","On_time") as Retrun_Status,
 count(rental_id) total_orders
 from rental
 group by return_status;
 
 #0-3 low  , 3-6 avg , 6-9 high and 9+ very high
 select * from payment;
 #case
 select 
 payment_id, customer_id,
 case 
 when amount < 3 then "Low"
 when amount > 3 and amount <= 6 then "Avgerage" 
 when amount > 6 and amount <=9 then "High"
 else "Very High"
 End as Payment_category
 from payment;
 
 select  
case 
when amount <= 3 then "Low"
when amount > 3 and amount <= 6 then "Average"
when amount > 6 and amount <= 9 then "High"
else "Very High"
End as Payment_Category,
count(payment_id) as No_of_Payments,
round(sum(amount)/1000,0) as Total_Payment
from payment
group by Payment_Category;

# window functions
select * from rental;

select row_number() over(order by Country_pop desc) as Row_num_Pop,
row_number() over(order by LifeExpectancy desc) as Row_num_LE,
country_code,country_name,continent,Region, SurfaceArea, Country_pop, LifeExpectancy
from country;

select row_number() over(partition by Continent order by Country_pop desc) as Row_num_Pop,
country_code,country_name,continent,
Region, SurfaceArea, Country_pop, LifeExpectancy
from country;