from flask import Flask, request, jsonify
import pymysql
import pandas as pd

app = Flask(__name__)

@app.route('/bbs', methods=['POST'])
def get_bbs_info():
    request_json = request.get_json()
    user_id = request_json['i_user']
    
    conn = pymysql.connect(
        host='localhost', 
        port=3306, 
        user='root', 
        password='',  
        db='everytime'         
    )

    sql_query = f"""
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
        ON bbs.bbs_id = ufbt.bbs_id AND ufbt.i_user = {user_id}
    ORDER BY
        CASE 
            WHEN bbs.bbs_id IN (1, 2, 3, 4, 5) THEN 0 
            WHEN ufbt.bbs_id IS NOT NULL THEN 1
            ELSE 2
        END,
        bbs.bbs_id;
    """

    try:
        df_bbs_info = pd.read_sql_query(sql_query, conn)
        return df_bbs_info.to_json(orient="records")  
    except Exception as e:
        return jsonify({"error": str(e)})
    finally:
        
        conn.close()

if __name__ == '__main__':
    app.run(debug=True)
