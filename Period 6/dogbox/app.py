from flask import Flask, render_template, redirect
from forms import OwnerForm, ChooseOwnerForm
import queries as q

app = Flask(__name__)
app.config['SECRET_KEY'] = "this is my secret key shhhhhh!"

@app.route("/")
def index():
    return render_template("index.html")

@app.route("/addowner", methods=["GET","POST"])
def addowner():
    # make a form to add a new owner
    form = OwnerForm()
    # how do we submit the form?
    if form.validate_on_submit():
        owner_id = q.add_owner(form.data)
        return f"New owner was added with the id of {owner_id}"

    return render_template("ownerform.html", form=form, action="add")

@app.route("/editowner", methods=["GET","POST"])
def editowner():
    # in order to edit an owern's info we must first know what onwer the
    # user selected
    form = ChooseOwnerForm()
    # now get all the owner_id's and full names of the owners from the database
    owner_choices = q.get_owner_choices()
    # add the owner_choices to the form
    form.owner_id.choices = owner_choices

    # process the form when the user clicks Next
    if form.validate_on_submit():
        owner_id = form.owner_id.data
        # we need all the info about that owner from our database
        owner = q.get_owner_by_id(owner_id)
        # give the form the data from the database
        owner_form = OwnerForm(data=owner)
        # render the form
        return render_template("ownerform.html",
                               form=owner_form,
                               action="edit",
                               owner_id=owner_id)

    return render_template("chooseowner.html", form=form)


@app.route("/editowner/<int:owner_id>", methods=["GET","POST"])
def updateowner(owner_id):
    # TODO
    # get the data from the form
    form = OwnerForm()
    updated_info = form.data
    # use the owner_id to UPDATE our database with the new data from the form
    if form.validate_on_submit():
        was_updated = q.update_owner(updated_info, owner_id)
        # show the user a message that the update was successful or not

    return updated_info
