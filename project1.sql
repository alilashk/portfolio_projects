-- create table, in order to import the data from CSV file we first need
-- to create a table with the columns 
-- table explanation : 
--NAME	LABEL
--DT_DAY	Day
--DT_HOUR	Time of day
--CD_DAY_OF_WEEK	Day of week
--TX_DAY_OF_WEEK_DESCR_FR	Day of the month
--TX_DAY_OF_WEEK_DESCR_NL	Day of the month
--CD_BUILD_UP_AREA	Business key
--TX_BUILD_UP_AREA_DESCR_NL	Build up area
--TX_BUILD_UP_AREA_DESCR_FR	Build up area
--CD_COLL_TYPE	Business key
--TX_COLL_TYPE_DESCR_NL	Collision type
--TX_COLL_TYPE_DESCR_FR	Collision type
--CD_LIGHT_COND	Business key
--TX_LIGHT_COND_DESCR_NL	Light conditions
--TX_LIGHT_COND_DESCR_FR	Light conditions
--CD_ROAD_TYPE	Business key
--TX_ROAD_TYPE_DESCR_NL	Road type
--TX_ROAD_TYPE_DESCR_FR	Road type
--CD_MUNTY_REFNIS	REFNIS code of the municipality
--TX_MUNTY_DESCR_NL	Municipality name in Dutch
--TX_MUNTY_DESCR_FR	Municipality name in French
--CD_DSTR_REFNIS	REFNIS code of the district
--TX_ADM_DSTR_DESCR_NL	Administrative district name in Dutch
--TX_ADM_DSTR_DESCR_FR	Administrative district name in French
--CD_PROV_REFNIS	REFNIS code of the province
--TX_PROV_DESCR_NL	Province name in Dutch
--TX_PROV_DESCR_FR	Province name in French
--CD_RGN_REFNIS	REFNIS code of the region
--TX_RGN_DESCR_NL	Region name in Dutch
--TX_RGN_DESCR_FR	Region name in French
--MS_ACCT	Number of accidents with dead or injured
--MS_ACCT_WITH_DEAD	Number of accidents with dead
--MS_ACCT_WITH_DEAD_30_DAYS	Number of accidents with dead 30 days
--MS_ACCT_WITH_MORY_INJ	Number of accidents with mortally injured
--MS_ACCT_WITH_SERLY_INJ	Number of accidents with severely injured
--MS_ACCT_WITH_SLY_INJ	Number of accidents with slightly injured
-- Source : https://statbel.fgov.be/en/open-data/road-accidents-2021 

create table TF_Accidents_2021 ( 
DT_DAY date, 
DT_HOUR integer,
CD_DAY_OFWEEK integer,
TX_DAY_OF_WEEK_FR varchar (25),
TX_DAY_OF_WEEK_NL varchar (25),
CD_BUILD_UP_AREA integer, 
TX_BUILD_UP_AREA_DESCR_NL varchar(25), 
TX_BUILD_UP_AREA_DESCR_FR varchar (25),
CD_COLL_TYPE integer, 
TX_COLL_TYPE_DESCR_NL varchar (100),
TX_COLL_TYPE_DESCR_FR varchar (100),
CD_LIGHT_COND integer, 
TX_LIGHT_COND_DESCR_NL varchar (100),
TX_LIGHT_COND_DESCR_FR varchar (100), 
CD_ROAD_TYPE integer,
TX_ROAD_TYPE_DESCR_NL varchar (100),
TX_ROAD_TYPE_DESCR_FR varchar (100),
CD_MUNTY_REFNIS varchar (25), 
TX_MUNTY_DESCR_NL varchar (50), 
TX_MUNTY_DESCR_FR varchar (50), 
CD_DSTR_REFNIS varchar (25), 
TX_ADM_DSTR_DESCR_NL varchar (50),
TX_ADM_DSTR_DESCR_FR varchar (50),
CD_PROV_REFNIS varchar (25), 
TX_PROV_DESCR_NL varchar (50), 
TX_PROV_DESCR_FR varchar (50), 
CD_RGN_REFNIS varchar (25), 
TX_RGN_DESCR_NL varchar (50), 
TX_RGN_DESCR_FR varchar (50), 
MS_ACCT integer, 
MS_ACCT_WITH_DEAD integer, 
MS_ACCT_WITH_DEAD_30_DAYS integer,
MS_ACCT_WITH_MORY_INJ integer, 
MS_ACCT_WITH_SERLY_INJ integer, 
MS_ACCT_WITH_SLY_INJ integer
	)
	
