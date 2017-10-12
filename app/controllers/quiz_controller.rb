#--
# cyber_quiz
#
# A  Ruby application for enterprise online quiz management solution
#
# Copyright (c)  CMBNY Risk Department
#++


class QuizController < ApplicationController
=begin
  before_action :init_candidate_list

  def init_candidate_list
  	@candidate_list = YAML.load_file(Rails.root.join('config','candidate_list.yml'))
  end
=end
  def index
  end

  def start
    #all = Question.where(category: params[:category][0]).map {|x| x.id}
    all = Question.where(category: 'Cybersecurity_User_Awareness_Training').map {|x| x.id}
    #total = all.length
    total = 10
	  session[:questions] = all.sort_by{rand}[0..(total-1)]
	  session[:total]   = total
	  session[:current] = 0
	  session[:correct] = 0

	  redirect_to :action => "question"
  end

  def question
	 @current = session[:current]
	 @total   = session[:total]

	 if @current >= @total
		redirect_to :action => "end"
		return
	 end

	 @question = Question.find(session[:questions][@current])
	 @seed = rand
	 @choices = @question.choices.sort_by{@seed}

	 session[:question] = @question.id
	 session[:seed] = @seed
  end

  def answer
	 @current = session[:current]
	 @total   = session[:total]

	 choiceid = params[:choice]

	 @question = Question.find(session[:question])
	 @choices = @question.choices.sort_by{session[:seed]}

	 @choice = choiceid ? Choice.find(choiceid) : nil
	 if @choice and @choice.correct
		@correct = true
		session[:correct] += 1
	 else
		@correct = false
	 end

	 session[:current] += 1
  end

  def end
	 @correct = session[:correct]
	 @total   = session[:total]
	 @pass_line = 70
	 @quiz_category = Question.find(session[:question]).category
	 @score = @correct * 100 / @total
  end

end
