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
    
    
