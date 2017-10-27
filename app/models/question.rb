class Question < ActiveRecord::Base
  has_many :choices

  def answer
    uncorrect
    choices.select(&:correct)[0]
  end

  def uncorrect
    choices.each { |c| c.correct = false }
  end

  def answer=(choice)
    answer.correct = false unless answer.nil?

    if choices.include? choice
    else
      choices << choice
    end
    choice.correct = true
  end
end
