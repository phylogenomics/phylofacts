class Protein < ActiveRecord::Base
  has_many :protein_accessions
  has_many :accessions, :through => :protein_accessions
end
