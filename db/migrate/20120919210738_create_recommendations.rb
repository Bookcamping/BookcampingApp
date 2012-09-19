class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.belongs_to :user
      t.belongs_to :reference
      t.datetime :created_at
    end
    add_index :recommendations, :user_id
    add_index :recommendations, :reference_id

    add_column :references, :recommendations_count, :integer, default: 0
    add_column :users, :recommendations_count, :integer, default: 0
  end
end
