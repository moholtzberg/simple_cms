# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)
  
  AdminUser.create(:username => 'Admin', :email => 'test@test.test', :hashed_password => 'ca4a6371f9d8236344288b650c1f29e9b313f52a', :salt => 'a999deb7e227b9c0188a47746008e9331869c573')
