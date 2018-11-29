class AddIndexToAsfor < ActiveRecord::Migration[5.2]
  def change
    add_index :asfors, :question
    add_index :asfors, :url_key
    add_index :asfors, [:question, :answer], :name => 'unique_provider_uid', :unique => true
  end
end
