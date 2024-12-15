use krible;

-- 컨텐츠 정보 나열
SELECT tc.title, tc.update_time, tc.body_summary,
tc2.company_name, tt.topic_name, tt2.topic_name, ta.author_name
FROM T_content tc
LEFT JOIN T_content_company tcc on tc.content_id = tcc.content_id and tcc.orders = 1
LEFT JOIN T_company tc2 on tcc.company_ticker = tc2.company_ticker

LEFT JOIN T_content_topic tct on tc.content_id = tct.content_id and tct.orders = 1
LEFT JOIN T_topic tt on tct.topic_id = tt.topic_id

LEFT JOIN T_content_topic tct2 on tc.content_id = tct2.content_id and tct2.orders = 2
LEFT JOIN T_topic tt2 on tct2.topic_id = tt2.topic_id

LEFT JOIN T_content_author tca on tc.content_id = tca.content_id and tca.orders = 1
LEFT JOIN T_author ta on tca.author_id = ta.author_id
WHERE tc.content_id = 10