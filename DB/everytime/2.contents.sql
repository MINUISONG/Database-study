use everytime;

-- 게시판 view
CREATE VIEW user_fixed_bbs_top AS
SELECT ufb.i_user, ufb.bbs_id
FROM user_fixed_bbs ufb
JOIN( 
	SELECT i_user, bbs_id, max(update_time) update_time
	FROM user_fixed_bbs
	GROUP BY i_user, bbs_id
	)a on ufb.i_user = a.i_user
		and ufb.bbs_id = a.bbs_id
		and ufb.update_time = a.update_time
WHERE ufb.fix = 1
ORDER BY ufb.i_user, ufb.bbs_id;

select * from user_fixed_bbs_top;

SELECT 
    bbs.bbs_name,
    IF(
        EXISTS (
            SELECT 1 
            FROM contents 
            WHERE contents.bbs_id = bbs.bbs_id AND DATE(contents.bbs_date) = '2024-11-20'
        ), 
        1, 
        0
    ) AS has_new_posts
FROM 
    bbs
LEFT JOIN user_fixed_bbs_top ufbt 
    ON bbs.bbs_id = ufbt.bbs_id AND ufbt.i_user = 1
ORDER BY
	case 
		when bbs.bbs_id in (1,2,3,4,5) then 0 
        when ufbt.bbs_id IS NOT NULL then 1
        else 2
	end,
    bbs.bbs_id; 
    
    
-- 게시물 view
select contents_id, bbs_title,
# 본문 글자를 최대 50글자만 가져온다. 그 이상이면 '...'으로 표시.
if(CHAR_LENGTH(bbs_content) > 50,  CONCAT(LEFT(bbs_content, 47), '...'), bbs_content) as bbs_content,
# date를 가공한다. ex) 방금, 'x분전', 23:00, 11/21
if(
curdate() = date(bbs_date), 
if(date_sub(current_timestamp(), INTERVAL 60 minute) < bbs_date, 
	if(date_sub(current_timestamp(), INTERVAL 60 second) < bbs_date, 
    '방금', 
    concat(TIMESTAMPDIFF(minute, bbs_date, current_timestamp()), '분 전')), 
	date_format(bbs_date, '%H:%i')), 
DATE_FORMAT(bbs_date, '%m/%d')) as date, 
if(is_anonymous, "익명", u.nickname) nickname, bbs_likes, bbs_comments from contents c
join user u on c.i_user = u.i_user
where bbs_id = 8 # 이부분에 post로 값이 들어간다.
and bbs_available = 1
order by contents_id desc
limit 20; # 한 페이지에는 최대 20개의 게시글이 보인다.
# date로 정렬을 할 수도 있겠지만, contents_id의 경우 시간순에 따라 지정되기 때문에 int type인 contents_id로 정렬함. 다만, 안정성은 bbs_date가 더 높을거 같음
# ex) 모종의 이유로 contents_id 가 시간순으로 지정되지 않음
