class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :authenticate_user!
  protect_from_forgery with: :exception

  def translate(text, target_language)
    Rails.application.config.translator.translate text,
                                                  :from => 'en',
                                                  :to => target_language
  end

  def image_search(text, limit=4)
    Rails.application.config.bing.image text, 
                                        limit: limit
  end

  def fetch_audio(text, target_language)
  # Save the audio file of this phrase being spoken so it can be called on webpage
  # If the file already exists, no need to download it
    audio_file = "#{text.downcase.tr(' ','_')}_#{target_language}.mp3"
    audio_path = "/app/assets/audios/#{audio_file}"
    writepath = "#{Rails.root}#{audio_path}"
    unless File.exist?(writepath)
      audio_data = Rails.application.config.translator.speak text,
                                                             :language => target_language, 
                                                             :format => 'audio/mp3', 
                                                             :options => 'MaxQuality'
      File.open(writepath, 'wb') { |f| f.write audio_data }
    end
    return audio_file
  end
end
