class ArtworkSharesController < ApplicationController

    # def index
    #     render json: ArtworkShare.all
    # end

    def create
        artwork_shares = ArtworkShare.new(artwork_share_params)
        if artwork_shares.save
            render json: artwork_shares
        else
            render json: artwork_shares.errors.full_messages, status: :unprocessable_entity
        end
    end


    # def show
    #     render json: ArtworkShare.find(params[:id])
    # end

    # def update
    #     updated_artwork_shares = ArtworkShare.update(params[:id], artwork_share_params)
    #     if updated_artwork_shares.update(artwork_share_params)
    #         render json: updated_artwork_shares
    #     else
    #         render json: updated_artwork_shares.errors.full_messages, status: :unprocessable_entity
    #     end
    # end

    
    def destroy
        destroyed_artwork_shares = ArtworkShare.destroy(params[:id])
        destroyed_artwork_shares.destroy
        render json: destroyed_artwork_shares
    end

    private

    def artwork_share_params
        params.require(:artwork_shares).permit(:artwork_id, :viewer_id)
    end


end