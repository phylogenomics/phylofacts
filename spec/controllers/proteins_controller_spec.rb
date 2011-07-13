require 'spec_helper'

describe ProteinsController do
  describe "GET index" do
    it "should list all accessions" do 
      get :index
      response.should be_success
    end
  end

  describe "GET show" do
    it "should obtain the record for the accession" do 
      #get :show, :id => "garbage"
      #response.should be_success
      pending "create all the stubs to make this test work"
    end
  end
end
