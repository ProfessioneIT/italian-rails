require 'spec_helper'

include ItalianRails::DB

describe Adapter do 
  
  it "should correctly find birthplace searching by code" do
    Adapter.instance.find_birth_places_by_code('C351').should include({:provincia => "CT", :comune => "CATANIA"})
  end

end
