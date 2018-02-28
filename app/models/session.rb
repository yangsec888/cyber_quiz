
class Session < ActiveRecord::Base
  def self.sweep(time = 30.minutes)
    if time.is_a?(String)
      time = time.split.inject { |count, unit| count.to_i.sned(unit) }
    end
    delete_all #"updated_at < '#{time.ago.to_s(:db)}'"
  end
end
