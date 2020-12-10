class AlbumsController < ApplicationController
        
    before_action :require_user!
    
    def new
        @album = Album.new
        @band_id = params[:band_id] if params[:band_id]
    end

    def create
        @album = Album.new(album_params)
        if @album.save!
            redirect_to album_url(@album)
        else
            render json: @album.errors.full_messages
            render :new
        end
    end

    def index
        @albums = Album.all
        render :index
    end

    def show
        @album = Album.find(params[:id])
        render :show
    end

    def edit
        @album = Album.find(params[:id])
        render :edit
    end

    def update
        @album = Album.find(params[:id])
    
        if @album.update(album_params)
            redirect_to album_url(@album)
        else
            # flash.now[:errors] = @album.errors.full_messages
            render json: @album.errors.full_messages
            render :edit
        end
    end

    def destroy
        album = Album.find(params[:id])
        album.destroy
        redirect_to albums_url
    end

    private

    def album_params
        params.require(:album).permit(:title, :band_id, :year, :location)
    end
end
