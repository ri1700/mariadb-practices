--
-- subquery
--


--
-- 1) select 절
--
select (subquery)
	from t1;
		insert into t1 values (val1, val2 (subquery), val3);


--
-- 2) from 절의 서브쿼리 (arise를 꼭 쳐야함)
--
select now() as n, sysdate() as s, 3 + 1 as r from dual;

select a.n, a.s, a.r
	from(select now() as n, sysdate() as s, 3 + 1 as r from dual) a;


--
-- 3) where 절의 서브쿼리
--

-- 예제1: 'Fail Bale'이 근무하는 부서에서 근무하는 직원의 사번, 전체 이름을 출력

-- 2개의 쿼리로 해결.

-- 1. query : Fail Bale'이 근무하는 부서의 번호 가져오기
select dept_no
	from employees a, dept_emp b
		where a.emp_no = b.emp_no
			and b.to_date = '9999-01-01'
			and concat(a.first_name, ' ', a.last_name) = 'Fai Bale';


-- 2. query : 1번째에서 구한 부서번호를 가지고 동료들을 가져오기
select a.emp_no, a.first_name
	from employees a, dept_emp b
		where a.emp_no = b.emp_no
			and b.to_date = '9999-01-01'
			and b.dept_no = 'd004';
            
            
-- 서브쿼리로 해결
select a.emp_no, a.first_name
    from employees a, dept_emp b
		where a.emp_no = b.emp_no
			and b.to_date = '9999-01-01'
            and b.dept_no = (select dept_no
								from employees a, dept_emp b
                                where a.emp_no = b.emp_no
									and b.to_date = '9999-01-01'
									and concat(a.first_name, ' ', a.last_name) = 'Fai Bale');
                                    
                                    
-- 3-1) 단일행 연산자 : =, >, <, >=, <=, !=,  <>
 
-- 예제2: 현재, 전체 사원의 평균 연봉보다 적은 급여를 받는 사원의 이름, 급여를 출력
select avg(salary)
	from salaries
		where to_date = '9999-01-01';	-- 전체 사원 평균
 
select a.first_name, b.salary
	from employees a, salaries b
		where a.emp_no = b.emp_no
			and b.to_date = '9999-01-01'
            and b.salary < (select avg(salary)
								from salaries
									where to_date = '9999-01-01')	-- 전체 사원 평균 보다 적은 급여를 받는 사원 이름, 급여
				order by b.salary desc;	-- 덜 적은 사람보다 순서대로 정렬
 
 
-- 예제3: 현재, 직책별 평균 급여 중에 가장 적은 평균 급여의 직책 이름과 그 평균 급여를 출력 
 
-- 1. 직책별 평균 급여
select a.title, avg(b.salary)
	from titles a, salaries b
		where a.emp_no = b.emp_no
			and a.to_date = '9999-01-01'
			and b.to_date = '9999-01-01'
				group by a.title
                order by avg(b.salary) asc;		-- 직책별 평균 급여 적은 순으로 출력
                
                
-- 2. 직책별가장 적은 평균급여
select min(avg_salary)
	from( select a.title, avg(b.salary) as avg_salary
	from titles a, salaries b
		where a.emp_no = b.emp_no
			and a.to_date = '9999-01-01'
			and b.to_date = '9999-01-01'
				group by a.title) a;	-- 가장 적은 직책의 평균 급여 출력
 
 
-- 2-1. where절 (having절) 서브쿼리 사용
select a.title, avg(b.salary)
	from titles a, salaries b
		where a.emp_no = b.emp_no
			and a.to_date = '9999-01-01'
			and b.to_date = '9999-01-01'
				group by a.title
					having avg(b.salary) = (select min(avg_salary)
											from( select a.title, avg(b.salary) as avg_salary
													from titles a, salaries b
														where a.emp_no = b.emp_no
															and a.to_date = '9999-01-01'
															and b.to_date = '9999-01-01'
																group by a.title) a);
					
 
