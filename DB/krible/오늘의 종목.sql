use krible;

-- 오늘의 종목
SELECT a.company_ticker
FROM (
SELECT tcc.company_ticker, count(*) cnt
FROM T_content tc
JOIN T_content_company tcc on tc.content_id = tcc.content_id
WHERE date(tc.update_time) = '2023-10-30'
GROUP BY tcc.company_ticker
HAVING cnt >= 2
) a;