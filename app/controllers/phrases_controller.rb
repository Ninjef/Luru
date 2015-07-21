class PhrasesController < ApplicationController

	before_action :fetch_bing_trans, only: [:index, :show]

	def index
		@phrases = Phrase.all
		@phrases_t = Hash.new
		@phrases.each do |phrase|
			@phrases_t[phrase] = @translator.translate phrase.phrase, :from => 'en', :to => 'es'
		end
	end

	def show
		#Find the phrase specified by the phrase ID parameter, as well as the image search phrase for that phrase
			phrase = Phrase.find(params[:id]).phrase
			srch_phrase = Phrase.find(params[:id]).image_search_phrase1
			if srch_phrase.blank?
				srch_phrase = phrase
			end

		#Get image search results from Bing for the image search phrase
			@results = Rails.application.config.bing.image(srch_phrase)
			@phrase_t = @translator.translate phrase, :from => 'en', :to => params[:lang]

		#Save the audio file of this phrase being spoken so it can be called on webpage
		#If the file already exists, no need to download it
			if File.exist?("/audio/"+@phrase_t.downcase.tr(' ','_')+".mp3") == false
				pronounce = @translator.speak @phrase_t, :language => params[:lang], :format => 'audio/mp3', :options => 'MaxQuality'
				@writepath = "/Users/taylordusting/Luru/public/audio/"+@phrase_t.downcase.tr(' ','_')+".mp3"
				open(@writepath, 'wb') { |f| f.write pronounce }
			end
			@writepath = "/audio/"+@phrase_t.downcase.tr(' ','_')+".mp3"

		#Set up "Next" and "Previous" buttons to route to the next phrase in the database
		#Error handler keeps this from crashing when there is no next or previous phrase in the database
		#**Need to eventually make this select the next phrase in the current lesson
			begin
				@next = Phrase.where("id > ?", params[:id]).first.id
			rescue
			end
			begin
				@previous = Phrase.where("id < ?", params[:id]).last.id
			rescue
			end

		#This case selection allows me to set the text of the select box to the text of the language dropdown to the full name of the language
			case params[:lang]
			when 'en'
				@language = "English"
			when 'fr'
				@language = "Francais - French"
			when 'de'
				@language = "Deutsch - German"
			when 'es'
				@language = "Espanol - Spanish"
			when 'fi'
				@language = "Suomi - Finnish"			
			when 'ja'
				@language = "日本人 - Japanese"
			end

	end

	def typing_quiz
		
	end

	def fetch_bing_trans
		@translator = Rails.application.config.translator
	end
end