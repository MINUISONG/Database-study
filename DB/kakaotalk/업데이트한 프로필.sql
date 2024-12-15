use kakaotalk;

-- 업데이트한 프로필
SELECT c.name, p.url, p.update_time
FROM T_friend f
JOIN T_customer c on f.friend_id = c.cust_id
JOIN T_picture_update pu on c.cust_id = pu.cust_id
JOIN T_picture p on pu.max_pic_id = p.pic_id
WHERE f.cust_id=3
and timestampdiff(MONTH, p.update_time, '2023-10-28') < 2
ORDER BY pu.max_pic_id DESC;