use krible;

-- 오늘의 종목이 언급된 컨텐츠
SELECT tc.content_id
FROM T_content tc
JOIN T_content_company tcc on tc.content_id = tcc.content_id
JOIN T_today_company ttc on tcc.company_ticker = ttc.company_ticker
ORDER BY tc.update_time DESC
LIMIT 3