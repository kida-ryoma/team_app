class GamesUsersController < ApplicationController
  before_action :set_team
  before_action :set_game
  before_action :set_games_user
  before_action :authenticate_user!


  def edit
  end

  def update
    @games_user.update(status: "yes")
    redirect_to main_team_path(@team.id)

  end

  def update_no
    @games_user.update(status: "no")
    redirect_to main_team_path(@team.id)
  end

  private
  def set_game
    @game = Game.find(params[:game_id])
  end

  def set_team
    @team = Team.find(params[:team_id])
  end

  def set_games_user
    @games_user = GamesUser.find(params[:id])
  end
end
