-- cast
select '12345' + 10, cast('12345' as signed) + 10
	from dual;
    
    
select date_format(cast('2025-08-14' as date), '%Y년 %m월 %d일')
	from dual;
    
    
select cast(cast(1-2 as unsigned) as signed),
	   cast(cast(1-2 as unsigned) as int),
       cast(cast(1-2 as unsigned) as integer),
       cast(cast(1-2 as unsigned) as signed int),
       cast(cast(1-2 as unsigned) as signed integer)
	from dual;
    
    
-- tye
-- 문자: varchar, char, text, CLOB(Character Large OBject)

-- 정수: medium, int(signed, integer), unsigned, big int

-- 실수: float, double

-- LOB: CLOB, BLOB(Binary Large OBject)