use krible;

-- 관심 종목의 컨텐츠 중 가장 최근 컨텐츠
SELECT *
FROM T_user_company_heart tuch
JOIN T_content_company tcc on tuch.company_ticker = tcc.company_ticker
JOIN T_content tc on tcc.content_id = tc.content_id
WHERE tuch.user_id = 2
ORDER BY tc.update_time DESC
LIMIT 1;