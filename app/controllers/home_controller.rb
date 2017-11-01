#--
# cyber_quiz
#
# A  Ruby application for enterprise online quiz management solution
#
# Developed by Yang Li, Kainan Zhang. Creative Common License
#
#++


class HomeController < ApplicationController

  def page

  end

  def support_contact
    @trainers = Trainer.all
  end

end
