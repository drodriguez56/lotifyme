class PicksController < ApplicationController
  before_action :require_login, except: [:create, :index, :destroy]
  before_action :join_number

  def index
    if User.find_by(email: params[:pick][:email])
      @picks = User.find_by(email: params[:pick][:email]).picks
      respond_to do |format|
          format.json { render json: ActiveSupport::JSON.encode(@picks), status:200 }
        end
    else
      respond_to do |format|
          format.json { render json: 'user not found', status:400 }
        end
    end
  end
  def create
    @user = User.find_by(email: params[:pick][:email])
    if !@user
      @user = User.create(email: params[:pick][:email], password: (0...20).map { ('a'..'z').to_a[rand(26)] }.join)
      session[:user_id] = @user.id
    end
    p '*'*100
    p pick_params
    @pick = Pick.new(pick_params)
    if @pick.save
      user_picks_before_push = @user.picks.count
      @user.picks << @pick
      user_picks_after_push = @user.picks.count
      if user_picks_before_push == user_picks_after_push
        respond_to do |format|
          format.json { render json: 'fail to create pick', status:400 }
        end
      else
        if params[:commit]=="signup"
          redirect_to edit_user_path(@user.id), locals: {email: params[:email]}
        else
          if Time.now.min - @user.created_at.time.min < 1
            @pick.send_email
            flash[:notice] = 'email sent'
          end
          respond_to do |format|
            format.json { render json: ActiveSupport::JSON.encode(@pick), status:200 }
            format.html {
              redirect_to root_path
            }
          end
        end
      end
    else
       respond_to do |format|
          format.json { render json: 'fail to create pick', status:400 }
            format.html {
              flash[:error] = 'failed to create entry.. try again'
              redirect_to root_path
            }
       end
     end
   end

   def destroy
    @pick = Pick.find(params[:id])
    if @pick
      @pick.destroy
      respond_to do |format|
          format.json { render json: 'pick destroyed', status:200 }
          format.html {
            redirect_to user_path(@pick.user)
          }
      end
    else
      respond_to do |format|
          format.json { render json: 'pick not found', status:400 }
      end
    end
   end

   private
   def join_number
    nums_array = []
    if !params[:pick]
      return nil
    else
      (1..6).each do |num|
        number = "number" + num.to_s
        if params[:pick][number]
          nums_array << params[:pick][number]
        end
      end
    end
    if !params[:pick][:number]
      params[:pick][:number] = nums_array.join(" ")
    end
   end

    def pick_params
      params.require(:pick).permit(:number, :game, :draw_date, :multiplier)
    end
 end
