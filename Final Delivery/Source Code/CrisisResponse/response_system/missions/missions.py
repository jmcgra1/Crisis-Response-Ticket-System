from flask import Blueprint, render_template, flash, redirect, url_for       
from flask import current_app as app                                         
from response_system.schemas import Missions, Ticket, User, Agents, Vehicles, db               
from response_system.forms import AssignResources                                 
from sqlalchemy import desc
from response_system.login.login import return_uid

missions = Blueprint('missions', __name__, template_folder='templates')            
                                                                             
@missions.route('/', methods=['GET', 'POST'])                                   
def home():
    uid = return_uid()
    return render_template('missions.html',
                    managedmissions = Missions.query.filter_by(Associated_User=uid).all())
    
@missions.route('/info/<missionid>', methods=['GET','POST'])
def allocateStuff(missionid):
    form = AssignResources()
    thismission = Missions.query.filter_by(Mission_ID=missionid).first()
    if form.is_submitted():
        thismission.Mission_Status = "In Progress"
        newagents = form.avail_agents.data
        newvehicles = form.vehicles_amb.data + \
                    form.vehicles_fire.data + \
                    form.vehicles_heli.data + \
                    form.vehicles_pol.data + \
                    form.vehicles_serv.data
        
        for agent in newagents:
            agent.Assigned_Mission = missionid

        for vehicle in newvehicles:
            vehicle.Status = 1
            vehicle.Assigned_Mission = missionid

        db.session.commit()
        flash('Resources Allocated Successfully ')
        return redirect(url_for('.home'))
    return render_template('missioninfo.html', 
        mission=missionid,
        status=thismission.Mission_Status,
        tickets = Ticket.query.filter_by(Assigned_Mission=missionid).all(),
        form = form)
    
@missions.route('/updatestatus/<missionid>', methods=['GET', 'POST'])                         
def updateStatus(missionid):
    endmission = Missions.query.filter_by(Mission_ID=missionid).first()
    freeagents = Agents.query.filter_by(Assigned_Mission=missionid).all()
    freevehicles = Vehicles.query.filter_by(Assigned_Mission=missionid).all()
    
    endmission.Mission_Status = "Completed"
    for agent in freeagents:
        agent.Assigned_Mission = None

    for vehicle in freevehicles:
        vehicle.Status = 0
        vehicle.Assigned_Mission = None

    db.session.commit()
    flash('Mission Completed')
    return redirect(url_for('.home'))  
