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

  def index
    @users = User.order(sort_column + " " + sort_direction)
    dept = Hash.new; @users.map {|a| dept[a.department]=true unless dept.key?(a.department) }
    @department_list = Array.new; dept.each {|key,val| @department_list.push(key) unless key.nil? }
    @department_list.sort!
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

  def report
    # Respond to the Download request
      index
      wb = RubyXL::Workbook.new
      download = wb.worksheets[0]
      download.sheet_name = 'Quiz User Report'
      # set the header row
      download.add_cell(0,0, "Name")
      download.add_cell(0,1, "Email")
      download.add_cell(0,2, "Department")
      download.add_cell(0,3, "Role")
      # fill the rest of the rows
      my_row=0
      @users.each do |aa|
          my_row += 1
          next if aa.nil?
          download.add_cell(my_row,0, aa['username'].titleize)
          download.add_cell(my_row,1, aa['email'])
          download.add_cell(my_row,2, aa['department'])
          download.add_cell(my_row,3, aa['role'])
          unless aa['equinix_id'].nil?
            download.add_cell(my_row,5, "Yes")
          end
      end
      send_data wb.stream.string, filename: "Quiz_User.xlsx", disposition: 'attachment'
      wb = nil

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
