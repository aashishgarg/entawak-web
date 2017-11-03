class StudentsController < ApplicationController

  ########## Layouts ########################
  layout 'students', only: [:welcome, :new]

  ########## Filters ########################
  skip_before_action :authenticate_teacher!
  skip_before_action :current_student, only: [:welcome, :new, :create, :destroy]
  before_action :set_game, only: [:new, :create]

  def welcome
  end

  def new
    unless @game
      redirect_to welcome_students_path, warning: 'Please enter valid secret knock'
    end
  end

  def create
    @student = @game&.students.build(name: params[:student][:name])
    if @student.save
      reset_session
      session[:student_id] = @student.id
      redirect_to students_path, success: "Welcome #{@student.name}"
    else
      redirect_to new_students_path, warning: @student.errors.full_messages.to_sentence
    end
  end

  def show
    cookies.signed[:game_id] = current_student.game.id
  end

  def team

  end

  def time_up
    reset_session
  end

  def destroy
    if @student.destroy
      reset_session
      ActionCable.server.broadcast "student_#{@student.id}", {destroy: @student.id}
      redirect_to active_students_game_path(@student.game), success: 'Deleted successfully'
    end
  end

  private

  def set_game
    @game = Game.where(secret_knock: params.dig(:student, :secret_knock)).take
  end


end
