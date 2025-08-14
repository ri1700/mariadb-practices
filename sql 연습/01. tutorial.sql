-- 함수, 상수, 리터럴, 연산식
select version(), current_date(), "hello", 1 + 2 from dual;

-- 수학함수, 문자열 함수, 날짜함수
select sin(pi()/4), upper("seoul"), curdate() from dual;

-- 대소문자 구문이 없다.
seLect VERSION(), current_DATE From Dual;

-- table 생성 : DDL
create table pet (
		name varchar(100),
        owner varchar(50),
		species varchar(50),
        gender char(1),
        birth date,
        death date
);

-- schema 확인
describe pet;
desc pet;

-- table 삭제
drop table pet;
show tables;

-- insert DML(c)
insert 
	into pet 
values ('콩이', '박준성', 'chinchila', 'm', '2015-11-01', null); 

-- select: DML(R)
select * from pet; 

-- update: DML(u)
update pet set name='쿵이' where name = '콩이';

-- load data: mysql(CLI) 전용
load data local infile '/root/pet.txt' into table pet;
update pet set death = null where name != 'bowser';

-- select 연습
select name, sepecies, birth from pet;


    
--
-- 1998 이 후에 태어난 애들의 이름, 종, 생일을 출력하세요
--
select name, species, birth
	from pet
    where birth >= '1998-01-01';

--
-- 개들중에 암컷만 이름과 종과 성별을 출력하세요.
--
select name, species, gender
	from pet
    where species = 'dog' and gender = 'f';
    
--
-- 새와 뱀들만 이름과 종을 출력하세요.
--
select name, species
	from pet
    where species = 'bird'
		or species = 'snake';
 
-- 
-- 애완동물들의 이름과 생일을 제일 어린 순서대로 출력하세요.
--
select name, birth
	from pet
    order by birth desc;
    
-- 
-- 애완동물의 이름과 생일이 많은 순서대로 출력하세요.
--
select name, birt
	from pet
    order by brith asc;
    
-- 
-- 애완동물 중에 살아있는 아이들만 이름, 생일, 사망일을 출력하세요.
--
select name, birth, death
	from pet
    where death is null;
    
-- 
-- 애완동물 중에 이름이 'b'로 시작하는 아이들의 이름만 출력하세요. 
--
select name
	from pet
    where name like 'b%';
    
-- 
-- 애완동물 중에 이름이 'fy'로 끝나는 아이들의 이름만 출력하세요.
--
select name 
	from pet
    where name like '%fy';

-- 
-- 애완동물 중에 이름에 'w'가 들어 있는 아이들의 이름만 출력하세요.
--
select name 
	from pet
    where name like '%w%';
    
-- 
-- 애완동물 중에 이름이 5글자 알파벳인 아이들의 이름만 출력하세요.
--
select name 
	from pet
    where name like '_____'; 
    -- _ : 한문자를 표시함.
    
-- 
-- 애완동물 중에 이름이 b로 시작하고 6문자인 아이들의 이름만 출력하세요.
--
select name
	from pet
    where name like 'b_____';
    
-- 
-- 집계
--
select count(*), max(birth) from pet;