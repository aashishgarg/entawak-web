class AddAttachmentAudioToAudios < ActiveRecord::Migration[5.1]
  def self.up
    change_table :audios do |t|
      t.attachment :audio, after: :url
    end
  end

  def self.down
    remove_attachment :audios, :audio
  end
end
