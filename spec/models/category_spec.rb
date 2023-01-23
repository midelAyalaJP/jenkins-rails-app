require 'rails_helper'

RSpec.describe Category, type: :model do

    describe "Validations" do
        
        it "validate presence of required values" do
            should validate_presence_of(:spanish_description);
        end

    end
end
