--1.Print supplier numbers for suppliers who are located in the same city as supplier S1. Do not include S1 in the answer.

select Sno 
from supplier 
where city in (select city from supplier where sno ='s1') AND Sno <> 's1';

--2.Print supplier numbers for suppliers who ship at least all those parts shipped by supplier S3.  
--Do not include S3 in the answer and do not "count".

select distinct Sno 
from shipment o
where not exists (select pno from shipment where sno ='s3'
				except
				select pno from shipment i where sno = o.sno
				) and sno != 's3';

--3.	Print supplier numbers for suppliers who ship at least one type of red part.
select Sno 
from shipment join part on shipment.pno = part.pno and part.color = 'red'
group by shipment.Sno 
having count(part.pno) >= 1;
 
 --4.	Print supplier numbers for suppliers who do not ship any red parts.
 select distinct Sno 
 from shipment
 where Sno not in (
					select distinct Sno from shipment join part on shipment.pno = part.pno
					where part.color = 'red'
					);

-- 5.	Print supplier numbers for suppliers who ship ONLY red parts.
select distinct Sno 
from shipment join part on shipment.pno = part.pno
where part.color = 'red'
except
select distinct Sno 
from shipment join part on shipment.pno = part.pno and part.color <>'red';


--6.	Print supplier names for suppliers who do not currently ship any parts.
Select Sname 
from Supplier
where Sno not in (select Sno from Shipment);

--7.	Print supplier names for suppliers who ship at least one part that is also shipped by supplier S2.  
---Do not include S2 in the answer.
select Sname
from supplier join shipment on supplier.sno = shipment.sno and pno in (select pno from shipment where sno ='s2')
except
select sname from supplier where sno = 's2';

--8.	Print supplier numbers for suppliers with status value less than the current average status value of all suppliers.
select Sno 
From Supplier
where Status < (select avg(Status) from Supplier);

--9.	Print all the shipment information for the shipment(s) with the highest unit cost (i.e. price).
select *
from shipment
where price in (select max(price) from shipment);

--10.	Print all the shipment information for the shipment(s) with the highest total cost, (i.e. price*Qty).
select  shipment.Sno, Pno, Qty, Price
from shipment 
where (price*Qty) in (select max(price*Qty) from shipment);

--11.	Print all the supplier information for the supplier(s) making the most money. The supplier money is determined by the sum of all shipment cost.  Each shipment cost is found by the number of units being shipped times the price per unit.
select  supplier.sno,sname,status,city
from supplier
where Sno in
			(select sno from (select Sno, sum(price*qty) money_made
			from shipment
			group by Sno) t
			where t.money_made >= all (select sum(price*qty) money_made
			from shipment
			group by Sno)
			);

--12.	For each supplier (including the one who doesn’t ship any parts),print the supplier number and how many different parts shipped.  For example, S1 6; S2 2, ...
select supplier.Sno,count(distinct(pno)) Number_supplied
from supplier left join shipment
on
supplier.Sno=SHIPMENT.Sno
group by supplier.Sno;

--13.	For each supplier (including the one who doesn’t ship any parts), print the supplier number, supplier name, total cost of all shipments, and how many different parts shipped.
select supplier.Sno,sname,sum(Qty*price) shipment_cost,
count(distinct(pno)) Num_parts
from supplier left join shipment
on
supplier.Sno=shipment.Sno
group by supplier.Sno,sname;

