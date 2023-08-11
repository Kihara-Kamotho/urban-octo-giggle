class CreateCartsCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :carts_courses do |t|
      t.references :cart, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true

      t.timestamps
    end
  end
end
