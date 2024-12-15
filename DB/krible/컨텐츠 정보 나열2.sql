use krible;

-- 컨텐츠 정보 나열
SELECT tc.title, tc.update_time, tc2.company_name, tt.topic_name
FROM T_content tc
LEFT JOIN T_content_company tcc on tc.content_id = tcc.content_id and tcc.orders = 1
LEFT JOIN T_company tc2 on tcc.company_ticker = tc2.company_ticker
LEFT JOIN T_content_topic tct on tc.content_id = tct.content_id and tct.orders = 1
LEFT JOIN T_topic tt on tct.topic_id = tt.topic_id
WHERE tc.content_id in (9, 5, 4)
ORDER BY tc.update_time DESC;