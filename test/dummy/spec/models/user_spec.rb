require 'spec_helper'

describe User do
  include UserSpec

  context "Validation" do
    it "should validate a valid record" do
      test = User.new(valid_attributes)
      test.should be_valid
    end

    it "should not validate with a non valid codice_fiscale_code" do
      test = User.new(valid_attributes({:codice_fiscale_code => "RSSMRA90A01C351P"}))
      test.should_not be_valid
      test.should have(1).error_on :codice_fiscale_code
    end
    
  end
end
