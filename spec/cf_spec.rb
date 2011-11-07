require 'spec_helper'

include CodiceFiscale

=begin
  Test character:
  Mario Rossi (male)
  born in Catania on 01/01/1990

  RSS MRA 90A01 C351Q
=end

describe CF do
  context "duplicates" do
    it "leaves a normal" do
      CF.translate_duplicate_code_without_check_digit("RSSMRA90A01C351").should eql "RSSMRA90A01C351"
    end
    it "translates duplicate code into normal" do
      CF.translate_duplicate_code_without_check_digit("RSSMRAVLALMCPRM").should eql "RSSMRA90A01C351"
    end
  end

  context "check digit" do
    it "should calculate correctly the check digit" do
      CF.check_digit("RSSMRA90A01C351").should eql "Q"
    end

    it "should raise an exception if the input string is not correct" do
      lambda{ CF.check_digit("RSSMRA90A01C35D") }.should raise_exception(ArgumentError)
      lambda{ CF.check_digit("RSSMRAZ0A01C351") }.should raise_exception(ArgumentError)
    end
  end 

  context "validation" do
    it "should return true for a valid code" do
      CF.valid?("RSSMRA90A01C351Q").should be true
    end

    it "should return false for a non-valid code" do
      CF.valid?("RSSMRM90A01C351Q").should be false
    end
  end
end
