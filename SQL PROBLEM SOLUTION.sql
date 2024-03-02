create table brands
                (
                 BRAND1 VARCHAR(20),
                 BRAND2 VARCHAR(20),
                 YEAR INT,
                 CUSTOME1 INT null,
                 CUSTOME2 INT null,
                 CUSTOME3 INT null,
                 CUSTOME4 INT null
                );

select * from brands
		
insert into brands
values('apple','samsung',2020,1,2,1,2),
      ('samsung','apple',2020,1,2,1,2), 
      ('apple','samsung',2021,1,2,5,3), 
      ('samsung','apple',2021,5,3,1,2),
      ('google',Null,2020,5,9,Null,Null),
      ('oneplus','nothing',2020,5,9,6,3);

select * from brands

/*Problem statement:
-For pairs of brands in the same year (e.g apple/samsung/2020 and samsung/apple/2020)
  -if custome1 = custome3 and custome2 = custome4 : then keep only one pair
-For pairs of brands in the same year 
  -if custome1 != custome3 and custome2 != custome4 : then keep both pair
-For brands that do not have pairs in the same year : keep those rows as well: */

with cte as
           (select *,
            case when brand1<brand2 then concat(brand1,brand2,year)
            else concat(brand2,brand1,year) end as pair_id
            from brands),
cte_rn as
           (select *,
           row_number()over(partition by pair_id order by pair_id) as rn
           from cte)
select brand1,brand2,year,custome1,custome2,custome3,custome4
from cte_rn
where rn = 1 or (custome1!=custome3 and custome2 != custome4)



