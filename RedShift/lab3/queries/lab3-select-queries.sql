-- get the metadata of sales tables 
SELECT * FROM PG_TABLE_DEF
WHERE tablename = 'sales';

-- list first 30 records from sales and date table
select * from public.sales limit 30;
select * from public.date limit 30;

--Get the number of sales in a given period
SELECT sum(qtysold)
FROM   sales, date
WHERE  sales.dateid = date.dateid
AND    caldate = '2008-01-05';

--How many quantities are sold by top 10 buyers
SELECT buyerid, sum(qtysold) total_quantity
FROM  sales
GROUP BY buyerid
ORDER BY total_quantity desc limit 10

-- get buyers name and total quantity

SELECT firstname, lastname, total_quantity
FROM 	(SELECT buyerid, sum(qtysold) total_quantity
		FROM  sales
		GROUP BY buyerid
		ORDER BY total_quantity desc limit 10) qty, users
WHERE qty.buyerid = userid
ORDER BY qty.total_quantity desc;

-- Find events in the 99th percentile in terms of all time gross sales.
SELECT eventname, total_price, percentile
FROM  (SELECT eventid, total_price, ntile(1000) over(order by total_price desc) as percentile
       FROM (SELECT eventid, sum(pricepaid) total_price
             FROM   sales
             GROUP BY eventid)) Q, event E
       WHERE Q.eventid = E.eventid
       --AND percentile = 1
ORDER BY total_price desc;
