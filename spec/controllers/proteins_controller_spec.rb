require 'spec_helper'

describe ProteinsController do
  describe "GET index" do
    it "should list all proteins" do 
      get :index
      response.should be_success
    end
  end

  describe "GET search" do
    it "should redirect to proteins_url on blank query string" do
      get :search, 'q' => ""

      response.should redirect_to proteins_path
    end
  end

  describe "GET show" do
    it "should obtain the record for the accession" do 
      get :show, :id => "A0B2E5"
      response.should be_success
    end
  end
end
