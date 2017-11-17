class ContactsController < ApplicationController
  before_action :set_contact, only: [:show, :update, :destroy]

  # GET /contacts
  def index
    @contacts = Contact.all
    render json: @contacts, status: :ok
  end

  # GET /contacts/1
  def show
    if !@contact
      render json: not_found_error, status: :not_found
    else
      render json: @contact, status: :ok
    end
  end

  # POST /contacts
  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      render json: success_message('created'), status: :created, location: @contact
    else
      render json: error_message, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contacts/1
  def update
    if !@contact
      render json: not_found_error, status: :not_found
    elsif @contact.update(contact_params)
      render json: success_message('updated'), status: :ok
    else
      render json: error_message, status: :unprocessable_entity
    end
  end

  # DELETE /contacts/1
  def destroy
    if !@contact
      render json: not_found_error, status: :not_found
    elsif @contact.destroy
      render json: { message: 'Contact deleted successfully' }, status: :ok
    else
      render json: error_message, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find_by(id: params[:id])
    end

    def success_message(action)
      { status: 'success', message: "Contact #{action} successfully", contact: @contact }
    end

    def error_message
      { status: 'error', message: 'Contact could not be created', errors: @contact.errors }
    end

    def not_found_error
      { status: 'error', message: 'Contact not found', errors: ["id #{params[:id]} does not exist"] }
    end

    # Only allow a trusted parameter "white list" through.
    def contact_params
      params.permit(:first_name, :last_name, :phone, :email)
    end
end
