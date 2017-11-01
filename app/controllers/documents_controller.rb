#--
# cyber_quiz
#
# A  Ruby application for enterprise online quiz management solution
#
# Developed by Yang Li, Kainan Zhang. Creative Common License
#
#++


class DocumentsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
  	@docs = Document.all
  end

  def new
  	@doc = Document.new
  end

  def create
  	@doc = Document.new(doc_params)
  	@doc.name = params[:document][:attachment].original_filename if @doc.name.blank?
  	if @doc.save
  	  redirect_to documents_path, notice: "The document #{@doc.name} has been uploaded."
  	else
  	  render "new"
  	end

  end

  def destroy
  	@doc = Document.find(params[:id])
  	@doc.destroy
  	redirect_to documents_path, notice: "The document #{@doc.name} has been deleted."
  end

private

  def doc_params
  	params.require(:document).permit(:name, :attachment)
  end

end
