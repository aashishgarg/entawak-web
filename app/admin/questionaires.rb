ActiveAdmin.register Questionaire do

  #============== Permitted parameters =====================
  permit_params :name, :team_id,
                :questions_attributes => [:question, :answer, :hint]

  #============== Edit/Create form =====================
  form do |f|
    f.inputs 'Questionaire' do
      f.input :name
      f.input :team_id, as: :select, collection: Team.all.collect {|team| [team.name, team.id]}
      f.has_many :questions do |p|
        p.input :question
        p.input :answer
        p.input :hint
      end
    end
    f.actions
  end

  #============== Show =====================
  show do
    attributes_table do
      row :id
      row :name
      panel "Questions" do
        table_for resource.questions do
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
    end
  end
end

