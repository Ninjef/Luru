class GivePhrasesLessonId < ActiveRecord::Migration
  def change
    add_column :phrases, :lesson_id, :integer
  end
end
