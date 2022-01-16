require 'rails_helper'

RSpec.describe Message, type: :model do
    describe "Relations" do
        it { should belong_to(:chat) } 
    end

    it "Validation" do 
        should validate_presence_of(:text) 
    end
end
