admin = db.getSiblingDB("admin")

admin.grantRolesToUser( "haidv", [ "root" , { role: "root", db: "admin" } ] )
