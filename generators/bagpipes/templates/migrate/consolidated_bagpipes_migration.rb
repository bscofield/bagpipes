class ConsolidatedBagpipesMigration < ActiveRecord::Migration
  def self.up
    create_table :members do |t|
      t.string   :name
      t.boolean  :administrator, :default => false
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :user_id,                          :null => false
      t.string   :user_type,                        :null => false
    end

    create_table :messages do |t|
      t.integer  :topic_id
      t.integer  :parent_id
      t.string   :title
      t.text     :content
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :member_id
    end

    add_index :messages, [:topic_id], :name => :index_messages_on_topic_id
    add_index :messages, [:parent_id], :name => :index_messages_on_parent_id

    create_table :topics do |t|
      t.string   :title
      t.text     :description
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
  
  def self.down
    drop_table :messages
    drop_table :members
    drop_table :topics
  end
end