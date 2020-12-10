class UsersController < ApplicationController
    def index
        if params[:query]
            render json: users = User.where('username LIKE ?', "%#{params[:query]}%")
        else
            render json: users = User.all
        end
    end

    def create
        user = User.new(user_params)
        # replace the `user_attributes_here` with the actual attribute keys
        if user.save
            render json: user
        else
            render json: user.errors.full_messages, status: :unprocessable_entity
        end
    end


    def show
        render json: User.find(params[:id])
    end

    def update
        updated_user = User.update(params[:id], user_params)
        if updated_user.update(user_params)
            render json: updated_user
        else
            render json: updated_user.errors.full_messages, status: :unprocessable_entity
        end
    end

    
    def destroy
        destroyed_user = User.destroy(params[:id])
        destroyed_user.destroy
        render json: destroyed_user
    end

    private

    def user_params
        params.require(:user).permit(:name)
    end

end 