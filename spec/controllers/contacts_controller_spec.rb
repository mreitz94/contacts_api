require "rails_helper"  

RSpec.describe ContactsController, type: :request do

  describe "GET index" do
    it "gets all contacts" do
      contact = Contact.create(first_name: 'John', last_name: 'Doe')
      get '/contacts'
      expect(assigns(:contacts)).to eq([contact])
    end
    it 'should return 200 HTTP code' do
      get '/contacts'
      expect(response.status).to eq(200)
    end
  end

  describe "GET show" do
    it "gets a contact" do
      contact = Contact.create(first_name: 'John', last_name: 'Doe')
      get "/contacts/#{contact.id}"
      expect(response.body).to eq(contact.to_json)
    end

    it "tries to get a contact that does not exist" do
      get "/contacts/-1"
      expect(response.status).to eq(404)
    end
  end

  describe "POST create" do
    it "creates a new contact" do
      post "/contacts?first_name=John&last_name=Doe"
      result = JSON.parse(response.body)
      expect(result['contact']['first_name']).to eq('John')
      expect(result['contact']['last_name']).to eq('Doe')
    end

    it "tries to get a contact without a required field" do
      post "/contacts?last_name=Doe"
      result = JSON.parse(response.body)
      expect(result['status']).to eq('error')
      expect(result['message']).to eq('Contact could not be created')
      expect(result['errors']['first_name'].first).to eq('can\'t be blank')
      expect(response.status).to eq(422)
    end
  end

  describe "PATCH update" do
    it "updates an existing contact" do
      contact = Contact.create(first_name: 'John', last_name: 'Doe')
      patch "/contacts/#{contact.id}?phone=8005551111"
      result = JSON.parse(response.body)
      expect(result['contact']['phone']).to eq('8005551111')
    end

    it "tries to update a contact setting a required field to null" do
      contact = Contact.create(first_name: 'John', last_name: 'Doe')
      patch "/contacts/#{contact.id}?first_name="
      result = JSON.parse(response.body)
      expect(result['status']).to eq('error')
      expect(result['message']).to eq('Contact could not be created')
      expect(result['errors']['first_name'].first).to eq('can\'t be blank')
      expect(response.status).to eq(422)
    end

    it "tries to update a contact that does not exist" do
      get "/contacts/-1?phone=8005551111"
      expect(response.status).to eq(404)
    end
  end

  describe "DELETE destroy" do
    it "deletes an existing contact" do
      contact = Contact.create(first_name: 'John', last_name: 'Doe')
      delete "/contacts/#{contact.id}"
      result = JSON.parse(response.body)
      expect(result['message']).to eq('Contact deleted successfully')
    end

    it "tries to delete a contact that does not exist" do
      delete "/contacts/-1"
      expect(response.status).to eq(404)
    end
  end
end