require 'spec_helper'

describe Protein do
  describe '#test model linkage' do
    it 'should create a protein with one primary uniprot accession' do
      accession = UniprotAccession.new
      accession.accession = "uniprot_stuff"

      prot = Protein.new
      prot.sequence = "AAA"

      link = AccessionLink.new
      link.primary = true
      link.accession = accession

      prot.save.should == true
    end

    it 'should create a protein with many uniprot accessions' do
      accession_strings = ["1", "2", "3", "4", "5"]

      prot = Protein.new
      prot.sequence = "AAH"
      
      u_accessions = accession_strings.inject([]) do |array, ac_string|
        array << UniprotAccession.new(:accession => ac_string)
        array
      end

      prot.accessions = u_accessions
      prot.save.should == true

      new_prot = Protein.find_by_sequence("AAH")
      prot.accessions.first.accession.should == accession_strings.first
    end
  end
  it { should have_many(:accessions) }
  it { should have_many(:accession_links) }
end
