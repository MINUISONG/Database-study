use kakaotalk;

-- 지난 생일
SELECT c.name, c.birthday, ifnull(p.url, "images/0.png") url
FROM T_friend f
JOIN T_customer c on f.friend_id = c.cust_id
LEFT JOIN T_picture_update pu on c.cust_id = pu.cust_id
LEFT JOIN T_picture p on pu.max_pic_id = p.pic_id
WHERE f.cust_id = 3
AND date_format(c.birthday, '2024-%m-%d')
BETWEEN date_add(curdate(), interval -30 day) and curdate()
ORDER BY date_format(c.birthday, '2024-%m-%d'), c.name;