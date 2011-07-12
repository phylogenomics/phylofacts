class Accession < ActiveRecord::Base
  has_many :accession_links
  has_many :proteins, :through => :accession_links

  validates :accession, :presence => true, :uniqueness => true
end
