module GamesHelper
  def game_state_button
    @game.state ? 'Pause Game' : 'Resume'
  end
end
