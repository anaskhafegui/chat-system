require 'rails_helper'

RSpec.describe Application, type: :model do
    
    describe "Relations" do
        it { should have_many(:chats) }  
    end

    it "Validation" do 
        should validate_presence_of(:name) 
    end

    
    app = Application.new(name: "Anas")
    it "is valid with valid attributes" do
      expect(app).to be_valid
    end
  
    it "is not valid without a name" do
      app.name = nil
      expect(app).to_not be_valid
    end
  
    it "is not valid without a token" do
      app.token = nil
      expect(app).to_not be_valid
    end

    
    it "is not valid without a chats_count" do
      app.chats_count = nil
      expect(app).to_not be_valid
    end

end
