class ContactsController < ApplicationController
  def index
    contacts = Contact.all
    render json: contacts.as_json
  end

  def show
    contact = Contact.find_by(id: params[:id])
    render json: contact.to_json
  end

  def create
    contact = Contact.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number]
    )
    contact.save
    render json: contact.to_json
  end

  def update
    contact = Contact.find_by(id: params[:id])
    contact.first_name = params[:first_name] if params[:first_name].present?
    contact.last_name = params[:last_name] if params[:last_name].present?
    contact.email = params[:email] if params[:email].present?
    contact.phone_number = params[:phone_number] if params[:phone_number].present?
    contact.save
    render json: contact
  end

  def destroy
    contact = Contact.find_by(id: params[:id])
    contact.destroy
    render json: {message: "Contact destroyed!"}
  end
end
