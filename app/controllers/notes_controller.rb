class NotesController < BaseController
  before_action :set_note, only: [:show, :update, :destroy]

  # GET users/1/notes
  def index
    @notes = current_user.notes

    render json: { notes: @notes, count: @notes.count }
  end

  # GET users/1/notes/1
  def show
    render json: { note: @note }
  end

  # POST users/1/notes
  def create
    @note = current_user.notes.build(note_params)

    if @note.save
      render json: { note: @note , message: 'Note successful updated'}, status: :created
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT users/1/notes/1
  def update
    if @note.update(note_params)
      render json: { note: @note, message: 'Note successful updated' }
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  # DELETE users/1/notes/1
  def destroy
    @note.destroy
    render json: { message: 'Note successful deleted' }
  end

  private

  def set_note
    @note = current_user.notes.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def note_params
    params.require(:note).permit(:reminder_date, :description)
  end
end
