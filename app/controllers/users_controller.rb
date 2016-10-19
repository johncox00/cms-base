class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :admin_only, :except => :show
  load_and_authorize_resource
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to users_path, :alert => "Access denied."
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def update_roles
    @user = User.find(params[:id])
    secure_params[:roles].each do |role|
      role[:action] == "add" ? @user.role_list.add(role[:role]) : @user.role_list.remove(role[:role])
      @user.save
    end
    respond_to do |format|
      format.json{render json: @user}
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def admin_only
    unless current_user.admin?
      redirect_to :back, :alert => "Access denied."
    end
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end

  def secure_params
    params.require(:user).permit(:roles => [:role, :action])
  end

end
