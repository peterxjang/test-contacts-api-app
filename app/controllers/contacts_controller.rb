class ContactsController < ApplicationController
  def index
    contacts = Contact.all
    output = []
    contacts.each do |contact|
      output << {
        id: contact.id,
        first_name: contact.first_name,
        last_name: contact.last_name,
        email: contact.email,
        phone_number: contact.phone_number
      }
    end
    render json: output
  end

  def show
    contact = Contact.find_by(id: params[:id])
    output = {
      id: contact.id,
      first_name: contact.first_name,
      last_name: contact.last_name,
      email: contact.email,
      phone_number: contact.phone_number
    }
    render json: output
  end
end
