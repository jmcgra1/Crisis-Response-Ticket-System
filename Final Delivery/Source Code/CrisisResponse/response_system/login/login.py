from flask import (
        Blueprint,
        url_for,
        render_template, 
        redirect,
        flash)
from flask import current_app as app
from response_system.forms import LoginForm
from response_system.schemas import User

login = Blueprint('login', __name__, template_folder='templates')

@login.route('/', methods=['GET', 'POST'])
def index():
    form = LoginForm()
    if form.validate_on_submit():
        global data
        data = User.query.filter(
            User.Username == form.username.data, 
            User.Password == form.password.data).first()
        if not data is None:
            page = data.Role.lower().replace(' ', '')
            return redirect(url_for('login.success', pageview=page))
        flash("Invalid username or password")
    return render_template('login.html', title='Sign In', form=form)

@login.route('/<pageview>', methods=['GET', 'POST'])
def success(pageview):
    return redirect(url_for(pageview))

def return_username():
    return data.Username

def return_role():
    return data.Role

def return_uid():
    return data.User_ID

@app.context_processor
def get_uid():
    return dict(key='value', return_uid=return_uid)

@app.context_processor
def get_username():
    return dict(key='value', return_username=return_username)

@app.context_processor
def get_role():
    return dict(key='value', return_role=return_role)


