require 'spec_helper'

describe Protein do
  describe '#create' do
    it 'should create a protein from a uniprot data string' do
      uniprot_string = File.read("#{Rails.root}/spec/O14727.txt")
      prot = Protein.new_from_uniprot(uniprot_string)

      prot.accessions.first.should == "O14727"
      prot.accessions.length.should == 20
    end
  end
end
