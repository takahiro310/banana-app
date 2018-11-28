class AddImageToAsfor < ActiveRecord::Migration[5.2]
  def change
    add_column :asfors, :image, :string
  end
end
