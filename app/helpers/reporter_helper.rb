#--
# cyber_quiz
#
# A  Ruby application for enterprise online quiz management solution
#
# Copyright (c)  CMBNY Risk Department
#++


module ReporterHelper
  def init_reporter_env
  	#@candidate_list = YAML.load_file(Rails.root.join('config','candidate_list.yml'))
    @candidate_list = Candidate.pluck(:name, :email).to_h
    @event = YAML.load_file(Rails.root.join('config','event.yml'))
  end

  def check(category, eventid)
    init_reporter_env
    recorded_candidates = Reporter.where(quiz_category: category, quiz_eventid: eventid).distinct.pluck(:candidate_email).map {|x| x.downcase}
    puts "Recorded_candidates: #{recorded_candidates.inspect}"
    puts "Total record count: #{recorded_candidates.count}"
    return {} if recorded_candidates.nil?
    @candidate_list.each do |name,email|
      @candidate_list.delete(name) if recorded_candidates.include?(email.downcase)
    end
  end

end
