class Audio < ApplicationRecord

  #============== Paperclip configs =============
  has_attached_file :audio

  #============== Validations ===================
  validates_attachment_content_type :audio,
                                    :content_type => ['audio/mpeg', 'audio/x-mpeg', 'audio/mp3', 'audio/x-mp3', 'audio/mpeg3', 'audio/x-mpeg3', 'audio/mpg', 'audio/x-mpg', 'audio/x-mpegaudio'],
                                    :processors => [:ffmpeg]
end
