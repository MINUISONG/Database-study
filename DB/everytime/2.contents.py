from flask import Flask, request
import pymysql
import pandas as pd

app = Flask(__name__)

# contents_query
@app.route('/contents_list', methods=['POST'])
def contents_query():
    request_json = request.get_json()
    bbs_input = request_json['bbs_id']
    conn = pymysql.connect(host='localhost', port=3306, user='root', password='', db='everytime')

    sql = """
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
            date_format(bbs_date, '%%H:%%i')), 
        DATE_FORMAT(bbs_date, '%%m/%%d')) as date, 
        if(is_anonymous, "익명", u.nickname) nickname, bbs_likes, bbs_comments from contents c
        join user u on c.i_user = u.i_user
        where bbs_id = %s # 이부분에 post로 값이 들어간다.
        and bbs_available = 1
        order by contents_id desc
        limit 20;
        # 사실 limit을 통해 20개만 가져오지만, 실제로는 pagenumber value를 통해 select하는 범위도 달라집니다.
        """ % bbs_input
        # format of placeholder is : %s; to describe %H, change to %%H
    df = pd.read_sql_query(sql, conn)
    df_dict = {"contents_id": df['contents_id'].tolist(), "title": df['bbs_title'].tolist(),
               "content": df['bbs_content'].tolist(), "date": df['date'].tolist(), "nickname": df['nickname'].tolist(),
               "likes": df['bbs_likes'].tolist(), "comments": df['bbs_comments'].tolist()}
    return df_dict


if __name__ == "__main__":
    app.run(debug=True)
