class UsersController < ApplicationController
  before_action :set_team
  before_action :set_games_users
  before_action :authenticate

  def show
  end


  private

  def set_team
    @team = Team.find(current_user.team_id)
  end

  def set_games_users
    @games_users = GamesUser.includes(:game).where('user_id = ? and status = ?', current_user.id, 'notyet')
  end

end
