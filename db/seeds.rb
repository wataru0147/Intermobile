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
technician = User.new
technician.email = "technician@intermobile.com"
technician.password = "technician12345"
technician.password_confirmation = "technician12345"
technician.confirmed_at = Time.now
technician.role_id = 3
technician.save!
staff = User.new
staff.email = "staff@intermobile.com"
staff.password = "staff12345"
staff.password_confirmation = "staff12345"
staff.confirmed_at = Time.now
staff.role_id = 2
staff.save!
carmanufacturers = CarManufacturer.create([ {name: 'Aston Martin'}, {name: 'Audi'}, {name: 'Bentley'}, {name: 'BMW'}, {name: 'Chevrolet'}, {name: 'Chrysler/Dodge'}, {name: 'Ferrari'}, {name: 'Ford'}, {name: 'Foton'}, {name: 'Honda'}, {name: 'Hyundai'}, {name: 'Isuzu'}, {name: 'Jaguar'}, {name: 'Jeep'}, {name: 'Kia'}, {name: 'Land Rover'}, {name: 'Lexus'}, {name: 'Lotus'}, {name: 'Mahindra'}, {name: 'Maserati'}, {name: 'Mazda'}, {name: 'Mercedes-Benz'}, {name: 'MG'}, {name: 'Mini'}, {name: 'Mitsubishi'}, {name: 'Morgan'}, {name: 'Nissan'}, {name: 'Peugeot'}, {name: 'Porsche'}, {name: 'Rolls-Royce'}, {name: 'SSsangyong'}, {name: 'Subaru'}, {name: 'Suzuki'}, {name: 'Tata'}, {name: 'Toyota'}, {name: 'Volkswagen'}, {name: 'Volvo'} ])