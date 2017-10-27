#--
# cyber_quiz
#
# A  Ruby application for enterprise online quiz management solution
#
# Copyright (c)  CMBNY Risk Department
#++


class HomeController < ApplicationController

  def page

  end

  def support_contact
    @trainers = Trainer.all
  end

end
