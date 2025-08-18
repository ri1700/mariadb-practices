-- DDL / DML(insert, update, delete) 연습

-- 테이블 삭제
drop table member;

-- 테이블 생성
create table member(
	no int not null auto_increment,
    email varchar(200) not null default '',
    password varchar(64) not null,
    name varchar(50) not null,
    department varchar(100),
	primary key(no)
);

-- 테이블 띄우기
desc member;

-- 테이블 변경(alter table...)
alter table member add column juminbunho char(13) not null;
desc member;

alter table member drop column juminbunho;
desc member;

-- after : ~~ 뒤에 // after email : email 뒤에 배치
alter table member add column juminbunho char(13) not null after email;
desc member;

-- change : ~~ 를 ~~로 변경 // department dept varchar(100) : 앞에 depart를 dept로 변경
alter table member change column department dept varchar(100) not null default 'none';
desc member;

-- add : 추가 // add column self_intro text : self_intro, text
alter table member add column self_intro text;
desc member;

alter table member drop column juminbunho;
desc member;


-- insert(순서 지키면서 다 넣어줘야한다. // null도 포함)
insert
	into member
		values (null, 'hazard@gmail.com', password('1234'), '박준성', '개발팀', null);
 
select *
	from member;

   
insert
	into member(email, name, password, dept)
		values ('hazard2@gmail.com', '박준성2', password('1234'),'개발팀');
 
select *
	from member;
    
    
-- update
update member
	set email = 'hazard3', password = password('4321')
		where no = 2;
        
select *
	from member;
    
    
-- delete
delete
	from member
		where no = 4;

select *
	from member;
    
    
-- transaction
select no, email from member;

select @@autocommit from dual; -- true(1), tx disabled

insert
	into member(email, name, password, dept)
		values ('hazard2@gmail.com', '박준성2', password('1234'),'개발팀');

select no, email from member;


-- tx begin
set autocommit = 0;
select @@autocommit from dual; -- false(0), tx enabled

insert
	into member(email, name, password, dept)
		values ('hazard3@gmail.com', '박준성3', password('1234'),'개발팀');
        
select no, email from member;


-- tx end
commit;
select no, email from member;