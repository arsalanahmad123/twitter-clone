class UsersController < ApplicationController
    before_action :require_user

    def show
        @user = User.find(params[:id])
    end

    def index
        @users = User.all
    end
    
    def destroy
        @user = User.find(params[:id])
        @user.destroy
        flash[:notice] = "User Account deleted successfully!!"
        redirect_to users_path
    end


    def follow
        @user = User.find(params[:id])
        Relationship.create(follower_id: current_user.id, followee_id: @user.id)
        redirect_to @user
    end


    def unfollow
        @user = User.find(params[:id])
        current_user.followed_users.where(follower_id: current_user.id, followee_id: @user.id).destroy_all
        redirect_to @user 
    end







    private

        def require_user
            if user_signed_in?
            else
                flash[:alert] = "Sorry you need to Sign in or Sign up before continuing!!!"
                redirect_to root_path
            end 
        end

end