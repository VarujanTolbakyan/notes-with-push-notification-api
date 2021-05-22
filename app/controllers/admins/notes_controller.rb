class Admins::NotesController < Admins::BaseController
  before_action :set_user
  before_action :set_note, only: [:show, :update, :destroy]

  # GET admins/users/1/notes
  def index
    @notes = @user.notes

    render json: { notes: @notes, count: @notes.count }
  end

  # GET admins/users/1/notes/1
  def show
    render json: { note: @note }
  end

  # POST admins/users/1/notes
  def create
    @note = @user.notes.build(note_params)

    if @note.save
      render json: { note: @note , message: 'Note successful created'}, status: :created
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT admins/users/1/notes/1
  def update
    if @note.update(note_params)
      render json: { note: @note, message: 'Note successful updated' }
    else
      render json: @note.errors, status: :unprocessable_entity
    end
  end

  # DELETE admins/users/1/notes/1
  def destroy
    @note.destroy
    render json: { message: 'Note successful deleted' }
  end

  private

  def set_user
    @user = User.find params[:user_id]
  end

  def set_note
    @note = @user.notes.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def note_params
    params.require(:note).permit(:reminder_date, :description, :user_id)
  end
end