class CreateAccessions < ActiveRecord::Migration
  def self.up
    create_table :accessions do |t|
      t.string :type
      t.boolean :primary
      t.references :protein

      t.timestamps
    end
  end

  def self.down
    drop_table :accessions
  end
end
