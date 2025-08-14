-- 1) 집게쿼리: select 절에 통계 함수(count, max, min, sum, avg, variance, stdev, ...)

select avg(salary), sum(salary)
	from salaries;
    

-- 2) select 절에 집계함수 (그룹함수)가 있는 경우, 어떤 컬럼도 select절에 올 수 없다.
-- emp_no는 아무 의미가 없다.

select emp_no, avg(salary)
	from salaries;
    
    
-- 3) query 순서
-- 1. from : 접근 테이블 확인
-- 2. where : 조건에 맞는 row를 선택한다. (임시 테이블)
-- 3. 집계(테이블)
-- 4. projection

-- 예제01: 사번이 10060인 직원의 평균 급여
select avg(salary)
	from salaries
		where emp_no = '10060';


-- 4) group by
-- 1. group by에 참여 하고 있는 칼럼은 projection이 가능하다.
-- 2. select 절에 올 수 있다.

-- 예제02: 사원별 평균 급여
select emp_no, avg(salary)
	from salaries
		group by emp_no;
        
        
-- 5) having
-- 1. 집계 결과에서 row를 선택해야 하는 경우
-- 2. 이미 where절은 실행이 되었기 때문에 having절에 이 조건을 주어야 한다.

-- 예제03: 평균 급여가 60000 달러 이상인 사원의 사번과 평균 급여
select emp_no, avg(salary)
	from salaries
		group by emp_no
			having avg(salary) > 60000;


-- 6) order by
-- 1. order by는 항상 맨 마지막 출력(projection)전에 한다.
select emp_no, avg(salary)
	from salaries
		group by emp_no
			having avg(salary) > 60000
				order by avg(salary) asc;


-- 주의) 사번이 10060인 직업의 사번, 평균 월급, 급여 총합을 출력
-- 1. 의미적으론 맞지만 문법적으론 오류

-- X
select emp_no, avg(salary), sum(salary)
	from salaries
		where emp_no = '10060';

-- O
select emp_no, avg(salary), sum(salary)
	from salaries
		group by emp_no
			having emp_no = '10060';