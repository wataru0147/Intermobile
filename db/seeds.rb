# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#raje
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

roles = Role.create([{ name: 'user'}, { name: 'staff'}, { name: 'technician'}, { name: 'admin'}])
adminuser = User.new
adminuser.email = "admin@intermobile.com"
adminuser.password = "admin12345"
adminuser.password_confirmation = "admin12345"
adminuser.confirmed_at = Time.now
adminuser.role_id = 4
adminuser.save!
