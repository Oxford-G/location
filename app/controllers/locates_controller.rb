class LocatesController < ApplicationController
  before_action :authorized

  def index
    @locate = Locate.order('created_at DESC')
    @locates = Locate.new
    @first_user = User.first
    @second_user = User.second
    @third_user = User.third
  end

  def new
    @locates = Locate.new
  end

  def show
    @user = User.order('created_at DESC')
    # @locate = @user.locates
  end

  #   # POST /users or /users.json
  def create
    current_user = User.find(session[:current_user_id])
    @locate = current_user.locates.new(text: params[:locate])

    respond_to do |format|
      if @locate.save
        format.html { redirect_to locates_path, notice: 'Idea successfully shared' }
      else
        format.html { redirect_to locates_path, alert: "can't share idea now" }
      end
    end
  end

  def idea_params
    params.require(:locate).permit(:text)
  end
end
