require 'spec_helper'

describe Accession do
  it "should create a new accession" do 
    accession = Accession.new(:accession => "P12345")
    accession.save
    Accession.first.accession.should == "P12345"
  end

  it "should require the presence of the accession string" do
    accession = Accession.new
    lambda {accession.save!}.should raise_error(ActiveRecord::RecordInvalid)
  end
end
