class RemoveLessonIdFromPhrases < ActiveRecord::Migration
  def change
    remove_column :phrases, :lesson_id
  end
end
