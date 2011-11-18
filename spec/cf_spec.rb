require 'spec_helper'

include ItalianRails::CodiceFiscale

=begin
  Test character:
  Mario Rossi (male)
  born in Catania on 01/01/1990

  RSS MRA 90A01 C351Q

  --------------------------------

  Another test character:
  BIANCHI GIOVANNA
  born in CATANIA on 31/03/1960

  BNC GNN 60C71 C351U

  --------------------------------

  Another test character:
  VERDI ANNA
  born in ROMA on 31/12/2010
  VRD NNA 10T71 H501E
=end

describe CF do
  context "duplicate-avoidance handling" do
    context "without check digit" do
      it "leaves intact a normal code" do
        CF.translate_duplicate_code_without_check_digit("RSSMRA90A01C351").should eql "RSSMRA90A01C351"
      end
      it "translates duplicate code into normal" do
        CF.translate_duplicate_code_without_check_digit("RSSMRAVLALMCPRM").should eql "RSSMRA90A01C351"
      end
    end

    context "with check digit" do
      it "leaves intact a normal code" do
        CF.translate_duplicate_code_without_check_digit("RSSMRA90A01C351Q").should eql "RSSMRA90A01C351"
      end
      it "translates duplicate code into normal" do
        CF.translate_duplicate_code_without_check_digit("RSSMRAVLALMCPRMX").should eql "RSSMRA90A01C351"
      end
    end

  end

  context "check digit" do
    it "should raise exception on nil input" do
      lambda { CF.check_digit(nil) }.should raise_exception(ArgumentError)
    end
    
    it "should calculate correctly the check digit" do
      CF.check_digit("RSSMRA90A01C351").should eql "Q"
    end

    it "should raise an exception if the input string is not correct" do
      lambda{ CF.check_digit("RSSMRA90A01C35D") }.should raise_exception(ArgumentError)
      lambda{ CF.check_digit("RSSMRAZ0A01C351") }.should raise_exception(ArgumentError)
    end
  end 

  context "validation" do
    it "should return false on nil input" do
      CF.valid?(nil).should be false
    end
    
    it "should return true for a valid code" do
      CF.valid?("RSSMRA90A01C351Q").should be true
    end

    it "should return false for a non-valid code" do
      CF.valid?("RSSMRM90A01C351Q").should be false
    end
  end

  context "personal data decoding" do
    it "should correctly recognize sex from a valid codice fiscale" do
      CF.male?("RSSMRA90A01C351Q").should be true
      CF.male?("BNCGNN60C71C351U").should be false
    end

    it "should correctly guess the birthdate" do
      CF.birthdate("RSSMRA90A01C351Q").should eql Date.new(1990,01,01)
      CF.birthdate("VRDNNA10T71H501E").should eql Date.new(2010,12,31)
    end

    it "should correctly find the birthplace" do
      CF.birthplace_lookup("RSSMRA90A01C351Q").should include({:provincia => "CT", :comune => "CATANIA"})
      CF.birthplace_lookup("VRDNNA10T71H501E").should include({:provincia => "RM", :comune => "ROMA"})
    end
    
    
  end

  describe "member functions" do
    newcf = CF.new("RSSMRA90A01C351Q")

    it "should validate correctly a valid instance" do
      newcf.valid?.should be true
    end

    it "should tell correctly the sex" do
      newcf.male?.should be true
      CF.new("BNCGNN60C71C351U").male?.should be false
    end
    
    it "should tell correctly the birthdate" do
      newcf.birthdate.should eql Date.new(1990,01,01)
    end
    
  end
end
