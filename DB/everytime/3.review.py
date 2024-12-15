from flask import Flask, request, jsonify
import pymysql
import pandas as pd

app = Flask(__name__)

# 데이터베이스 연결 설정
def get_db_connection():
   return pymysql.connect(
       host='localhost',
       port=3306,
       user='root',
       password='',
       db='everytime'
   )

@app.route('/course_info', methods=['POST'])
def get_course_info():
   request_json = request.get_json()
   course_id = request_json['course_id']

   sql_query = f"""
   SELECT * FROM CourseInfo WHERE course_id = '{course_id}';
   """

   try:
       conn = get_db_connection()
       df_course_info = pd.read_sql_query(sql_query, conn)
   except Exception as e:
       return jsonify({"error": str(e)})
   finally:
       conn.close()

   return jsonify(df_course_info.to_dict(orient='records'))

@app.route('/course_evaluation_details', methods=['GET'])
def get_course_evaluation_details():
   sql_query = "SELECT * FROM CourseEvaluationDetails;"

   try:
       conn = get_db_connection()
       df_evaluation_details = pd.read_sql_query(sql_query, conn)
   except Exception as e:
       return jsonify({"error": str(e)})
   finally:
       conn.close()

   return jsonify(df_evaluation_details.to_dict(orient='records'))



@app.route('/exam_info_details', methods=['GET'])
def get_exam_info_details():
   sql_query = "SELECT * FROM ExamInfoDetails;"

   try:
       conn = get_db_connection()
       df_exam_info_details = pd.read_sql_query(sql_query, conn)
   except Exception as e:
       return jsonify({"error": str(e)})
   finally:
       conn.close()

   return jsonify(df_exam_info_details.to_dict(orient='records'))

@app.route('/user_sanction_details', methods=['GET'])
def get_user_sanction_details():
   sql_query = "SELECT * FROM UserSanctionDetails;"

   try:
       conn = get_db_connection()
       df_user_sanction_details = pd.read_sql_query(sql_query, conn)
   except Exception as e:
       return jsonify({"error": str(e)})
   finally:
       conn.close()

   return jsonify(df_user_sanction_details.to_dict(orient='records'))

if __name__ == "__main__":
   app.run(debug=True)
