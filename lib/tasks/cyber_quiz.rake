# require "#{Rails.root}/app/helpers/reporter_helper"
# include ReporterHelper
#
# namespace :cyber_quiz  do
#   desc "Remind the stakeholders the incomplete quiz status."
#   category = "Cybersecurity_User_Awareness_Training"
#   event_id = "June2017"
#
#   task :due_reminder => :environment do
#     due_date = Date.new(2017,7,15)
#     # Only send email reminder if date past July 15 2017, and it's not Sunday or Satursday
#     if due_date < Date.today && Date.today.wday != 0 && Date.today.wday != 6
#       check(category, event_id )
#       @candidate_list.each do |name, addr|
#         puts "Deliver due notice to #{name}; at address #{addr}"
#       end
#       UserMailer.due_notice(@candidate_list.values).deliver_later
#       puts "Total email delivery count: #{@candidate_list.length}"
#     end
#   end
#
# end
