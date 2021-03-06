class UsersController < ApplicationController
  before_action :require_session, only: %i[show edit update destroy]
  skip_before_action :authorized, only: %i[new create]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
    @user = User.find(params[:id])
    @locate = @user.locates
    @user_followed_by = @user.followers
  end

  def follow_users; end

  # GET /users/new
  def new
    @user = User.new
  end

  def sign_in; end

  def recovery; end

  def _get_username
    @user = User.find_by(email: params[:email])
    if @user
      flash[:alert] = @user.username
      redirect_to recovery_path
      return
    end
    flash[:alert] = 'User not found'
    redirect_to recovery_path
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        session[:current_user_id] = @user.id
        session[:user_name] = @user.fullname
        format.html { redirect_to locates_path, notice: 'Welcome! You have signed up successfully.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def require_session
    redirect_to root_path, alert: 'Sign Up or Log In to access this feature!' unless current_user
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :fullname, :photo, :cover_image, :email)
  end
end
