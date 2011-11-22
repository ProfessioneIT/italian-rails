require 'spec_helper'

include ItalianRails::DB

describe Adapter do 
  
  it "should correctly find birthplace searching by code" do
    result = Adapter.instance.find_birth_places_by_code('C351')
    result.should be_an_instance_of(Array)
    result.should_not be_empty
    result[0].should be_a_kind_of(Hash)
    result[0].should eql({:provincia => "CT", :comune => "CATANIA"})
  end

  it "should correctly find cities by cap" do
    result = Adapter.instance.find_cities_by_cap('95018')
    result.should be_an_instance_of(Array)
    result.should_not be_empty
    result.should include({:provincia => 'CT', :comune => 'RIPOSTO', :frazione => ''})
    result.should include({:provincia => 'CT', :comune => 'RIPOSTO', :frazione => 'TORRE ARCHIRAFI'})
  end

  it "should correctly find places by prov" do
    result = Adapter.instance.find_places_by_prov('CT')
    result.should be_an_instance_of(Array)
    result.should_not be_empty
    result.should include({:comune => 'RIPOSTO', :frazione => '', :cap => '95018'})
    result.should include({:comune => 'RIPOSTO', :frazione => 'TORRE ARCHIRAFI', :cap => '95018'})
  end

end
