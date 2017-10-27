exam = File.open(Rails.root.join('db', 'seeds', 'OWASP Top 10 Threats and Mitigations Exam.txt'), 'r')
# exam = File.open('OWASP Top 10 Threats and Mitigations Exam.txt', 'r')
question_index = 22 # after cyber_security_awareness_exam
exam.each do |line|
  if line =~ /^\d{1,3}/
    question_index += 1
    # puts 'question: ' + line.gsub(/^\d{1,3}\)/, '')
    # puts 'mutiple choices' if line =~ /.*\(Choose \w{3}.\)$/
    Question.create(id: question_index, text: line.sub(/^\d{1,3}\)/, ''), category: 'OWASP Top 10 Threats and Mitigations')
  elsif line =~ /^[A-Z]|\d/
    flag = line =~ /.*Correct$/ ? true : false
    puts 'choice: ' + line + ' ' + flag.to_s
    Choice.create(text: line.sub(/ Correct$/, ''), correct: flag, question_id: question_index)
  else
    next
  end
end
