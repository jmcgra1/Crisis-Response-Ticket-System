from . import db
db.Model.metadata.reflect(db.engine)

class Ticket(db.Model):
    __table__ = db.Model.metadata.tables['Tickets']

class User(db.Model):
    __table__ = db.Model.metadata.tables['Users'] 

class Missions(db.Model):
    __table__ = db.Model.metadata.tables['Mission'] 
    
class Agents(db.Model):
    __table__ = db.Model.metadata.tables['Agent'] 

class Vehicles(db.Model):
    __table__ = db.Model.metadata.tables['Vehicle'] 

