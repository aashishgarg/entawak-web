class GamesController < ApplicationController

  ########## Layouts ########################
  layout 'game_layout', except: [:introduction]

  ########## Filters ########################
  before_action :fetch_game, except: [:new, :create, :pause, :play]
  skip_before_action :authenticate_teacher!, only: [:pause, :play]

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

  def start
    @audio = Audio.all.sample(1).first
    @game.teams.each do |team|
      ActionCable.server.broadcast "team_#{team.id}", {'team' => team}
    end
  end

  def change_audio
    @audio= Audio.all.sample(1).first
  end

  def switch
    if @game.state
      ActionCable.server.broadcast "game_#{@game.id}", {'pause' => @game} if @game.update(state: false)
    else
      ActionCable.server.broadcast "game_#{@game.id}", {'play' => @game} if @game.update(state: true)
    end
  end

  def pause
    @game = Game.find_by(id: params[:id])
  end


  private

  def fetch_game
    @game = current_teacher.games.find(params[:id])
  end

end