-- 2-2. top-k (limit, 보통 order by 뒤에 온다)
select a.title, avg(b.salary)
	from titles a, salaries b
		where a.emp_no = b.emp_no
			and a.to_date = '9999-01-01'
			and b.to_date = '9999-01-01'
				group by a.title
					order by avg(b.salary) asc
						limit 0, 1;		-- 0부터 시작, 0,1 : 하나만 가져오기
 

-- 3-2) 복수행 연산자 : in, not in, (비교연산자)any, (비교연산자)all
 
-- (비교연산자)any 사용법

-- 1. =any : in : 많이 사용함.
-- 2. <>any, !=any : not in
-- 3. >any, >=any : 최소값
-- 4. <any, <=any : 최대값 

-- (비교연산자)all 사용법

-- 1. =all : (x), 구현이 안됨.
-- 2. <>all, !=all : (O)
-- 3. >all, >=all : 최대값
-- 4. <all, <=all : 최소값


-- 예제4: 현재, 급여가 50,000 이상인 직원 이름과 급여를 출력 // ex) 둘리 60,000 마이클 80,000

-- join
select a.first_name, b.salary
	from employees a, salaries b
		where a.emp_no = b.emp_no
			and b.to_date = '9999-01-01'
			and b.salary > 50000
				order by b.salary asc;	-- 50000 이상을 받는 직원 이름과 급여를 적은 순서로 출력
                
-- subquery : where(in)
select a.first_name, b.salary
	from employees a, salaries b
		where a.emp_no = b.emp_no
			and b.to_date = '9999-01-01'
            and (a.emp_no, b.salary) in (select emp_no, salary
											from salaries
												where to_date = '9999-01-01'
													and salary > 50000)
				order by b.salary asc;
                
-- subquery : where(=any)
select a.first_name, b.salary
	from employees a, salaries b
		where a.emp_no = b.emp_no
			and b.to_date = '9999-01-01'
            and (a.emp_no, b.salary) =any (select emp_no, salary
											from salaries
												where to_date = '9999-01-01'
													and salary > 50000)
				order by b.salary asc;
			
		
-- 예제5: 현재, 각 부서별로 최고 급여를 받고 있는 직원의 부서이름, 이름, 연봉을 출력 // ex) 총무 둘리 40,000 개발 마이콜 50,000	
select a.dept_no, max(b.salary) as max_salary
	from dept_emp a, salaries b
		where a.emp_no = b.emp_no
			and a.to_date = '9999-01-01'
			and b.to_date = '9999-01-01'
				group by a.dept_no;
                
               
-- where절 subquery(in)
select a.dept_name, c.first_name, d.salary 
	from departments a, dept_emp b, employees c, salaries d
		where a.dept_no = b.dept_no
			and b.emp_no = c.emp_no
            and c.emp_no = d.emp_no
			and b.to_date = '9999-01-01'
            and d.to_date = '9999-01-01'
            and (a.dept_no, d.salary) in (select a.dept_no, max(b.salary)
											from dept_emp a, salaries b
												where a.emp_no = b.emp_no
													and a.to_date = '9999-01-01'
													and b.to_date = '9999-01-01'
														group by a.dept_no);
            
-- from절 subquery
select a.dept_name, c.first_name, d.salary
	from departments a, dept_emp b, employees c, salaries d, (select a.dept_no, max(b.salary) as max_salary
																from dept_emp a, salaries b
																	where a.emp_no = b.emp_no
																		and a.to_date = '9999-01-01'
																		and b.to_date = '9999-01-01'
																			group by a.dept_no) e
		where a.dept_no = b.dept_no
			and b.emp_no = c.emp_no
            and c.emp_no = d.emp_no
            and a.dept_no = e.dept_no
			and b.to_date = '9999-01-01'
            and d.to_date = '9999-01-01'
            and d.salary = e.max_salary;