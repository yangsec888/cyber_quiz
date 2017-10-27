#--
# cyber_quiz
#
# A  Ruby application for enterprise online quiz management solution
#
# Developed by Yang Li, Kainan Zhang. Creative Common License
#
#++

class QuestionsController < ApplicationController
  # GET /questions
  # GET /questions.xml
  before_action :authenticate_user!

  def index; end

  def list
    @questions = Question.where(category: params[:category])
    if @questions.size > 1
      #  @questions = @questions.to_a.sort {|a,b| a.text <=> b.text}
    end
    respond_to do |format|
      format.html
      format.xml  { render xml: @questions }
    end
  end

  # GET /questions/1
  # GET /questions/1.xml
  def show
    @question = Question.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render xml: @question }
    end
  end

  # GET /questions/new
  # GET /questions/new.xml
  def new
    @question = Question.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render xml: @question }
    end
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
  end

  # POST /questions
  # POST /questions.xml
  def create
    @question = Question.new(category: params[:question][:category].to_s, text: params[:question][:text].to_s)

    respond_to do |format|
      if @question.save
        format.html { redirect_to(@question, notice: 'Question was successfully created.') }
        format.xml  { render xml: @question, status: :created, location: @question }
      else
        format.html { render action: 'new' }
        format.xml  { render xml: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /questions/1
  # PUT /questions/1.xml
  def update
    #    render plain: params.inspect
    @question = Question.find(params[:id])
    respond_to do |format|
      if @question.update_attributes(category: params[:question][:category], text: params[:question][:text])
        format.html { redirect_to(@question, notice: 'Question was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render action: 'edit' }
        format.xml  { render xml: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.xml
  def destroy
    @question = Question.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to(:back) }
      format.xml  { head :ok }
    end
  end

  def setting
    @setting = YAML.load_file(Rails.root.join('config', 'event.yml'))
  end

  def save_setting
    @setting = { 'event' => { name: params[:name], date: params[:date],
                              passline: params[:passline], questions: params[:questions]} }
    File.write(Rails.root.join('config', 'event.yml'), @setting.to_yaml)
    redirect_to questions_setting_path, notice: 'Change saved.'
  end

  private

  def secure_params
    params.permit(:question, :text)
  end
end
