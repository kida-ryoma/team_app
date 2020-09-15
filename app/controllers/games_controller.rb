class GamesController < ApplicationController
  before_action :set_team
  def new
    @game = Game.new
    @users = User.where(team_id: @team.id)
  end

  def create
    @game = Game.create(game_params)
    @game.update(team_id: @team.id)
    users = User.where(team_id: @team.id) 
    users.each do |user|
      @game.create_notification_new_game!(current_user, user.id)
    end
    redirect_to main_team_path(@team.id)
  end

  def show
  end

  def edit
  end

  def update
  end

  private

  def set_team
    @team = Team.find(params[:team_id])
  end

  def game_params
    params.require(:game).permit(:opponent, :time, :date, :place)
  end
end
