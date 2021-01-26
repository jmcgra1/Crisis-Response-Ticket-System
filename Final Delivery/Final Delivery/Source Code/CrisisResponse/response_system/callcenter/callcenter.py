from flask import Blueprint, render_template, flash, redirect, url_for
from flask import current_app as app
from response_system.schemas import Ticket, db
from response_system.forms import TicketForm, EditTicket
from sqlalchemy import desc, update

callcenter = Blueprint('callcenter', __name__, template_folder='templates')

states = [("AL","Alabama"),("AK","Alaska"),("AZ","Arizona"),("AR","Arkansas"),("CA", "California"),("CO", "Colorado"),
        ("CT","Connecticut"),("DC","Washington DC"),("DE","Delaware"),("FL","Florida"),("GA","Georgia"),
        ("HI","Hawaii"),("ID","Idaho"),("IL","Illinois"),("IN","Indiana"),("IA","Iowa"),("KS","Kansas"),("KY","Kentucky"),
        ("LA","Louisiana"),("ME","Maine"),("MD","Maryland"),("MA","Massachusetts"),("MI","Michigan"),("MN","Minnesota"),
        ("MS","Mississippi"),("MO","Missouri"),("MT","Montana"),("NE","Nebraska"),("NV","Nevada"),("NH","New Hampshire"),
        ("NJ","New Jersey"),("NM","New Mexico"),("NY","New York"),("NC","North Carolina"),("ND","North Dakota"),("OH","Ohio"),
        ("OK","Oklahoma"),("OR","Oregon"),("PA","Pennsylvania"),("RI","Rhode Island"),("SC","South Carolina"),("SD","South Dakota"),
        ("TN","Tennessee"),("TX","Texas"),("UT","Utah"),("VT","Vermont"),("VA","Virginia"),("WA","Washington"),("WV","West Virginia"),
        ("WI","Wisconsin"),("WY","Wyoming")]

state_abbr = dict([(sub[1], sub[0]) for sub in states])

@callcenter.route('/', methods=['GET', 'POST'])
def home():
    form = TicketForm()
    if form.validate_on_submit():
        state_letters = state_abbr[form.state.data]
        street_info = form.address_line.data.split(" ", 1)
        newTicket = Ticket(
                Comments = form.description.data,
                Status = 1,
                Event_Type = form.event_type.data,
                Street_Number = street_info[0],
                Street_Name = street_info[1],
                City = form.city.data,
                State = state_letters,
                Zip_Code = form.zipcode.data,
                Latitude = form.latitude.data,
                Longitude = form.longitude.data,
                Assigned_Mission = None, 
                Phone_Number = form.phone_num.data)
        db.session.add(newTicket)
        db.session.commit()
        flash('Successful Ticket Creation')
        return redirect(url_for('.home'))
    return render_template('newticket.html', title='New Ticket', form=form)

@callcenter.route('/history', methods=['GET', 'POST'])
def history():
    return render_template('tickethistory.html', 
                            tickets = Ticket.query.order_by(desc(Ticket.Ticket_ID)).all())

@callcenter.route('/edit/<ticketid>', methods=['GET', 'POST'])
def editTicket(ticketid):
    form = EditTicket()
    getTicket = Ticket.query.filter_by(Ticket_ID=ticketid).first()
    if form.is_submitted():
        getTicket.Event_Type = form.event_type.data
        getTicket.Comments = form.description.data
        db.session.commit()
        flash('Ticket updated successfully')
        return redirect(url_for('.history'))
    return render_template('editTicket.html', form=form)


