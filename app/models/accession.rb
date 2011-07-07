class Accession < ActiveRecord::Base
  has_many :protein_accessions
  has_many :proteins, :through => :protein_accessions
end
