 class PicksController < ApplicationController
  
   def new
     @pick = Pick.new
   end

   def create
     @user = User.find_by(email: params[:pick][:email])
     if !@user
        @user = User.create(email: params[:pick][:email], password: (0...20).map { ('a'..'z').to_a[rand(26)] }.join)
     end
     @pick = Pick.new(pick_params)
     if @pick.save 
       @user.picks << @pick
       if params[:commit]=="signup"
         redirect_to edit_user_path(@user), locals: {email: params[:email]}
       else
         redirect_to root_path
       end
     else
       render text: 'faild'
     end
   end

   private

    def pick_params
      params.require(:pick).permit(:number, :game, :draw_date, :multiplier)
    end
 end