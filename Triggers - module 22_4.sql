/*Create audit table for books*/

create table books_aud(
event_id int(11) not null auto_increment,
event_date datetime not null,
event_type varchar(10) default null,
book_id int(11) not null,
old_title varchar(255),
new_title varchar(255),
old_pubyear int(4),
new_pubyear int(4),
old_bestseller boolean,
new_bestseller boolean,
primary key (event_id))

/*INSERT TRIGGER*/

delimiter $$

create trigger BOOKS_INSERT after insert on books
for each row
begin
	insert into books_aud(event_date, event_type, book_id, new_title, new_pubyear, new_bestseller)
    values(curdate(), "INSERT", new.book_id, new.title, new.pubyear, new.bestseller);
end $$

delimiter ;

/*Test insert trigger*/

insert into books(title, pubyear, bestseller)
values("Hack your brain", 2017, false);

select * from books;
select * from books_aud;

/*DELETE TRIGGER*/

delimiter $$

create trigger BOOKS_DELETE after delete on books
for each row
begin
	insert into books_aud(event_date, event_type, book_id, old_title, old_pubyear, old_bestseller)
    values(curdate(), "DELETE", old.book_id, old.title, old.pubyear, old.bestseller);
end $$

delimiter ;

/*Test delete trigger*/

delete from books where book_id = 6;

select * from books;
select * from book_aud;


/*UPDATE TRIGGER*/

delimiter $$

create trigger BOOKS_UPDATE after update on books
for each row
begin
	insert into books_aud(event_date, event_type, book_id, old_title, new_title, old_pubyear, 
	new_pubyear, old_bestseller, new_bestseller)
    values(curdate(), "UPDATE", old.book_id, old.title, new.title, old.pubyear, new.pubyear, old.bestseller, new.bestseller);
end $$

delimiter ;

/*Test update trigger*/

insert into books(title, pubyear, bestseller)
values("Hack your brain", 2017, false);

select * from books;

update books set pubyear = 2016, bestseller = true where book_id  = 7;

select * from books;
select * from books_aud;


/*Create audit table for readers*/

create table readers_aud(
event_id int(11) not null auto_increment,
event_date datetime not null,
event_type varchar(10) default null,
reader_id int(11) not null,
old_firstname varchar(255),
new_firstname varchar(255),
old_lastname varchar(255),
new_lastname varchar(255),
old_peselid varchar(11),
new_peselid varchar(11),
old_vip_level varchar(255),
new_vip_level varchar(255),
primary key (event_id));

/*INSERT TRIGGER*/

delimiter $$

create trigger READERS_INSERT after insert on readers
for each row
begin
	insert into readers_aud(event_date, event_type, reader_id, new_firstname, new_lastname, new_peselid, new_vip_level)
    values(curdate(), "INSERT", new.reader_id, new.firstname, new.lastname, new.peselid, new.vip_level);
end $$

delimiter ;

/*Test insert trigger*/

insert into readers(firstname, lastname, peselid, vip_level)
values("Olek", "Olkowski", "12345678911", "Standrd customer");
select * from readers;
select * from readers_aud;

/*DELETE TRIGGER*/

delimiter $$

create trigger READERS_DELETE after delete on readers
for each row
begin
	insert into readers_aud(event_date, event_type, reader_id, old_firstname, old_lastname, old_peselid, old_vip_level)
    values(curdate(), "DELETE", old.reader_id, old.firstname, old.lastname, old.peselid, old.vip_level);
end $$

delimiter ;

/*Test delete trigger*/

delete from readers where reader_id  = 6;

select * from readers;
select * from readers_aud;

/*UPDATE TRIGGER*/
delimiter $$

create trigger READERS_UPDATE after update on readers
for each row
begin
	insert into readers_aud(event_date, event_type, reader_id, old_firstname, new_firstname,  
    old_lastname, new_lastname, old_peselid, new_peselid, old_vip_level, new_vip_level)
    values(curdate(), "UPDATE", old.reader_id, old.firstname, new.firstname, old.lastname, new.lastname,
	old.peselid, new.peselid, old.vip_level, new.vip_level);
end $$

delimiter ;

/*Test update trigger*/

insert into readers(firstname, lastname, peselid, vip_level)
values("Olek", "Olkowski", "12345678911", "Standrd customer");

update readers set vip_level="Standard customer" where reader_id = 7;

select * from readers;
select * from readers_aud;

