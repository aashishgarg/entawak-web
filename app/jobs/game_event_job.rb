class GameEventJob < ApplicationJob
  queue_as :default

  def perform(game)
    if (game.end_at <= Time.now) && game.status
      game.completed
    else
      GameEventJob.set(wait_until: game.end_at).perform_later(game)
    end
  end
end
