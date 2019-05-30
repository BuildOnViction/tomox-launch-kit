admin = db.getSiblingDB("admin")
admin.createUser(
  {
    user: "admin",
    pwd: "changeme",
    roles: [ { role: "userAdminAnyDatabase", db: "admin" } ]
  }
)

db.getSiblingDB("admin").auth("admin", "changeme" )

db.getSiblingDB("admin").createUser(
  {
    "user" : "replicaAdmin",
    "pwd" : "changeme",
    roles: [ { "role" : "clusterAdmin", "db" : "admin" } ]
  }
)
