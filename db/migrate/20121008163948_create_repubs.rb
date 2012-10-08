class CreateRepubs < ActiveRecord::Migration
  def change
    create_table :repubs do |t|
      t.belongs_to :reference
      t.string :content_type, limit: 8
      t.text :body
      t.timestamps
    end
    add_index :repubs, :reference_id

    add_column :references, :repubbed, :boolean, default: false
  end
end
