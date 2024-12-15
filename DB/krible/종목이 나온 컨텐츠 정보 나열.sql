use krible;

-- 종목이 나온 컨텐츠 정보 나열
SELECT tt.topic_name topic1, tt2.topic_name topic2,
tc2.company_name company1, tc3.company_name company2,
tc.title, tc.body_summary, ta.affiliation, ta.author_name, tc.update_time
FROM T_content tc
JOIN T_content_company tcc on tc.content_id = tcc.content_id

LEFT JOIN T_content_topic tct on tc.content_id = tct.content_id and tct.orders = 1
LEFT JOIN T_topic tt on tct.topic_id = tt.topic_id
LEFT JOIN T_content_topic tct2 on tc.content_id = tct2.content_id and tct2.orders = 2
LEFT JOIN T_topic tt2 on tct2.topic_id = tt2.topic_id

LEFT JOIN T_content_company tcc2 on tc.content_id = tcc2.content_id and tcc2.orders = 1
LEFT JOIN T_company tc2 on tcc2.company_ticker = tc2.company_ticker
LEFT JOIN T_content_company tcc3 on tc.content_id = tcc3.content_id and tcc3.orders = 2
LEFT JOIN T_company tc3 on tcc3.company_ticker = tc3.company_ticker

LEFT JOIN T_content_author tca on tc.content_id = tca.content_id and tca.orders = 1
LEFT JOIN T_author ta on tca.author_id = ta.author_id

WHERE tcc.company_ticker = 'A005380'
ORDER BY tc.update_time DESC;