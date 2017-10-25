class GamesController < ApplicationController

  layout 'game_layout'
  before_action :fetch_game, only: [:update, :active_students, :team_assigmnent, :start, :change_audio, :introduction]
  before_action :pick_random_song, only: [:start, :change_audio]

  def introduction
  end

  def new
    @game = current_teacher.games.create
  end

  def create

  end

  def update
    if @game.update(missing_devices: params[:game][:missing_devices])
      redirect_to active_students_game_path(@game)
    else
      redirect_to :back
    end
  end

  def show

  end

  def active_students
    cookies.signed[:teacher_id] = current_teacher.id
  end

  def team_assigmnent
    @game.assign_team_and_students
  end

  def start

  end

  def change_audio
    render 'start'
  end

  private

  def fetch_game
    @game = current_teacher.games.find(params[:id])
  end

  def pick_random_song
    @audio = Audio.all.sample(1).first
  end

end
