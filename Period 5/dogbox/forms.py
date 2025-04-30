from flask_wtf import FlaskForm
from wtforms import StringField, EmailField, SelectField, SubmitField
from wtforms.validators import InputRequired


class OwnerForm(FlaskForm):
    # now we just list the fields we need for our form
    first_name = StringField("First Name:", validators=[InputRequired()])
    last_name = StringField("Last Name:", validators=[InputRequired()])
    email = EmailField("Email:", validators=[InputRequired()])

class ChooseOwnerForm(FlaskForm):
    owner_id = SelectField("Owner Name:", validators=[InputRequired()], coerce=int, default=0)
    submit = SubmitField("Next")

