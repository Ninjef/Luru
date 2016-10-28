class LessonsController < ApplicationController
  def index
    @lessons = Lesson.all
  end
  def show
    @lesson = Lesson.find(params[:id])
    @language = current_user.target_language
    @first_phrase = @lesson.phrases.first
  end
end
