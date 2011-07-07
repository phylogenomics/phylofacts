class CreateProteinAccessions < ActiveRecord::Migration
  def self.up
    create_table :protein_accessions, :id => false do |t|
      t.references :protein
      t.references :accession
      t.boolean :primary

      t.timestamps
    end
    add_index :protein_accessions, [:protein_id, :accession_id], { :unique => true }
  end

  def self.down
    drop_table :protein_accessions
  end
end
