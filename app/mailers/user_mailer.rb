class UserMailer < ApplicationMailer
  default from: 'no_reply@quiz.cmbnylab.com'

  def get_dist_list
    notification_yml = Rails.root.join('config', 'notification.yml')
    @notification = YAML.load_file(notification_yml)[Rails.env]
  end

  def due_notice (receivers)
    puts "Send Quiz due notice on trainee: #{receivers} "
    puts "Total count: #{receivers.count}"
    get_dist_list
    cc = @notification['cyber_level_1_due']
    #cc = [""]
    #receivers = [""]
    @url  = 'https://quiz.cmbnylab.com/'
    @url_training = 'https://quiz.cmbnylab.com/documents/index'
    sbj = 'Cybersecurity Quiz Reminder'
    unless receivers.empty?
      mail(to: receivers, cc: cc, subject: sbj,  template_path: 'user_mailer', \
        template_name: 'due_reminder')
    end
  end
end
