class GamesController < ApplicationController

  layout 'game_layout', except: [:introduction]

  def introduction
  end

  def new
    @secret_knock = (SecureRandom.random_number(9e5) + 1e5).to_i
  end

  def create

  end

end
