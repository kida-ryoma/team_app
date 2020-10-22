class GameResultsController < ApplicationController
  before_action :set_game
  before_action :set_team

  def new
    @game_result = GameResult.new(game_id: @game.id)
    @game_result.game_scorers.build
  end

  def create
    @game_result = GameResult.create!(game_result_params)
    redirect_to team_game_path(@team.id, @game.id)
  end

  private

  def set_team
    @team = Team.find(params[:team_id])
  end

  def set_game
    @game = Game.find(params[:id])
  end

  def game_result_params
    params.require(:game_result).permit(
      :my_score,
      :rival_score,
      game_scorers_attributes:[:user_id]
    ).merge(game_id: params[:id])
  end
end
