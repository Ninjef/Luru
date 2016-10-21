class AddLessonOrderToPhrases < ActiveRecord::Migration
  def change
    add_column :phrases, :lesson_order, :integer
  end
end
