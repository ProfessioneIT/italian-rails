require 'spec_helper'

describe User do

  def valid_attrs(merge_in = {})
    {
      :name => "Mario",
      :surname => "Rossi",
      :male => true,
      :codice_fiscale_code => "RSSMRA90A01C351Q",
      :birthdate => Date.new(1190,1,1),
      :birthplace => "Catania"
    }.merge merge_in

  end

  context "Validation" do

    it "should not validate with a non valid codice_fiscale_code" do
      test = User.new(valid_attrs({:codice_fiscale_code => "RSSMRA90A01C351P"}))
      test.should_not be_valid
      test.should have(1).error_on :codice_fiscale_code
    end
    
  end
end
