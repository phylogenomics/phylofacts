class CreateAccessions < ActiveRecord::Migration
  def self.up
    create_table :accessions do |t|
      t.string :accession
      t.string :type

      t.timestamps
    end
    add_index :accessions, :accession, :unique => true
  end

  def self.down
    drop_table :accessions
  end
end