--table created 
--now we want to just have a look at the table. 
-- then import the data manually from the excel table 
--to do so : click on the tf_accidents_2021 table and then import
-- problem encountered during data : 1) data to CSV : ';' delimiter 
-- C:\Users\ali\Desktop\project\TF_ACCIDENTS_2021_PROJECT_1.csv 
-- UFT8
-- 2) chaging date format in excel 

select * from tf_accidents_2021

--better to order by date
select * from tf_accidents_2021
order by dt_day

-- which day of the week/end has the largest number of accidents ? using 'case when'
--Friday highest numbers of accidents, Sunday lowest number of accidents
-- display all week and weekend days.

select 

sum (case  cd_day_ofweek
	 when 1 then 1
	 else 0 
	 end) as accidents_lundi,
	 
sum (case cd_day_ofweek
	 when 2 then 1 
	 else 0 
	 end) as accidents_mardi,
sum (case cd_day_ofweek
	when 3 then 1 
	else 0
	end ) as accidents_mercredi, 
sum (case cd_day_ofweek
	when 4 then 1 
	else 0
	end) as accidents_jeudi,
	
sum (case cd_day_ofweek
	when 5 then 1 
	else 0 
	end) as accidents_vendredi,
sum (case cd_day_ofweek
	when 6 then 1
	else 0
	end) as accidents_samedi,
	
sum (case cd_day_ofweek 
	when 7 then 1 
	else 0 
	end ) as accidents_dimanche
	 
from tf_accidents_2021
-- easier way to get the frequency of days
select tx_day_of_week_fr, count ( tx_day_of_Week_fr) from tf_accidents_2021
group by tx_day_of_week_fr 
order by count (tx_day_of_Week_fr)

-- here with days of the week as numbers
select cd_day_ofweek,tx_day_of_week_fr ,count(tx_day_of_week_fr) from tf_accidents_2021 
group by cd_day_ofweek,tx_day_of_Week_fr
order by count (tx_day_of_week_fr) desc
-- number of accidents that happened during daylight : 

select  count (tx_light_cond_descr_fr) from tf_accidents_2021 
where tx_light_cond_descr_fr = 'Plein jour'


-- ordering by date
select * from tf_accidents_2021
order by dt_day
-- creating new view (before dependent ==> cascade)
create view overall_ as 
select * from tf_accidents_2021
order by dt_day
--how many accidents did take place during the  new year ? 
select count (tx_day_of_week_fr) from tf_accidents_2021
where dt_day between ('2021-01-01') and ('2021-01-01')
-- number of average accidents : 
select  sum(ms_acct)/365 from tf_accidents_2021
select avg
select tx_day_of_Week_fr, avg(count(tx_day_of_week_fr)) from tf_accidents_2021
-- using view 
select * from overall_
-- removing the columns in dutch
alter table tf_accidents_2021
 drop column tx_build_up_area_descr_nl cascade,
drop column tx_coll_type_descr_nl cascade, drop column tx_light_cond_descr_nl cascade, 
drop column tx_road_type_descr_nl cascade, drop column tx_munty_descr_nl cascade, 
drop column tx_adm_dstr_descr_nl cascade, drop column tx_prov_descr_nl cascade, 
drop column tx_rgn_descr_nl cascade
-- select * from overall_
create view overall_ as 
select * from tf_accidents_2021
order by dt_day
-- to see if the view created is functional
select * from overall_
-- counting number of different regions.
select distinct tx_rgn_descr_fr from tf_accidents_2021
-- counting number of accidents per region using case when'
select  
sum (case 
  when (tx_rgn_descr_fr = 'Région flamande') then 1
 else 0 
 end)
 as région_flamande,
 sum (case 
	when (tx_rgn_descr_fr = 'Région wallonne') then 1
		 else 0
		 end )
	  as région_wallonne,
sum (case 
	when (tx_rgn_descr_fr = 'Région de Bruxelles-Capitale') then 1
	else 0 
	end ) 
	 as région_BXL
	 
 from tf_accidents_2021
-- easier way of calculating number of accidents per region
 select tx_rgn_descr_fr, count(tx_rgn_descr_fr) from tf_accidents_2021
 group by tx_rgn_descr_fr
 
