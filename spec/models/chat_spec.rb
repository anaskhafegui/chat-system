require 'rails_helper'

RSpec.describe Chat, type: :model do
  describe "Relations" do
      it { should belong_to(:application) } 
  end

  it "Validation" do 
    should validate_presence_of(:application) 
  end
end
