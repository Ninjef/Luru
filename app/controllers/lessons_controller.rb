class LessonsController < ApplicationController
  def index
    @lessons = Lesson.all
  end
  def show
    @lesson = Lesson.find(params[:id])
    @first_phrase = @lesson.phrases.first
  end
end
