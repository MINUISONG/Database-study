use kakaotalk;

-- 채팅화면
SELECT a.room_id, if(cnt>3, names_3_concat, names_3) names, ch.chat,
date_format(ch.chat_time, '%m-%d %p %h:%i') chat_time
FROM (
SELECT chm.room_id, count(*) cnt, group_concat(c.name) names_full,
substring_index(group_concat(c.name), ',', 3) names_3,
concat(substring_index(group_concat(c.name), ',', 3), ', ...') names_3_concat
FROM T_chat_member chm
JOIN T_customer c on chm.cust_id = c.cust_id
WHERE c.cust_id != 2
GROUP BY chm.room_id
) a
JOIN (
SELECT room_id, max(chat_id) chat_id
FROM T_chat
GROUP BY room_id
) b on a.room_id = b.room_id
JOIN T_chat ch on b.chat_id = ch.chat_id
ORDER BY ch.chat_id DESC;