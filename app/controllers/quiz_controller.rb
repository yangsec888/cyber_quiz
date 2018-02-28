#--
# cyber_quiz
#
# A  Ruby application for enterprise online quiz management solution
#
# Developed by Yang Li, Kainan Zhang. Creative Common License
#
#++

class QuizController < ApplicationController
  #   before_action :init_candidate_list
  #
  #   def init_candidate_list
  #     @candidate_list = YAML.load_file(Rails.root.join('config','candidate_list.yml'))
  #   end
  def index
    Session.sweep
    redirect_to reporter_list_path, alert: 'No quiz candidate found in database. Please import them first.' if Candidate.all.empty?
  end

  def init
    @all = Question.where(category: params[:category][0]).map(&:id)
    @event = YAML.load_file(Rails.root.join('config', 'event.yml'))
    @sub =
      if @event['event'][:questions].to_i <= @all.size
        @event['event'][:questions].to_i
      else
        @all.size
      end
  end

  def start
    init
    logger.debug "start sub: #{@sub}"
    part = @all.sort_by { rand }
    logger.debug "start part: #{part}"
    questions = part[0..(@sub-1)]
    logger.debug "start qestions: #{questions}"
    #@session = Hash.new
    session[:total] = @sub
    logger.debug "start session total: #{session[:total]}"
    session[:questions] = @all.sort_by { rand }[0..(@sub - 1)]
    logger.debug "start session questions: #{session[:questions]}"
    session[:current] = 0
    logger.debug "start session current: #{session[:current]}"
    session[:correct] = 0
    logger.debug "start session correct: #{session[:correct]}"
    redirect_to action: 'question', category: params[:category], current: session[:current], total: session[:total], questions: session[:questions], correct: session[:correct]
  end

  def question
    session[:current] ||= params[:current]
    logger.debug "question session current: #{session[:current]}"
    @current = session[:current].to_i
    session[:total] ||= params[:total]
    logger.debug "question session total: #{session[:total]}"
    session[:questions] ||= params[:questions]
    logger.debug "question session questions: #{session[:questions]}"
    session[:correct] ||= params[:correct]
    logger.debug "question session correct: #{session[:correct]}"
    @total = session[:total].to_i
    if @current >= @total
      redirect_to action: 'result' and return
    end
    @question = Question.find(session[:questions][@current])
    @seed = rand
    @choices = @question.choices.sort_by { @seed }
    @correct_array = @question.choices.where(correct: true).pluck(:id).map(&:to_s)
    session[:question] = @question.id
    session[:seed] = @seed
  end

  def answer
    @current = session[:current].to_i
    @total = session[:total]
    @question = Question.find(session[:question])
    @choices = @question.choices.sort_by { session[:seed] }
    @correct_array = @question.choices.where(correct: true).pluck(:id).map(&:to_s)
    @answer_array = params[:choice]
    if @correct_array.sort == @answer_array.sort
      @correct = true
      session[:correct] = session[:correct].to_i + 1
    else
      @correct = false
    end
    #    choiceid = params[:choice]
    #
    #    @question = Question.find(session[:question])
    #    @choices = @question.choices.sort_by{session[:seed]}
    #
    #    @choice = choiceid ? Choice.find(choiceid) : nil
    #    if @choice and @choice.correct
    #     @correct = true
    #     session[:correct] += 1
    #    else
    #     @correct = false
    #    end
    session[:current] = session[:current].to_i + 1
  end

  def result
    logger.debug "result session question: #{session[:question]}"
    @correct = session[:correct]
    logger.debug "result session correct: #{session[:correct]}"
    @total = session[:total].to_i
    logger.debug "result session total: #{session[:total]}"
    @event = YAML.load_file(Rails.root.join('config', 'event.yml'))
    @pass_line = @event['event'][:passline].to_i
    @quiz_category = Question.find(session[:question]).category
    @score = @correct * 100 / @total
  end
end
