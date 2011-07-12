require 'bio/db/embl/sptr201107'

class Protein < ActiveRecord::Base
  has_many :accession_links
  has_many :accessions, :through => :accession_links

end
