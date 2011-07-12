require 'spec_helper'

describe Protein do
  describe '#create' do
    it 'should create a protein from a uniprot data string' do
      uniprot_string = File.read("#{Rails.root}/spec/O14727.txt")
      prot = Protein.create_from_uniprot(uniprot_string)

      prot.accessions.first.accession.should == "O14727"
      prot.accessions.length.should == 20
    end
  end

  describe '#test model linkage' do
    it 'should create a protein with one primary accession' do
      accession = UniprotAccession.new
      accession.accession = "uniprot_stuff"

      prot = Protein.new
      prot.sequence = "AAA"

      link = AccessionLink.new
      link.primary = true
      link.accession = accession

      prot.accession_links << link

      prot.save.should == true

      new_prot = Protein.find_by_sequence("AAA")

      new_prot.accessions.first.accession.should == accession.accession
      new_prot.accession_links.first.primary == true
    end

    it 'should create a protein with many secondary accessions' do
      accession_strings = ["1", "2", "3", "4", "5"]

      prot = Protein.new
      prot.sequence = "AAH"
      
      prot.append_accessions(accession_strings, UniprotAccession)
      prot.save.should == true

      new_prot = Protein.find_by_sequence("AAH")
      prot.accessions.first.accession.should == accession_strings.first
    end
  end

  it { should have_many(:accessions) }
  it { should have_many(:accession_links) }
end
