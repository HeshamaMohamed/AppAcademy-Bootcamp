class TracksController < ApplicationController
    
    before_action :require_user!
    
    def new
        @track = Track.new
        @album_id = params[:album_id] if params[:album_id]
    end

    def create
        @track = Track.new(track_params)
        # fail
        if @track.save!
            redirect_to track_url(@track)
        else
            render json: @track.errors.full_messages
            render :new
        end
    end

    def index
        @tracks = Track.all
        render :index
    end

    def show
        @track = Track.find(params[:id])
        render :show
    end

    def edit
        @track = Track.find(params[:id])
        render :edit
    end

    def update
        # fail
        @track = Track.find(params[:id])

        if @track.update(track_params)
            redirect_to track_url(@track)
        else
            # flash.now[:errors] = @track.errors.full_messages
            render json: @track.errors.full_messages
            render :edit
        end
    end

    def destroy
        track = Track.find(params[:id])
        track.destroy
        redirect_to tracks_url
    end

    private

    def track_params
        params.require(:track).permit(:title, :ord, :regular_or_bonus, :album_id, :lyrics)
    end
end
