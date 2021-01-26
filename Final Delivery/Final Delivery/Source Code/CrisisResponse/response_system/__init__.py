from flask import Flask
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

def init_app():
    app = Flask(__name__)
    app.config.from_object('config.Config')

    db.init_app(app)

    with app.app_context():
        from .login.login import login
        from .callcenter.callcenter import callcenter
        from .chief.chief import chief
        from .missions.missions import missions

        app.register_blueprint(login)
        app.register_blueprint(callcenter, url_prefix='/callcenteroperator')                            
        app.register_blueprint(chief, url_prefix='/operationschief')                                    
        app.register_blueprint(missions, url_prefix='/missionmanager')
        
        db.Model.metadata.reflect(db.engine)
        
        return app
