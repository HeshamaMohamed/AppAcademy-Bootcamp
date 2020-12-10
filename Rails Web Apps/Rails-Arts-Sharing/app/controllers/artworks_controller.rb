class ArtworksController < ApplicationController

    def index
        if params[:user_id]
            user = User.find(params[:user_id])
            render json:{"User Artworks" => user.artworks,
                        "User's Shared Artworks" => user.shared_artworks
                        }
        end  
    end

    def create
        artwork = Artwork.new(artwork_params)
        if artwork.save
            render json: artwork
        else
            render json: artwork.errors.full_messages, status: :unprocessable_entity
        end
    end


    def show
        render json: Artwork.find(params[:id])
    end

    def update
        updated_artwork = Artwork.update(params[:id], artwork_params)
        if updated_artwork.update(artwork_params)
            render json: updated_artwork
        else
            render json: updated_artwork.errors.full_messages, status: :unprocessable_entity
        end
    end

    
    def destroy
        destroyed_artwork = Artwork.destroy(params[:id])
        destroyed_artwork.destroy
        render json: destroyed_artwork
    end

    private

    def artwork_params
        params.require(:artwork).permit(:title, :artist_id, :image_url)
    end


end