class CreateFaqs < ActiveRecord::Migration
  def self.up
    create_table :faqs do |t|
      t.string :question, :permalink, :null => false
      t.text :answer, :null => false
      t.integer :position, :null => false, :default => 1
      t.timestamps
    end
  end

  def self.down
    drop_table :faqs
  end
end
