require 'spec_helper'

describe Accession do
  describe "#create" do
    it "should create a new accession" do 
      accession = Accession.new(:accession => "P12345")
      accession.save
      Accession.first.accession.should == "P12345"
    end

    it "should require the presence of the accession string" do
      accession = Accession.new
      lambda {accession.save!}.should raise_error(ActiveRecord::RecordInvalid)
    end

    it "should not accept an empty string as a valid accession" do
      accession = Accession.new(:accession => " ")
      lambda {accession.save!}.should raise_error(ActiveRecord::RecordInvalid)
    end

    it "should require the accession string to be unique" do
      Accession.create(:accession => "P12345")
      lambda {
        Accession.create!(:accession => "P12345")
      }.should raise_error(ActiveRecord::RecordInvalid, "Validation failed: Accession has already been taken")
    end
  end
end
