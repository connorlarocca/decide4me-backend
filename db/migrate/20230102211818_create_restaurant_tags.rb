class CreateRestaurantTags < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurant_tags do |t|

      t.timestamps
    end
  end
end
