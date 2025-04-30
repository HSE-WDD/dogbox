from cs50 import SQL

db = SQL("sqlite:///dogbox.db")

# add a new owner to the database
def add_owner(owner):
    sql = "INSERT INTO owners (first_name, last_name, email) VALUES (?,?,?)"
    owner_id = db.execute(sql, owner.get("first_name"),
                               owner.get("last_name"),
                               owner.get("email"))
    if owner_id > 0:
        return owner_id
    else:
        return None


def get_owner_choices():
    sql = "SELECT owner_id, first_name, last_name FROM owners ORDER BY last_name"
    owners = db.execute(sql)
    owners_list = [(0, "Choose an Owner", {"disabled":True})]
    # loop through this list of dicts and create the tuples
    for owner in owners:
        full_name = owner.get("first_name") + " " + owner.get("last_name")
        owner_tuple = (owner.get("owner_id"), full_name)
        owners_list.append(owner_tuple)
    return owners_list

def get_owner_by_id(id):
    sql = "SELECT * FROM owners WHERE owner_id = ?"
    owners = db.execute(sql, id)
    if owners:
        return owners[0] # just the one dict
    else:
        return None
