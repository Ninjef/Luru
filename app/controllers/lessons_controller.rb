class LessonsController < ApplicationController
  def index
    @lessons = Lesson.all
  end
  def show
    @lesson = Lesson.find(params[:id])
    @language = Language.find_by_name("English")
    @first_phrase = @lesson.phrases.first
  end
end
