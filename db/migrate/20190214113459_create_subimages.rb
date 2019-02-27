class CreateSubimages < ActiveRecord::Migration[5.0]
  def change
    create_table :subimages do |t|
      t.string :sub_image
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
