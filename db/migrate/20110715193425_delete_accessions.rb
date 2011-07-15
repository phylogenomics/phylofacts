class DeleteAccessions < ActiveRecord::Migration
  def self.up
    drop_table :accessions
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
