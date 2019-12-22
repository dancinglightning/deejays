class UsersController < ApplicationController
  before_action :authenticate_user! , :only => :index
  before_action :check_user , :only => [:show , :edit , :update , :destroy]

  def index
    @q = User.ransack( params[:q] )
    @q.sorts = 'full_name asc' if @q.sorts.empty?
    @user_scope = @q.result(:distinct => true)
    @users = @user_scope.paginate( :page => params[:page], :per_page => 20 )
  end

  def check_user
    if( current_user.admin)
      @user = User.where(:id => params[:id]).first
      return redirect_to( root_url, :alert => "No such user") unless @user
    else
      @user = current_user
    end
  end

  # PATCH/PUT /songs/1
  # PATCH/PUT /songs/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path , notice: 'Info successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        tag_given
      end
    end
  end

  def destroy
    admin = current_user.admin
    return redirect_to( root_url, :notice => "Done. Well done") unless admin
    if @user.destroy
      redirect_to users_url, notice: "User deleted , #{@user.full_name}."
    else
      render :edit , notice: "Error deleting, #{@user.full_name}."
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :info, :link,:city , :country , :state)
  end

end
