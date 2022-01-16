require 'rails_helper'


  RSpec.describe Application, type: :model do
    # Association test
    it { should have_many(:chats) }
    # Validation tests
    it { should validate_presence_of(:name) }
 
   end
  # test "the truth" do
  #   assert true