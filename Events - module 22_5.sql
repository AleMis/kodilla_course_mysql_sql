/*Create table stats*/

create table stats(
STAT_ID INT(11) AUTO_INCREMENT PRIMARY KEY,
STAT_DATE DATETIME NOT NULL,
STAT VARCHAR(20) NOT NULL,
VALUE INT(11) NOT NULL);

/*Create view BESTSELLERS_COUNT */
create view BESTSELLERS_COUNT as
	select count(*) as BESTSELLER_QTY
    from books
    where bestseller = true; 

/*Create event RUN_BESTSELLERS_STATS*/
delimiter |

create event RUN_BESTSELLERS_STATS
	on schedule every 1 minute
    do 
		begin
			declare quantity int(20);
            call UpdateBestSellers();
            select bestseller_qty into quantity from bestsellers_count;
			insert into stats(stat_date, stat, value)
			values(curdate(), "BESTSELLERS", quantity);
		end|
        
delimiter ;

