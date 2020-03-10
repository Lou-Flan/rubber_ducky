class UsersController < ApplicationController
    before_action :set_profile, only: [:my_profile, :edit, :update]
    before_action :authenticate_user!

    def my_profile
    end

    def update
        if @user.update(profile_params)
            redirect_to @user
        else
         render "edit", error: "Please try again"
        end
    end

    def edit
    end

private

    def set_profile
        @user = current_user
    end

    def profile_params
        params.require(:user).permit(:bio, :avatar)
    end

end