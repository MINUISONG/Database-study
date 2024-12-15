use everytime;

select * from CourseEvaluation;
--

select * from CourseInfo;
CREATE VIEW CourseInfo AS
SELECT 
    c.course_id,
    max(c.course_name) course_name,
    max(c.professor_name) professor_name,
    ROUND(AVG(ce.rating), 2) AS average_rating,  -- 소수점 2자리까지 평균 레이팅
    COUNT(ce.evaluation_id) AS total_evaluations,
    
    -- 과제 양
    CASE
        WHEN SUM(CASE WHEN ce.assignment_amount = '많음' THEN 1 ELSE 0 END) / COUNT(ce.evaluation_id) >= 0.5 THEN '많음'
        WHEN SUM(CASE WHEN ce.assignment_amount = '보통' THEN 1 ELSE 0 END) / COUNT(ce.evaluation_id) >= 0.5 THEN '보통'
        ELSE '적음'
    END AS assignment_amount,

    -- 조모임 빈도
    CASE
        WHEN SUM(CASE WHEN ce.group_meeting_frequency = '많음' THEN 1 ELSE 0 END) / COUNT(ce.evaluation_id) >= 0.5 THEN '많음'
        WHEN SUM(CASE WHEN ce.group_meeting_frequency = '보통' THEN 1 ELSE 0 END) / COUNT(ce.evaluation_id) >= 0.5 THEN '보통'
        ELSE '적음'
    END AS group_meeting_frequency,

    -- 성적 기준
    CASE
        WHEN SUM(CASE WHEN ce.grading_flexibility = '너그러움' THEN 1 ELSE 0 END) / COUNT(ce.evaluation_id) >= 0.5 THEN '너그러움'
        WHEN SUM(CASE WHEN ce.grading_flexibility = '보통' THEN 1 ELSE 0 END) / COUNT(ce.evaluation_id) >= 0.5 THEN '보통'
        ELSE '깐깐함'
    END AS grading_flexibility
FROM 
    Course c 
join CourseEvaluation ce on c.course_id = ce.course_id
WHERE 
    c.course_id = '14466_006'  -- 특정 강의 ID를 지정
group by course_id;

-- 강의 정보 조회

select * from CourseEvaluationInfo;

CREATE VIEW CourseEvaluationInfo AS
SELECT 
    course_id,
    ROUND(AVG(rating), 2) AS average_rating,  -- 소수점 2자리까지 평균 레이팅
    COUNT(evaluation_id) AS total_evaluations,
    
    -- 과제 양
    CASE
        WHEN SUM(CASE WHEN assignment_amount = '많음' THEN 1 ELSE 0 END) / COUNT(evaluation_id) >= 0.8 THEN '많음'
        WHEN SUM(CASE WHEN assignment_amount = '보통' THEN 1 ELSE 0 END) / COUNT(evaluation_id) >= 0.5 THEN '보통'
        ELSE '적음'
    END AS assignment_amount,

    -- 조모임 빈도
    CASE
        WHEN SUM(CASE WHEN group_meeting_frequency = '많음' THEN 1 ELSE 0 END) / COUNT(evaluation_id) >= 0.8 THEN '많음'
        WHEN SUM(CASE WHEN group_meeting_frequency = '보통' THEN 1 ELSE 0 END) / COUNT(evaluation_id) >= 0.5 THEN '보통'
        ELSE '적음'
    END AS group_meeting_frequency,

    -- 성적 기준
    CASE
        WHEN SUM(CASE WHEN grading_flexibility = '너그러움' THEN 1 ELSE 0 END) / COUNT(evaluation_id) >= 0.8 THEN '너그러움'
        WHEN SUM(CASE WHEN grading_flexibility = '보통' THEN 1 ELSE 0 END) / COUNT(evaluation_id) >= 0.5 THEN '보통'
        ELSE '깐깐함'
    END AS grading_flexibility
FROM 
    CourseEvaluation
WHERE 
    course_id = '14466_006'  -- 특정 강의 ID를 지정
GROUP BY 
    course_id;

drop view CourseEvaluationDetails;


-- 강의평 정보 조회
CREATE VIEW CourseEvaluationDetails AS
SELECT 
    evaluation_id AS course_evaluation_id,  -- 강의평 ID
    AVG(rating) AS average_rating,    -- 평균 평점
    semester,
    GROUP_CONCAT(content SEPARATOR '; ') AS course_evaluation,  -- 강의평 내용
    SUM(recommend_count) AS total_recommend_count  -- 총 추천 수
FROM 
    CourseEvaluation
GROUP BY 
    evaluation_id;  -- 강의평 ID로 그룹화

select * from courseevaluationdetails;
--
CREATE VIEW ExamInfoDetails AS
SELECT 
    GROUP_CONCAT(DISTINCT exam_info_id SEPARATOR ', ') AS exam_info_ids,  -- 시험 정보 ID
    semester,                        -- 학기 정보
    exam_round,                      -- 시험 회차 (중간고사, 기말고사)
    GROUP_CONCAT(DISTINCT question_type SEPARATOR ', ') AS question_type,  -- 중복 문제 유형
    GROUP_CONCAT(exam_strategy SEPARATOR ', ') AS exam_strategy,            -- 시험 전략
    GROUP_CONCAT(question_example SEPARATOR '; ') AS question_example,       -- 문제 예시
    SUM(recommend_count) AS total_recommend_count,                        -- 총 추천 수
    SUM(not_recommend_count) AS total_not_recommend_count                  -- 총 비추천 수
FROM 
    ExamInfo
GROUP BY 
    semester, exam_round;  -- 코스 ID를 제외하고 학기와 시험 회차로 그룹화

--

CREATE VIEW UserSanctionDetails AS
SELECT 
    sanction_id,           -- 제재 ID
    i_user,         -- 신고를 당한 유저 ID
    sanction_type,        -- 제재 종류
    reason,               -- 제재 사유
    sanction_date         -- 제재 일시
FROM 
    UserSanction;


SELECT * FROM CourseInfo; -- 개요
select * from ExamInfoDetails; -- 시험정보 
SELECT * FROM CourseEvaluationDetails; -- 강의평
SELECT * FROM UserSanctionDetails;




