class StudentsController < ApplicationController

  layout 'students', only: [:welcome, :new]
  skip_before_action :authenticate_teacher!
  before_action :set_game

  def welcome
  end

  def new
  end

  def create
    @student = @game.students.build(name: params[:student][:name])
    if @student.save

    else
      redirect_to new_student_path
    end
  end

  private
  def set_game
    @game = Game.where(secret_knock: params[:student][:secret_knock]).take
  end
end
