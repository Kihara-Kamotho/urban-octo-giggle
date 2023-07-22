class RemoveCourseFromLessons < ActiveRecord::Migration[7.0]
  def change
    remove_column :lessons, :lesson_id, :integer
    remove_column :lessons, :course_id, :integer
  end
end
