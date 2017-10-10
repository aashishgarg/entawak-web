class StudentsController < ApplicationController

  layout 'students', only: [:welcome, :new]
  skip_before_action :authenticate_teacher!

  def welcome
    @game = Game.where(secret_knock: params[:secret_knock]).take
    if @game.present?
      render 'new'
    end
  end

  def new

  end

  def create
  end
end
