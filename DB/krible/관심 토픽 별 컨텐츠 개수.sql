use krible;

-- 관심 토픽 별로 컨텐츠 개수
SELECT tct.topic_id, count(*) cnt
FROM T_content tc
JOIN T_content_topic tct on tc.content_id = tct.content_id
JOIN T_user_topic_heart tuth on tct.topic_id = tuth.topic_id
WHERE tuth.user_id = 1
and date(tc.update_time) = '2023-10-30'
GROUP BY tct.topic_id;