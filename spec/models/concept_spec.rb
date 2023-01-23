require 'rails_helper'

RSpec.describe Concept, type: :model do

    describe "Validations" do
        
        it "validate presence of required values" do
            should validate_presence_of(:spanish_description);
            should validate_presence_of(:category_id);
        end

    end
end
