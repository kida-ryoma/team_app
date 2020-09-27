class GamesUsersController < ApplicationController
  before_action :set_team
  before_action :set_game
  before_action :set_games_user
  before_action :authenticate


  def edit
  end

  def update
    @games_user.update(status: "yes")
    unless @games_user.valid?
      flash.now[:alert] = @games_user.errors.full_messages
      render 'users/show' and return
    end
    redirect_to user_path(current_user.id)
  end

  def update_no
    @games_user.update(status: "no")
    unless @games_user.valid?
      flash.now[:alert] = @games_user.errors.full_messages
      render 'users/show' and return
    end
    redirect_to user_path(current_user.id)
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
