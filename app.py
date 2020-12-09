from flask import Flask, request, render_template
from flask import jsonify, make_response
import pymysql
from prettytable import PrettyTable
import json

app = Flask(__name__)

@app.route('/', methods=['POST', 'GET', 'DELETE', 'PUT'])
def main():
    try:
        if request.method == 'POST':
            if request.is_json:
                req = request.get_json()
                db = pymysql.connect(host="localhost", port=3308, user="root", password="",database="myfirstdb" )
                cursor = db.cursor()
                placeholders = ', '.join(['%s'] * len(req))
                columns = ', '.join(req.keys())
                insert = "INSERT INTO employee( %s ) VALUES ( %s )" % (columns, placeholders)
                cursor.execute(insert, list(req.values()))
                db.commit()
                db.close()
                return "Inserted successful", 200
            else:
                return "Request was not JSON", 400

        if request.method == 'GET':
            db = pymysql.connect(host="localhost", port=3308, user="root", password="",database="myfirstdb" )
            cursor = db.cursor()
            sql_select = "SELECT * FROM employee ORDER BY ID ASC"
            cursor.execute(sql_select)
            records = cursor.fetchall()
            result_table = PrettyTable()
            result_table.field_names = ["ID","Name","Surname"]
            for row in records:
                result_table.add_row(row)
            print(result_table)
            return result_table.get_html_string(format=True,border=True), 200

        if request.method == 'DELETE':  #format "id": [1,2,3]
            if request.is_json:
                req = request.get_json()
                db = pymysql.connect(host="localhost", port=3308, user="root", password="",database="myfirstdb" )
                cursor = db.cursor()
                placeholders = ', '.join(['%s'] * len(list(req.values())[0]))
                column = ', '.join(req.keys())
                sql_delete = "DELETE FROM employee WHERE %s IN ( %s ) " % (column, placeholders)
                cursor.execute(sql_delete, list(req.values())[0])
                db.commit()
                db.close()
                return "Deleted successful", 200
            else:
                return "Request was not JSON", 415

        if request.method == 'PUT':
            if request.is_json:
                req = request.get_json()
                db = pymysql.connect(host="localhost", port=3308, user="root", password="",database="myfirstdb" )
                cursor = db.cursor()
                upd_place = str(list(req.items())[0][0] + "=" + str(list(req.items())[0][1]))
                req.pop(list(req.keys())[0])
                #placeholders = ', '.join(['%s'] * len(req))
                change_to = ', '.join('{}="{}"'.format(first, second) for first, second in zip(list(req.keys()), list(req.values())))
                sql_update = "UPDATE employee SET %s WHERE %s " % (change_to, upd_place)
                cursor.execute(sql_update)
                db.commit()
                db.close()
                return "Update successful", 200
            else:
                return "Request was not JSON", 415


    except:
        return "Request not defined", 400


app.run(debug=True)
