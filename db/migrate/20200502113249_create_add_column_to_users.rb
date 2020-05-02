class CreateAddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :add_column_to_users do |t|

      add_column :users, :profile_image_id, :string
      t.timestamps
    end
  end
end
