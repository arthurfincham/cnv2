class NotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_note, only: [:edit, :update, :destroy, :show]
  
  def index
    if params[:tag]
      @notes = current_user.notes.tagged_with(params[:tag]).order(params[:sort])
    else
      @notes = current_user.notes.order(params[:sort])
    end
  end

  def new
    @note = current_user.notes.new
  end

  def create
    @note = current_user.notes.new(note_params)
    @note.user = current_user
    if @note.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @note.update(note_params)
      redirect_to root_path
    else
      flash[:notice] = "note was not updated"
      render 'edit'
    end 
  end

  def show
  end

  def destroy
    @note.destroy
    flash[:notice] = "Note was deleted"
    redirect_to root_path
   end

  private

  def note_params
    params.require(:note).permit(:note_date, :note_title, :instructor, :tag_list, :partner, :pos_description, :neg_description)
  end

  def set_note
    @note = Note.find(params[:id])
  end
  
end
