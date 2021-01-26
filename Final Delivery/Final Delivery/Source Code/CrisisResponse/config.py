import os

class Config(object):
    SECRET_KEY = 'teamcloud'
    SQLALCHEMY_DATABASE_URI = 'mysql+mysqlconnector://admin:teamcloud@teamcloud-crts-db.ctgd6p5mit1v.us-east-2.rds.amazonaws.com/mydb'
    SQLALCHEMY_TRACK_MODIFICATIONS = False
