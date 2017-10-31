require 'unirest'
require 'pp'

jwt = ""

while true
  system "clear"
  puts "CONTACTS APP - Choose an option:"
  if jwt == ""
    puts "[7] Register (create a user)"
    puts "[8] Login"
  else
    puts "[1] Show all contacts"
    puts "[2] Show one contact"
    puts "[3] Create a new contact"
    puts "[4] Update a contact"
    puts "[5] Destroy a contact"
    puts "[6] Search contacts"
    puts
    puts "[9] Logout"
  end
  puts
  puts "[0] Exit"
  option = gets.chomp
  system "clear"
  if option == "1"
    puts "Here are all the contacts:"
    contacts = Unirest.get("http://localhost:3000/contacts", headers: {Authorization: "Bearer #{jwt}"}).body
    pp contacts
    puts "Press enter to continue"
    gets.chomp
  elsif option == "2"
    puts "Enter the id of a contact to show:"
    id = gets.chomp
    contact = Unirest.get("http://localhost:3000/contacts/#{id}", headers: {Authorization: "Bearer #{jwt}"}).body
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
    new_contact = Unirest.post("http://localhost:3000/contacts", parameters: params, headers: {Authorization: "Bearer #{jwt}"}).body
    pp new_contact
    puts "Press enter to continue"
    gets.chomp
  elsif option == "4"
    puts "Enter the id of a contact to show:"
    id = gets.chomp
    contact = Unirest.get("http://localhost:3000/contacts/#{id}", headers: {Authorization: "Bearer #{jwt}"}).body
    params = {}
    print "First name (#{contact["first_name"]}): "
    params[:first_name] = gets.chomp
    print "Last name (#{contact["last_name"]}): "
    params[:last_name] = gets.chomp
    print "Email (#{contact["email"]}): "
    params[:email] = gets.chomp
    print "Phone number (#{contact["phone_number"]}): "
    params[:phone_number] = gets.chomp
    updated_contact = Unirest.patch("http://localhost:3000/contacts/#{id}", parameters: params, headers: {Authorization: "Bearer #{jwt}"}).body
    pp updated_contact
    puts "Press enter to continue"
    gets.chomp
  elsif option == "5"
    puts "Enter the id of a contact to destroy:"
    id = gets.chomp
    response = Unirest.delete("http://localhost:3000/contacts/#{id}", headers: {Authorization: "Bearer #{jwt}"}).body
    puts response["message"]
    puts "Press enter to continue"
    gets.chomp
  elsif option == "6"
    puts "Enter search terms:"
    search_terms = gets.chomp
    contacts = Unirest.get("http://localhost:3000/contacts?search=#{search_terms}", headers: {Authorization: "Bearer #{jwt}"}).body
    pp contacts
    puts "Press enter to continue"
    gets.chomp
  elsif option == "7"
    puts "Register"
    params = {}
    print "Name: "
    params[:name] = gets.chomp
    print "Email: "
    params[:email] = gets.chomp
    print "Password: "
    params[:password] = gets.chomp
    print "Password confirmation: "
    params[:password_confirmation] = gets.chomp
    response = Unirest.post("http://localhost:3000/users", parameters: params, headers: {Authorization: "Bearer #{jwt}"}).body
    pp response
    puts "Press enter to continue"
    gets.chomp
  elsif option == "8"
    puts "Login"
    params = {}
    print "Email: "
    params[:email] = gets.chomp
    print "Password: "
    params[:password] = gets.chomp
    response = Unirest.post("http://localhost:3000/user_token", parameters: {auth: {email: params[:email], password: params[:password]}}).body
    jwt = response["jwt"]
    pp response
    puts "Press enter to continue"
    gets.chomp
  elsif option == "9"
    jwt = ""
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
