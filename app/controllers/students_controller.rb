class StudentsController < ApplicationController

  ########## Layouts ########################
  layout 'students', only: [:welcome, :new]

  ########## Filters ########################
  skip_before_action :authenticate_teacher!
  before_action :set_game, only: [:new, :create]

  def welcome
  end

  def new
    unless @game
      redirect_to welcome_students_path, notice: 'Please enter valid secret knock'
    end
  end

  def create
    @student = @game.students.build(name: params[:student][:name])
    if @student.save
      redirect_to student_path(@student), notice: "Welcome #{@student.name}"
    else
      redirect_to new_student_path
    end
  end

  def show

  end

  def destroy
    student = Student.find_by(id: params[:id])
    if student.destroy
      redirect_to active_students_game_path(student.game), notice: 'Deleted successfully'
    end
  end

  private
  def set_game
    @game = Game.where(secret_knock: params[:student][:secret_knock]).take
  end
end
