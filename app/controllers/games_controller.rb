class GamesController < ApplicationController

  ########## Layouts ########################
  layout 'game_layout', except: [:introduction, :dashboard, :help]

  ########## Filters ########################
  before_action :fetch_game, except: [:new, :create, :pause, :dashboard, :help,:download_pdf]
  skip_before_action :authenticate_teacher!, only: [:pause, :dashboard, :help ,:download_pdf]
  skip_before_action :current_student, except: [:pause, :game_over]

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
    if @game.end_at.nil?
      duration = params[:duration] || Game::DURATION
      @game.update(end_at: (Time.now + duration.to_i.minutes), state: true)
      GameEventJob.set(wait_until: @game.end_at).perform_later(@game)
    end
    @audio = Audio.all.sample(1).first
    @game.teams.each do |team|
      ActionCable.server.broadcast "team_#{team.id}", {'team' => team}
    end
  end

  def change_audio
    @audio= Audio.all.sample(1).first
  end

  def switch
    if @game.state && @game.update(state: false, pause_at: Time.now)
      ActionCable.server.broadcast "game_#{@game.id}", {'pause' => @game}
    else
      end_at = @game.end_at + (Time.now - @game.pause_at)
      if @game.update(state: true, end_at: end_at)
        @game.teams.each do |team|
          ActionCable.server.broadcast "team_#{team.id}", {'team' => team}
        end
      end
    end
    redirect_to start_game_path(@game)
  end

  def pause
    render layout: 'students'
  end

  def dashboard
  end

  def help
  end

  def download_pdf
    data = open("#{File.join(Rails.root, 'public','Escape Monster The Invasion Game PDF.pdf')}")
    send_data data.read, filename: "Escape Monster The Invasion Game PDF.pdf", type: "application/pdf", disposition: 'inline', stream: 'true', buffer_size: '4096'
  end

  private

  def fetch_game
    @game = current_teacher.games.find(params[:id])
  end

end
