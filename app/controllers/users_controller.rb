class UsersController < ApplicationController
  before_action :require_login, except: [:create, :new]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save && @user.authenticate(user_params[:password])
      @user.active = true; @user.save
      Notifier.welcome_email(@user).deliver
      respond_to do |format|
        format.json { render json: ActiveSupport::JSON.encode(@user), status:200, location: @user}
        format.html {
          redirect_to user_path(@user)
          session[:user_id] = @user.id
        }
      end
    else
      respond_to do |format|
        format.json { render json: 'signup failed', status:400 }
          format.html {
            render :new
            flash[:failure] = "Signup failed."
          }
      end
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Profile updated."
       respond_to do |format|
        format.json { render json: 'this', status:200 }
          format.html {
            redirect_to user_path(@user)
          }
        end
    else
      respond_to do |format|
        format.json { render nothing: true, status:400 }
          format.html {
            render :edit
            flash[:failure] = "Update unsuccessful."
          }
      end
    end
  end

  def show
  end

  def destroy
    session[:user_id] = nil
    @user.active = false; @user.save
    redirect_to root_path
  end

  private

    def user_params
         params.require(:user).permit(:username, :email, :phone, :password)
    end

end