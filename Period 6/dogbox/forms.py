from flask_wtf import FlaskForm
from wtforms import StringField, EmailField, SelectField, SubmitField
from wtforms.validators import InputRequired


# a form for owners (add/edit)
class OwnerForm(FlaskForm):
    # now list out the fields we need for the form
    first_name = StringField("First Name:", validators=[InputRequired()])
    last_name = StringField("Last Name:", validators=[InputRequired()])
    email = EmailField("Email:", validators=[InputRequired()])

class ChooseOwnerForm(FlaskForm):
    # we need a select field for all the owners
    owner_id = SelectField("Owner's Name:", validators=[InputRequired()], coerce=int, default=0)
    submit = SubmitField("Next")
