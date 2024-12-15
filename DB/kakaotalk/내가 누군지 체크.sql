use kakaotalk;

-- 내가 누군지 체크
SELECT c.name, ifnull(p.url, "images/0.png") url, ch.chat,
date_format(ch.chat_time, '%p %h:%i') chat_time, if(c.cust_id = 2, 1, 0) me
FROM T_chat ch
JOIN T_customer c on ch.cust_id = c.cust_id
LEFT JOIN T_picture_update pu on pu.cust_id = c.cust_id
LEFT JOIN T_picture p on pu.max_pic_id = p.pic_id
WHERE room_id = 1
and date(chat_time) = '2023-09-29'
ORDER BY chat_id;