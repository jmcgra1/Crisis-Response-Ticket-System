from flask import Blueprint, render_template, flash, redirect, url_for                                   
from flask import current_app as app                                                                     
from response_system.schemas import Missions, Ticket, User, db                                                           
from response_system.forms import NewMission                    
from sqlalchemy import desc 

chief = Blueprint('chief', __name__, template_folder='templates')

@chief.route('/', methods=['GET', 'POST'])
def home():
    return render_template('chiefmap.html', title='Main Page')


@chief.route('/newmission', methods=['GET', 'POST'])
def createMission():
    form = NewMission()
    if form.is_submitted():

        man_name = Missions.query.filter_by(Associated_User=form.manager.data.User_ID).first()
        newMission = Missions(
                Manager = man_name.Manager,
                Mission_Status = "Assigned", 
                Associated_User = form.manager.data.User_ID)
        db.session.add(newMission)
        db.session.commit()

        newestMission = Missions.query.order_by(desc(Missions.Mission_ID)).first()
        for newtick in form.inactive_tickets.data:
            newtick.Assigned_Mission = newestMission.Mission_ID

        db.session.commit()
        flash('Mission created successfully')
        return redirect(url_for('.home'))
    return render_template('makemission.html', form=form)

