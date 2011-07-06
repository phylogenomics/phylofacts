class CreateProteins < ActiveRecord::Migration
  def self.up
    create_table :proteins do |t|
      t.text :sequence

      t.timestamps
    end
  end

  def self.down
    drop_table :proteins
  end
end
