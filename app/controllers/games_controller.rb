class GamesController < ApplicationController
  before_action :authenticate
  before_action :set_team
  before_action :if_not_admin, except: [:index, :show]

  def index
    @games = Game.where(team_id: @team.id)
  end

  def new
    @game = Game.new
    @users = User.where(team_id: @team.id)
  end

  def create
    @game = Game.create(game_params)
    @game.update(team_id: @team.id)
    unless @game.valid?
      flash.now[:alert] = @game.errors.full_messages
      render :new and return
    end
    flash[:success] = "試合を追加しました"
    users = User.where(team_id: @team.id) 
    users.each do |user|
      GamesUser.create(user_id: user.id, game_id: @game.id)
      @game.create_notification_new_game!(current_user, user.id)
    end
    redirect_to main_team_path(@team.id)
  end

  def show
    @game = Game.find(params[:id])
    @going_players = GamesUser.eager_load(:user,:game).where(game_id: @game.id, status: "yes")
    @not_going_players = GamesUser.eager_load(:user,:game).where(game_id: @game.id, status: "no")
    @notyet_players = GamesUser.eager_load(:user,:game).where(game_id: @game.id, status: "notyet")
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
    params.require(:game).permit(:opponent, :time, :date, :begin_time, :finish_time, :place)
  end
end
