--How to calculate business days between certain dates using Date dimension table

select distinct
    t01.[Case Number]
    , t01.[Claim Number]
    , t01.[Start Date]
    , t01.[End Date]
    , sum(case when t02.[Is Business Day] = 'Y' then 1 else 0 end) as [Business days] --total business days between this range

from		#InitialContactDate as t01

left join	[asr].[Vw_Dim_Date] as t02
on			t01.[Start Date] > t02.[Full Date] --only pick out dates later than Start Date. This is to make sure we are not double counting the start date itself
and			t01.[End Date] <= t02.[Full Date] --filtering out records less than or equal to End date. Pick out dates that fall in between this range 

group by 
    t01.[Case Number]
    , t01.[Claim Number]
    , t01.[Start Date]
    , t01.[End Date]