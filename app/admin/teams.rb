ActiveAdmin.register Team do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :game_id, :name, :on, :team
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end
#
  show do
    attributes_table do
      row :id
      row :name
      panel "Game" do
        table_for resource.game do
          column "Id" do |game|
            game.id
          end
          column "Name" do |game|
            game.name
          end
        end
      end

      panel "Students" do
        table_for resource.students do
          column "Id" do |game|
            game.id
          end
          column "Name" do |game|
            game.name
          end
        end
      end if resource.students.present?


      panel "Questionaire" do
        table_for resource.questionaire.questions do
          resource.questionaire.questions.each do |question|
            column "Question" do |question|
              question.question
            end
            column "Answer" do |question|
              question.answer
            end
            column "Hint" do |question|
              question.hint
            end
          end

        end
      end if resource.questionaire.present?
    end
  end

end
