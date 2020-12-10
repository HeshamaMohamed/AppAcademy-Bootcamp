class CommentsController < ApplicationController


    def index
        user = params[:user_id]
        artwork = params[:artwork_id]
        if user 
            render json: User.find(user).comments
        elsif artwork
            render json: Artwork.find(artwork).comments
        else
            render json: Comment.all
        end
    end

    def create
        comment = Comment.new(artwork_share_params)
        if comment.save
            render json: comment
        else
            render json: comment.errors.full_messages, status: :unprocessable_entity
        end
    end


    def destroy
        destroyed_comment = Comment.destroy(params[:id])
        destroyed_comment.destroy
        render json: destroyed_comment
    end


    private

    def comment_params
        params.require(:comments).permit(:body, :user_id, :artwork_id)
    end
    
end