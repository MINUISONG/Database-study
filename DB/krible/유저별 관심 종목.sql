use krible;

-- 유저별 관심 종목
SELECT tuc.user_id, tuc.company_ticker
FROM T_user_company tuc
JOIN (
SELECT user_id, company_ticker, max(update_time) update_time
FROM T_user_company
GROUP BY user_id, company_ticker
) a on tuc.user_id = a.user_id
and tuc.company_ticker = a.company_ticker
and tuc.update_time = a.update_time
WHERE tuc.heart = 1
ORDER BY tuc.user_id, tuc.company_ticker;