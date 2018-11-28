class AddUrlKeyToAsfor < ActiveRecord::Migration[5.2]
  def change
    add_column :asfors, :url_key, :string
  end
end
