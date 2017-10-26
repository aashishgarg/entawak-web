class GamesController < ApplicationController

  ########## Layouts ########################
  layout 'game_layout', except: [:introduction]

  ########## Filters ########################
  before_action :fetch_game, except: [:new, :create]
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
    cookies.signed[:game_id] = @game.id
  end

  def team_assigmnent
    @game.assign_team_and_students
    @game.broadcast_team
  end

  def start

  end

  def change_audio
    render 'start'
  end

  def switch
    if @game.state
      @game.update(state: false)
      puts "55555555555555555555555555555555555555555"
    else
      @game.update(state: true)
      puts "2222222222222222222222222222222222222222"
    end
  end

  private

  def fetch_game
    @game = current_teacher.games.find(params[:id])
  end

  def pick_random_song
    @audio = Audio.all.sample(1).first
  end

end
