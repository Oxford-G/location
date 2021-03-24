class LocatesController < ApplicationController
  before_action :authorized
  before_action :require_session

  def index
    @locate = Locate.order('created_at DESC')
    @users = User.all.order('created_at DESC')
    @locates = Locate.new
  end

  def new
    @locates = Locate.new
  end

  def show
    @user = User.order('created_at DESC')
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

  private

  def require_session
    redirect_to root_path, alert: 'Sign Up or Sign In to access this feature!' unless current_user
  end
end
