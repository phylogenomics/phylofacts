require 'bio/db/embl/sptr201107'

class Protein < ActiveRecord::Base
  has_one :primary_accession, :through => :accession_links, :conditions => ['"accession_links"."primary" = ?', true], :source => :accession
  has_many :accession_links
  has_many :accessions, :through => :accession_links

  def to_param
    primary_accession.accession
  end

  def self.from_param(param)
    find_by_primary_accession(param)
  end

  def self.find_by_primary_accession(accession)
    accession = Accession.find_by_accession(accession)
    raise ActiveRecord::RecordNotFound if accession.nil?
    al = accession.accession_links.find(:first, :conditions => {:primary => true})
    raise ActiveRecord::RecordNotFound if al.nil? || al.protein.nil?
    al.protein
  end

  def append_accessions(accessions, type)
    self.accessions << accessions.each.inject([]) do |array, ac_string|
      array << type.new(:accession => ac_string)
    end
  end

  def self.create_from_uniprot(uniprot_string)
    uniprot_data = Bio::SPTR201107.new(uniprot_string)
    
    prot = Protein.new
    prot.sequence = uniprot_data.seq
    
    link = AccessionLink.new
    link.primary = true
    link.accession = UniprotAccession.new(:accession => uniprot_data.accession)

    prot.accession_links << link

    prot.save

    non_primary_accessions = uniprot_data.accessions - [uniprot_data.accession]
    unless non_primary_accessions.empty?
      prot.append_accessions(non_primary_accessions, UniprotAccession)
      prot.save
    end

    return prot
  end
end
