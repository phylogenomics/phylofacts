require 'bio/db/embl/sptr201107'

class Protein
  @@per_page = 20
  cattr_reader :per_page

  include Tire::Model::Persistence
  include Tire::Model::Search
  include Tire::Model::Callbacks

  property :id
  property :entry_status
  property :sequence
  property :sequence_length
  property :protein_name
  property :organism
  property :accessions
  property :synonyms
  property :entry_id
  property :ncbi_taxonomy_id
  property :keywords
  property :comments
  property :go
  property :pfam

  def self.new_from_uniprot(uniprot_string)
    uniprot_data = Bio::SPTR201107.new(uniprot_string)
    
    prot = Protein.new

    prot.id               = uniprot_data.accession
    prot.entry_status     = uniprot_data.id_line["DATA_CLASS"]
    prot.protein_name     = uniprot_data.protein_name
    prot.sequence         = uniprot_data.seq
    prot.sequence_length  = uniprot_data.sequence_length
    prot.accessions       = uniprot_data.accessions
    prot.synonyms         = uniprot_data.synonyms
    prot.entry_id         = uniprot_data.entry_id
    prot.keywords         = uniprot_data.keywords
    prot.ncbi_taxonomy_id = uniprot_data.ox['NCBI_TaxID'][0] if uniprot_data.ox.has_key? 'NCBI_TaxID'
    prot.comments         = uniprot_data.cc

    if uniprot_data.os.length >= 1
      organism = {}
      if uniprot_data.os[0].has_key? "os"
        organism[:scientific_name] = uniprot_data.os[0]["os"]
      end

      if uniprot_data.os[0].has_key? "name" && !uniprot_data.os[0]["name"].nil?
        organism[:common_name] = uniprot_data.os[0]["name"].gsub(/[\)\(]/, '')
      end
      prot.organism = organism
    end

    if uniprot_data.dr.has_key? "GO"
      prot.go = uniprot_data.dr["GO"].inject([]) do |array, go_ref|
        array << {:id => go_ref[0], :term => go_ref[1], :evidence => go_ref[2]}
      end
    end

    if uniprot_data.dr.has_key? "Pfam"
      prot.pfam = uniprot_data.dr["Pfam"].inject([]) do |array, pfam_ref|
        array << {:id => pfam_ref[0], :entry_name => pfam_ref[1], :match_status => pfam_ref[2]}
      end
    end

    prot
  end

  def self.create_from_uniprot(uniprot_string)
    prot = Protein.new_from_uniprot(uniprot_string)
    prot.save
    prot
  end
end
