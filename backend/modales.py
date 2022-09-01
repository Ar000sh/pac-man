from flask import Flask, request
# import datetime
from flask import jsonify, request, url_for
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS
# import time
from sqlalchemy import func 

# from sqlalchemy import event
# from sqlalchemy.engine import Engine
# from sqlite3 import Connection as SQLite3Connection
# @event.listens_for(Engine, "connect")
# def _set_sqlite_pragma(dbapi_connection, connection_record):
#     if isinstance(dbapi_connection, SQLite3Connection):
#         cursor = dbapi_connection.cursor()
#         cursor.execute("PRAGMA foreign_keys=ON;")
#         cursor.close()

app = Flask(__name__)
CORS(app) # This allows CORS for all domains on all routes
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:Password123!@mariadb:3306/demo'
db = SQLAlchemy(app)

# engine = create_engine("mysql+pymysql://root:Password123!@localhost:3306/database")
# from sqlalchemy import event
# from sqlalchemy.engine import Engine
# from sqlite3 import Connection as SQLite3Connection
# @event.listens_for(Engine, "connect")
# def _set_sqlite_pragma(dbapi_connection, connection_record):
#     if isinstance(dbapi_connection, SQLite3Connection):
#         cursor = dbapi_connection.cursor()
#         cursor.execute("PRAGMA foreign_keys=ON;")
#         cursor.close()




class Highscore(db.Model):#1
    id = db.Column(db.Integer, primary_key=True,autoincrement=True)
    highscore = db.Column(db.Integer, nullable=False)
    # Erzeugt aus einer Instanz einer Klasse ein Json Format
    # Lazy führt wirkliche Änderung erst ab Commit aus
    def to_json(self):
        json_post = {
            'id': self.id,
            'highscore': self.highscore
        }
        return json_post

# db.drop_all()
db.create_all()


@app.route('/highscores', methods=['GET'])
def get_highscores():
    
    data = db.session.query(Highscore).all()

    return jsonify(({'Highscore': [m.to_json() for m in data]}))

@app.route('/highscore', methods=['GET','POST'])
def create_Customer():
    if request.method == 'POST':

        args = {
            'highscore': request.json.get('highscore')
        }

        highscore = Highscore(highscore=args['highscore'])
        db.session.add(highscore)
        db.session.commit()
        return {'message': 'successfully created'},201
    else:
        result = db.session.query(func.max(Highscore.highscore)).first()

        return jsonify(result[0])



if __name__ == "__main__":
    app.run(host="0.0.0.0",debug=True)
