require 'rails_helper'

RSpec.describe "Applications", type: :request do
  
  describe "POST /api/v1/applications" do
    it "create a Application fail because it does not have name" do
      headers = { "ACCEPT" => "application/json" }
      post "/api/v1/applications", :headers => headers
  
      expect(response.content_type).to eq("application/json")
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end  

  
  describe "POST /api/v1/applications" do
    it "creates a Application succed beacuse it has name" do
      headers = { "ACCEPT" => "application/json" }
      post "/api/v1/applications", :params => {:name => "My App"}  ,:headers => headers
  
      expect(response.content_type).to eq("application/json")
      expect(response).to have_http_status(:ok)
    end
  end  

  # chats endpoint
  describe "GET /api/v1/applications/{token}/chats" do
    it "get chats of specific application" do
      headers = { "ACCEPT" => "application/json" }
      app = Application.create(name: "anas")
      get "/api/v1/applications/" + app.token + "/chats", :headers => headers
      expect(response.content_type).to eq("application/json")
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /api/v1/applications/{token}/chats" do

    it "chat not created because it has invalid token" do
      headers = { "ACCEPT" => "application/json" }
      post "/api/v1/applications/invalid_token/chats", :headers => headers
      expect(response.content_type).to eq("application/json")
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "chat created succefully because it has valid token" do
      headers = { "ACCEPT" => "application/json" }
      app = Application.create(name: "anas") 
      expect(app).not_to be_nil  
      expect(app.save).to be_truthy
      post "/api/v1/applications/" + app.token + "/chats", :headers => headers
      expect(response.content_type).to eq("application/json")
      expect(response).to have_http_status(:ok)
    end
  end  

  # message endpoint
  describe "GET /api/v1/applications/{token}/chats/{chat_number}/messages" do
    it "get messages of specific chat in specific application" do
      headers = { "ACCEPT" => "application/json" }
      app  = Application.create(name: "anas")
      chat = app.chats.create
      get "/api/v1/applications/" + app.token + "/chats/" + chat.chat_number.to_s + "/messages", :headers => headers
      expect(response.content_type).to eq("application/json")
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /api/v1/applications/{token}/chats/{chat_number}/messages" do
    it "Search On Messages fail if doesnt exist" do
      headers = { "ACCEPT" => "application/json" }
      app  = Application.create(name: "anas medhat")
      chat = app.chats.create
      message  = chat.messages.create(text: "test")
      get "/api/v1/applications/" + app.token + "/chats/" + chat.chat_number.to_s + "/messages?query=anas", :headers => headers
      expect(response.content_type).to eq("application/json")
      jsons = JSON.parse(response.body)['data']['total_messages']
      expect(jsons).to eq(0)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /api/v1/applications/{token}/chats/{chat_number}/messages" do

    it "message not created because it has invalid token" do
      headers = { "ACCEPT" => "application/json" }
      post "/api/v1/applications/invalid_token/chats/1/messages", :headers => headers
      expect(response.content_type).to eq("application/json")
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "message created because it has valid token" do
      headers = { "ACCEPT" => "application/json" }
      app = Application.create(name: "anas")
      chat = app.chats.create
      expect(app).not_to be_nil  
      expect(app.save).to be_truthy
      expect(chat).not_to be_nil  

      post "/api/v1/applications/" + app.token + "/chats" + "/1" + "/messages", :params => {:text => "Hello"},:headers => headers
      expect(response.content_type).to eq("application/json")
      expect(response).to have_http_status(:ok)
    end
  end  

  



end
