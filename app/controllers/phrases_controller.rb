class PhrasesController < ApplicationController

	def index
		@phrases = Phrase.all
	end

	def show
		@lesson = Lesson.find(params[:lesson_id])
		@phrase = Phrase.find(params[:id])
		@language = Language.find(params[:language_id])
	#Get image search results from Bing for the image search phrase
		@image_search_results = image_search(@phrase.text, 4)
		@translated_phrase_text = translate(@phrase.text, @language.code)
		@audio_file = fetch_audio(@translated_phrase_text, @language.code)
	#Set up "Next" and "Previous" buttons to route to the next phrase in the database
	#Error handler keeps this from crashing when there is no next or previous phrase in the database
	#**Need to eventually make this select the next phrase in the current lesson
			
		@next_phrase = @phrase.next_in_lesson
		@previous_phrase = @phrase.previous_in_lesson
	end
end

