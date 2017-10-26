require 'unirest'
require 'pp'

while true
  system "clear"
  puts "CONTACTS APP - Choose an option:"
  puts "[1] Show all contacts"
  puts "[2] Show one contact"
  puts "[3] Create a new contact"
  puts "[4] Exit"
  option = gets.chomp
  system "clear"
  if option == "1"
    puts "Here are all the contacts:"
    contacts = Unirest.get("http://localhost:3000/contacts").body
    pp contacts
    puts "Press enter to continue"
    gets.chomp
  elsif option == "2"
    puts "Enter the id of a contact to show:"
    id = gets.chomp
    contact = Unirest.get("http://localhost:3000/contacts/#{id}").body
    pp contact
    puts "Press enter to continue"
    gets.chomp
  elsif option == "3"
    params = {}
    print "First name: "
    params[:first_name] = gets.chomp
    print "Last name: "
    params[:last_name] = gets.chomp
    print "Email: "
    params[:email] = gets.chomp
    print "Phone number: "
    params[:phone_number] = gets.chomp
    new_contact = Unirest.post("http://localhost:3000/contacts", parameters: params).body
    p new_contact
    puts "Press enter to continue"
    gets.chomp
  elsif option == "4"
    puts "Thank you! Goodbye."
    break
  else
    puts "Unknown option. Press enter to continue."
    gets.chomp
  end
end