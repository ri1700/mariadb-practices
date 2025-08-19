--
-- JDBC Test SQL
--

desc dept;

-- select
select id, name from dept where name like '%개발%';

-- insert
insert into dept(name) values('UX팀');

-- delete
delete from dept where id = 11;

-- update
update dept set name = '서비스개발팀' where id = 2;

--
-- email application
--

desc email;
alter table email change id id int auto_increment;

-- findAll
select id, first_name, last_name, email from email order by id desc;

-- insert 1
insert into email(first_name, last_name, email) values('둘','리','dooly@gmail.com');

-- deleteByEmail 2
delete from email where email = 'dooly@gmail.com';