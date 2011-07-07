class ProteinAccession < ActiveRecord::Base
  has_one :protein
  has_one :accession
end
