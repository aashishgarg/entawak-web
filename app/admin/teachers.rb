ActiveAdmin.register Teacher do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name, :on, :teacher
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  show do
    attributes_table do
      row :id
      row :name
      panel "Games" do
        table_for resource.games do
          column "Id" do |game|
            game.id
          end
          column "Name" do |game|
            game.name
          end
          column "Created at" do |game|
            game.created_at
          end
        end
      end
    end
  end


end
