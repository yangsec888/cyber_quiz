#--
# cyber_quiz
#
# A  Ruby application for enterprise online quiz management solution
#
# Developed by Yang Li, Kainan Zhang. Creative Common License
#
#++

class UsersController < ApplicationController
  respond_to :html, :json
  before_action :authenticate_user!
  #before_action :admin_only
  helper_method :sort_column, :sort_direction

  def new
  end

  def index
    @users = User.order(sort_column + " " + sort_direction)
    dept = Hash.new; @users.map {|a| dept[a.department]=true unless dept.key?(a.department) }
    filtering_params(params).each do |key, value|
      next if value.nil?
      @users = @users.public_send(key, value) if value.present?
    end
  end

  def show
    @user = User.find(params[:id])
    unless current_user.admin?
      unless @user == current_user
        redirect_to :back, :alert => "Access denied."
      end
    end
  end

  def update
    @user = User.find(params[:id])
    # add the following line to bypass password validations requirement in Rails 4.2
    @user.password = "!@#$%^&*----"
    #render plain: secure_params.inspect
    @user.update!(secure_params)
    respond_to do |format|
      format.html { redirect_to users_path, :notice => "User updated successfully." }
      format.js { flash[:notice] = "User updated successfully"}
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to :back
  end

  private

  def filtering_params(params)
    params.slice(:department)
  end

  def secure_params
    params.require(:user).permit(:role)
  end

  def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "username"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end


end
