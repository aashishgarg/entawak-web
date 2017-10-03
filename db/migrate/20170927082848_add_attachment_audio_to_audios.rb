class AddAttachmentAudioToAudios < ActiveRecord::Migration
  def self.up
    change_table :audios do |t|
      t.attachment :audio
    end
  end

  def self.down
    remove_attachment :audios, :audio
  end
end
