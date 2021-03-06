class ContactsController < ApplicationController
  before_action :authenticate_user

  def index
    if current_user
      contacts = current_user.contacts
      search_term = params[:search]
      if search_term
        contacts = contacts.where("first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ? OR phone_number ILIKE ?", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%")
      end
      group_id = params[:group_id]
      if group_id
        contacts = Group.find_by(id: group_id).contacts.where(user_id: current_user.id)
      end
      render json: contacts.as_json
    else
      render json: []
    end
  end

  def show
    contact = Contact.find_by(id: params[:id])
    render json: contact.as_json
  end

  def create
    contact = Contact.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number],
      user_id: current_user.id
    )
    if contact.save
      render json: contact.as_json, status: :created
    else
      render json: {errors: contact.errors.full_messages}, status: :bad_request
    end
  end

  def update
    contact = Contact.find_by(id: params[:id])
    contact.first_name = params[:first_name] if params[:first_name].present?
    contact.last_name = params[:last_name] if params[:last_name].present?
    contact.email = params[:email] if params[:email].present?
    contact.phone_number = params[:phone_number] if params[:phone_number].present?
    if contact.save
      render json: contact.as_json, status: :ok
    else
      render json: {errors: contact.errors.full_messages}, status: :bad_request
    end
  end

  def destroy
    contact = Contact.find_by(id: params[:id])
    contact.destroy
    render json: {message: "Contact destroyed!"}
  end
end
