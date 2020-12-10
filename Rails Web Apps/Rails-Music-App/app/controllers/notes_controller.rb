class NotesController < ApplicationController
    
    before_action :require_user!
    
    def new
        @note = Note.new
        @track_id = params[:track_id] if params[:track_id]
        
    end

    def create
        @note = current_user.notes.new(note_params)
        
        # fail
        if @note.save!
            redirect_to track_url(@note.track_id)
        else
            render json: @note.errors.full_messages
            render :new
        end
    end

    def destroy
        note = Note.find(params[:id])
        if current_user == note.user
            note.destroy
            redirect_to notes_url
        else
            render text: "403 FORBIDDEN"
        end
    end

    private

    def note_params
        params.require(:note).permit(:body, :track_id)
    end
end
