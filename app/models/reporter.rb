class Reporter < ActiveRecord::Base
  def self.search(name, category)
    if name != '' && category != ''
        where('candidate LIKE ? and quiz_category = ?', "%#{name}%", "#{category}")
    elsif name == '' && category != ''
        where('quiz_category = ?', "#{category}")
    elsif name != '' && category == ''
        where('candidate LIKE ?', "%#{name}%")
    else
        all
    end
  end
end
