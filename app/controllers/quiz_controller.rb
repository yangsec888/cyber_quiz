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
    redirect_to reporter_list_path, alert: 'There is no test candidate right now, please import first.' if Candidate.all.empty?
  end

  def start
    all = Question.where(category: params[:category][0]).map(&:id)
    @event = YAML.load_file(Rails.root.join('config', 'event.yml'))
    total =
      if @event['event'][:questions].to_i <= all.size
        @event['event'][:questions].to_i
      else
        all.size
      end
    session[:questions] = all.sort_by { rand }[0..(total - 1)]
    session[:total] = total
    #puts total
    session[:current] = 0
    session[:correct] = 0
    redirect_to action: 'question'
  end

  def question
    @current = session[:current]
    @total = session[:total]

    if @current >= @total
      redirect_to action: 'result'
      return
    end
    @question = Question.find(session[:questions][@current])
    @seed = rand
    @choices = @question.choices.sort_by { @seed }
    @correct_array = @question.choices.where(correct: true).pluck(:id).map(&:to_s)
    session[:question] = @question.id
    session[:seed] = @seed
  end

  def answer
    @current = session[:current]
    @total = session[:total]
    @question = Question.find(session[:question])
    @choices = @question.choices.sort_by { session[:seed] }
    @correct_array = @question.choices.where(correct: true).pluck(:id).map(&:to_s)
    @answer_array = params[:choice]
    if @correct_array.sort == @answer_array.sort
      @correct = true
      session[:correct] += 1
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
    session[:current] += 1
  end

  def result
    @correct = session[:correct]
    @total = session[:total]
    @event = YAML.load_file(Rails.root.join('config', 'event.yml'))
    @pass_line = @event['event'][:passline].to_i
    @quiz_category = Question.find(session[:question]).category
    @score = @correct * 100 / @total
  end
end
