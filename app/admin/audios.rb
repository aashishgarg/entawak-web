ActiveAdmin.register Audio do

  permit_params :audio, :on, :audio

  form :html => { :multipart => true } do |f|
    f.inputs "Upload" do
      f.input :audio, :type => :file
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :audio_file
     audio_tag(audio.url, autoplay: false, controls: true)
  end

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

end
