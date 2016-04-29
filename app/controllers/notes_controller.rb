class NotesController < ApplicationController
  before_action :set_book, only: [:create, :destroy] #this one will map to the set_book method that retrieve a certain book based on its id

  def create
    @note = @book.notes.new(note_params) #note_params is a defined method below to use strong parameters.
     if @note.save
      redirect_to @book, notice: "Note Added!"
    else
      redirect_to @book, alert: "Faild to add a Note!"
    end
  end

  def destroy
    @note = @book.notes.find(params[:id])
    @note.destroy
    redirect_to @book, notice: "Note Deleted!"
  end

private
  def set_book
    @book = Book.find(params[:book_id]) #params is the parameters sent to the model
  end

  def note_params
    params.require(:note).permit(:title, :note)
  end
end
