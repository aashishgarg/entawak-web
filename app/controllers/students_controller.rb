class StudentsController < ApplicationController

  ########## Layouts ########################
  layout 'students', only: [:welcome, :new]

  ########## Filters ########################
  skip_before_action :authenticate_teacher!
  before_action :set_game, only: [:new, :create]
  before_action :set_student, only: [:show, :destroy, :team]

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
      session[:student_id] = @student.id
      redirect_to student_path(@student), notice: "Welcome #{@student.name}"
    else
      redirect_to new_student_path
    end
  end

  def show
    cookies.signed[:game_id] = @student.game.id
  end

  def team

  end

  def destroy
    if @student.destroy
      session[:student_id] = nil
      redirect_to active_students_game_path(@student.game), notice: 'Deleted successfully'
    end
  end

  private

  def set_game
    @game = Game.where(secret_knock: params[:student][:secret_knock]).take
  end

  def set_student
    @student = Student.find_by(id: params[:id])
  end

end
