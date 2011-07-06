class Protein < ActiveRecord::Base
  has_many :UniprotAccessions
end
