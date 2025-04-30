from flask import Flask, render_template, redirect
from forms import OwnerForm, ChooseOwnerForm
import queries as q

app = Flask(__name__)
app.config['SECRET_KEY'] = "this is super secret shhhhh"

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/addowner", methods=["GET","POST"])
def addowner():
    form = OwnerForm()
    # when the form is submitted
    if form.validate_on_submit():
        # add the owner to the database
        owner_id = q.add_owner(form.data)
        return f"You have a new owner with id of {owner_id}!"

    return render_template("ownerform.html", form=form, action="add")

@app.route("/editowner", methods=["GET", "POST"])
def editowner():
    # first get a list of all the owners and their ids
    owner_choices = q.get_owner_choices()
    # in order to edit an owner, the user must frirst select and owner
    form = ChooseOwnerForm()
    # give the owner_id field the choices for the dropdown
    form.owner_id.choices = owner_choices

    # when the user submits the form
    if form.validate_on_submit():
        #get the owners info based on the id selected
        owner_id = form.owner_id.data
        # query the database for this owners info
        owner_info = q.get_owner_by_id(owner_id)
        owner_form = OwnerForm(data = owner_info)
        return render_template("ownerform.html", form=owner_form, action="edit", owner_id=owner_id)

    return render_template("chooseowner.html", form=form)


@app.route("/editowner/<int:owner_id>", methods=["GET","POST"])
def updateowner(owner_id):
    # get the data from the form
    # update the database with that data
    # show message that it was successfull or not.
    pass # keep the app from crashing until we do this function
