use krible;

-- 토픽 정보 나열
SELECT tt.topic_name, count(tc.content_id) cnt
FROM T_topic tt
JOIN T_user_topic_heart tuth on tt.topic_id = tuth.topic_id
LEFT JOIN T_content_topic tct on tct.topic_id = tuth.topic_id
LEFT JOIN T_content tc on tc.content_id = tct.content_id
and date(tc.update_time) = '2023-10-30'
WHERE tuth.user_id = 1
GROUP BY tt.topic_name
ORDER BY cnt desc, topic_name;