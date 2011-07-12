class AccessionLink < ActiveRecord::Base
  belongs_to :protein
  belongs_to :accession
end
