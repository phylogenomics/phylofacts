class DeleteProteins < ActiveRecord::Migration
  def self.up
    drop_table :proteins
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
