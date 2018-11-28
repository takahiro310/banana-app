class CreateAsfors < ActiveRecord::Migration[5.2]
  def change
    create_table :asfors do |t|
      t.string :question
      t.string :answer

      t.timestamps
    end
  end
end
