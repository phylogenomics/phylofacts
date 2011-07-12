class RenameProteinAccessionsToAccessionLinks < ActiveRecord::Migration
  def self.up
    rename_table :protein_accessions, :accession_links
  end

  def self.down
    rename_table :accession_links, :protein_accessions
  end
end
