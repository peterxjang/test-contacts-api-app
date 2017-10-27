require 'unirest'
require 'pp'

while true
  system "clear"
  puts "CONTACTS APP - Choose an option:"
  puts "[1] Show all contacts"
  puts "[2] Show one contact"
  puts "[3] Create a new contact"
  puts "[4] Update a contact"
  puts "[5] Destroy a contact"
  puts "[0] Exit"
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
    pp new_contact
    puts "Press enter to continue"
    gets.chomp
  elsif option == "4"
    puts "Enter the id of a contact to show:"
    id = gets.chomp
    contact = Unirest.get("http://localhost:3000/contacts/#{id}").body
    params = {}
    print "First name (#{contact["first_name"]}): "
    params[:first_name] = gets.chomp
    print "Last name (#{contact["last_name"]}): "
    params[:last_name] = gets.chomp
    print "Email (#{contact["email"]}): "
    params[:email] = gets.chomp
    print "Phone number (#{contact["phone_number"]}): "
    params[:phone_number] = gets.chomp
    updated_contact = Unirest.patch("http://localhost:3000/contacts/#{id}", parameters: params).body
    pp updated_contact
    puts "Press enter to continue"
    gets.chomp
  elsif option == "5"
    puts "Enter the id of a contact to destroy:"
    id = gets.chomp
    response = Unirest.delete("http://localhost:3000/contacts/#{id}").body
    puts response["message"]
    puts "Press enter to continue"
    gets.chomp
  elsif option == "0"
    puts "Thank you! Goodbye."
    break
  else
    puts "Unknown option. Press enter to continue."
    gets.chomp
  end
end