-- number of accidents in agglomeration, outide of agglomeration and 'no data'
 select tx_build_up_area_descr_fr, count (tx_build_up_area_descr_fr) from tf_accidents_2021
 group by tx_build_up_area_descr_fr
--
 select * from overall_
-- number of accidents 
select sum (ms_acct) from tf_accidents_2021
-- ratio dead/accidents, *100 % important for integer to float/deci : * 1.0
select (sum (ms_acct_with_dead*1.0)/ sum (ms_acct*1.0)) *100 from tf_accidents_2021

-- number of accidents 
select tx_rgn_descr_fr,
sum (case ms_acct
	when 1 then 1
	else 0
	end) as number_of_injured, 
sum (case ms_acct
	when 2 then 1 
	else 0
	end) as number_of_dead 
from tf_accidents_2021
group by tx_rgn_descr_fr

-- ??xx?? just pour example
select tf_accidents_2021.tx_rgn_descr_fr,tf_accidents_2021.ms_acct, 
count (ms_acct) from tf_accidents_2021
group by tf_accidents_2021.ms_acct,tf_accidents_2021.tx_rgn_descr_fr

-- numbr of death per region
select tx_rgn_descr_fr,  sum (ms_acct_with_dead)  from tf_accidents_2021
group by tx_rgn_descr_fr
order by sum (ms_acct_with_dead)

-- number of accidents with pedestrians 

select  tx_rgn_descr_fr,TX_COLL_TYPE_DESCR_FR ,sum (ms_acct_with_dead) from tf_accidents_2021
where TX_COLL_TYPE_DESCR_FR = 'Avec un piéton'  
group by tx_rgn_descr_fr,TX_COLL_TYPE_DESCR_FR
order by sum (ms_acct_with_dead)
-- ?? xx ??

select dt_day,  tx_rgn_descr_fr , sum  (ms_acct_with_dead) from tf_accidents_2021
where dt_day between '01-01-2021' and '01-06-2021'
group by dt_day, tx_rgn_descr_fr

-- number of deaths per month per region 
select tx_rgn_descr_fr,extract (month from dt_day) as month, sum (ms_acct_with_dead)
from tf_accidents_2021
group by tx_rgn_descr_fr, extract (month from dt_day)
order by sum (ms_acct_with_dead) desc
-- 
select *  from overall_
-- number of accidents per month per region
select extract (month from dt_day), tx_rgn_descr_fr, sum (ms_acct)
from tf_accidents_2021
where ms_acct = 1
group by extract (month from dt_day), tx_rgn_descr_fr

-- number of accidents with 2 or 3 injuries 
select tx_rgn_descr_fr, sum(ms_acct) from tf_accidents_2021
where ms_acct  = 2 or ms_acct = 3
group by tx_rgn_descr_fr, ms_acct
	
-- 
select tx_light_cond_descr_fr, tx_rgn_descr_fr  ,sum (ms_acct) as num_acc, sum (ms_acct_with_dead) as num_deaths from tf_accidents_2021
where tx_light_cond_descr_fr = 'Nuit sans éclairage public'
group by tx_light_cond_descr_fr, tx_rgn_descr_fr
--  accidents -- light condition and per region 
select tx_light_cond_descr_fr, tx_rgn_descr_fr  ,sum (ms_acct) as num_acc, sum (ms_acct_with_dead) as num_deaths from tf_accidents_2021
group by tx_light_cond_descr_fr, tx_rgn_descr_fr
order by sum (ms_acct), sum (ms_acct_with_dead) 
-- % of dead/injuries

select sum(ms_acct_with_dead*1.0) /sum (ms_acct*1.0)  * 100 from tf_accidents_2021

-- type of collision per accidents, per death and per severe injury
select tx_coll_type_descr_fr, sum (ms_acct) as accidents, sum(ms_acct_with_dead) as deaths, sum (ms_acct_with_mory_inj) severe_injury
from tf_accidents_2021
group by tx_coll_type_descr_fr 
order by sum (ms_acct) desc
-- type of road where the accidents took place 
select tx_road_type_descr_fr, sum (ms_acct) as accidents, sum(ms_acct_with_dead) as deaths, sum (ms_acct_with_mory_inj) severe_injury
from tf_accidents_2021
group by tx_road_type_descr_fr
order by sum (ms_acct)
-- ssd



	
	
	

	
	
