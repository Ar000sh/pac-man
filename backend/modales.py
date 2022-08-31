from flask import Flask
from flask_sqlalchemy import SQLAlchemy
# from sqlalchemy import create_engine

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

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:Password123!@10.152.183.34:3306/demo'
db = SQLAlchemy(app)


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