class DeleteAccessionLinks < ActiveRecord::Migration
  def self.up
    drop_table :accession_links
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
