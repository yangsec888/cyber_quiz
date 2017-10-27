#--
# cyber_quiz
#
# A  Ruby application for enterprise online quiz management solution
#
# Copyright (c)  CMBNY Risk Department
#++

class ChoicesController < ApplicationController
  def create
    @question = Question.find(params[:question])
    text = params[:text]
    correct = params[:correct] == '1'
    new = Choice.create(text: text, correct: correct, question_id: @question.id)

    @question.answer = new if new.correct

    redirect_to question_path(@question)
  end

  def destroy
    @question = Question.find(params[:question])
    @choice = Choice.find(params[:choice])
    @choice.destroy
    redirect_to question_path(@question)
  end
end
