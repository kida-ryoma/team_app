class UsersController < ApplicationController
  before_action :set_team
  before_action :set_games_users
  before_action :authenticate

  def show
    @going_games = GamesUser.includes(:game).where('user_id = ? and status_id = ?', current_user.id, 2)
  end


  private

  def set_team
    @team = Team.find(current_user.team_id)
  end

  def set_games_users
    @notyet_games = GamesUser.includes(:game).where('user_id = ? and status_id = ?', current_user.id, 1)
  end

end
