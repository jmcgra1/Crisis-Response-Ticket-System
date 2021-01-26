from flask_wtf import FlaskForm                                                       
from wtforms import (
          StringField, 
          PasswordField, 
          SubmitField, 
          SelectField, 
          FloatField, 
          IntegerField, 
          HiddenField)
from wtforms.validators import InputRequired
from wtforms.widgets import HiddenInput
from wtforms.ext.sqlalchemy.fields import QuerySelectField, QuerySelectMultipleField
from .schemas import Agents, Vehicles, Ticket, User, Missions, db

class LoginForm(FlaskForm):                                                           
    username = StringField('Username', validators=[InputRequired()])                   
    password = PasswordField('Password', validators=[InputRequired()])                 
    submit = SubmitField('Sign In')                                                   

types = [(1, 'Fire'), (2, 'Flooding'), (3, 'Electrical'), (4, 'Paramedic'), (5, 'Misc')]

class TicketForm(FlaskForm):                                                          
   event_type = SelectField("Event Type", choices=types)                              
   description = StringField("Details")                                
   phone_num = StringField("Phone number", validators=[InputRequired()])
   address_search = StringField("Find Location")
   address_line = StringField("Address", validators=[InputRequired()])            
   city = StringField("City", validators=[InputRequired()])                          
   state = StringField("State", validators=[InputRequired()])
   zipcode = IntegerField("Zipcode", validators=[InputRequired()])                   
   latitude = FloatField(widget=HiddenInput())                   
   longitude = FloatField(widget=HiddenInput())                
   submit = SubmitField('Submit Ticket') 

class EditTicket(FlaskForm):
    event_type = SelectField("Edit Event Type", choices=types)
    description = StringField("Edit Description")
    submit = SubmitField('Confirm Update')

def unassigned_tickets():
    return Ticket.query.filter(Ticket.Assigned_Mission==None).all()

def manager_options():                                                                        
    return User.query.filter_by(Role="Mission Manager").all()  

def available_agents():
    return Agents.query.filter_by(Assigned_Mission=None).all()

def available_amb():
    return Vehicles.query.filter(Vehicles.Vehicle_Type=="Ambulance", 
                                Vehicles.Assigned_Mission==None).all()

def available_fire():
    return Vehicles.query.filter(Vehicles.Vehicle_Type=="Firetruck",
                                Vehicles.Assigned_Mission==None).all()

def available_heli():
    return Vehicles.query.filter(Vehicles.Vehicle_Type=="Helicopter",
                                Vehicles.Assigned_Mission==None).all()

def available_pol():
    return Vehicles.query.filter(Vehicles.Vehicle_Type=="Police_Vehicle",
                                Vehicles.Assigned_Mission==None).all()

def available_serv():
    return Vehicles.query.filter(Vehicles.Vehicle_Type=="Service_Vehicle",
                                Vehicles.Assigned_Mission==None).all()

class AssignResources(FlaskForm):
    avail_agents = QuerySelectMultipleField("Agents",
                            validators=[InputRequired()],
                            query_factory=available_agents)
    vehicles_amb = QuerySelectMultipleField("Ambulances",
                            validators=[InputRequired()],
                            query_factory=available_amb)
    vehicles_fire = QuerySelectMultipleField("Firetrucks",
                            validators=[InputRequired()],
                            query_factory=available_fire)
    vehicles_heli = QuerySelectMultipleField("Helicopters",
                            validators=[InputRequired()],
                            query_factory=available_heli)
    vehicles_pol = QuerySelectMultipleField("Police",
                            validators=[InputRequired()],
                            query_factory=available_pol)
    vehicles_serv = QuerySelectMultipleField("Service Vehicles",
                            validators=[InputRequired()],
                            query_factory=available_serv)
    submit = SubmitField('Assign Resources to Mission')

class NewMission(FlaskForm):
    inactive_tickets = QuerySelectMultipleField("New Tickets",
                            validators=[InputRequired()],
                            query_factory=unassigned_tickets)
    manager = QuerySelectField("Assign to Mission Manager", 
                            validators=[InputRequired()],
                            query_factory=manager_options)
    submit = SubmitField('Create Mission')
