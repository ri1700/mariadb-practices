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

-- 2. query : 1번째에서 구한 부서번호를 가지고 동료들을 가져오기
select dept_no
	from employees a, dept_emp b
		where a.emp_no = b.emp_no
			and b.to_date = '9999-01-01'
			and concat(a.first_name, ' ', a.last_name) = 'Fai Bale';


select a.emp_no, a.first_name
	from employees a, dept_emp b
		where a.emp_no = b.emp_no
			and b.to_date = '9999-01-01'
			and b.dept_no = 'd004';
            
            
-- 서브쿼리로 해결alterselect dept_no
--
select a.emp_no, a.first_name
    from employees a, dept_emp b
		where a.emp_no = b.emp_no
			and b.to_date = '9999-01-01'
            and b.dept_no = (select dept_no
								from employees a, dept_emp b
                                where a.emp_no = b.emp_no
									and b.to_date = '9999-01-01'
									and concat(a.first_name, ' ', a.last_name) = 'Fai Bale');