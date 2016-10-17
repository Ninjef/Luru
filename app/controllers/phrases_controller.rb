class PhrasesController < ApplicationController

	before_action :fetch_bing_trans, only: [:index, :show]
	# helper_method :audio_path

	def index
		@phrases = Phrase.all
		@phrases_t = Hash.new
		@phrases.each do |phrase|
			@phrases_t[phrase] = @translator.translate phrase.phrase, :from => 'en', :to => 'es'
		end
	end

	def show
	#Find the phrase specified by the phrase ID parameter, as well as the image search phrase for that phrase
		phrase_text = Phrase.find(params[:id]).text
		image_search_text = Phrase.find(params[:id]).image_search_text

	#Get image search results from Bing for the image search phrase
		@results = Rails.application.config.bing.image(image_search_text)
		@translated_phrase_text = @translator.translate phrase_text, :from => 'en', :to => params[:lang]

	# Save the audio file of this phrase being spoken so it can be called on webpage
	# If the file already exists, no need to download it
		@audio_file = "#{@translated_phrase_text.downcase.tr(' ','_')}_#{params[:lang]}.mp3"
		audio_path = "/app/assets/audios/#{@audio_file}"
		writepath = "#{Rails.root}#{audio_path}"
		unless File.exist?(writepath)
			audio_data = @translator.speak @translated_phrase_text, :language => params[:lang], :format => 'audio/mp3', :options => 'MaxQuality'
			File.open(writepath, 'wb') { |f| f.write audio_data }
		end

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

	# def audio_path

	# end

	def typing_quiz
		
	end

	def fetch_bing_trans
		@translator = Rails.application.config.translator
	end
end

