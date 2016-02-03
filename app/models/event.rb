class Event < ActiveRecord::Base
  belongs_to :company
  
  default_scope    -> { order(date: :desc) }

  validates :date, presence: true

  def start_day
    # Used for simple calendar gem
    DateTime.parse(date)
  end

  def self.date_string_to_date(date_str)
    Date.parse(date_str)
  end

  def self.future
    # TODO: Events are now returned sorted by date, but not by time, within a day
    # Something like this would do the trick (a = date, b = time)
    #   nums.sort_by{|x| x[:a]}.chunk{|x| x[:a]}.sort_by{|x, y| x}.map{|x| x[1].sort_by{|x| x[:b]}}.flatten
    today = Date.today
    Event.all.select{ |r| self.date_string_to_date(r.date) >= Date.today }.sort_by{ |e| e[:date] }.reverse
  end

  def self.past
    today = Date.today
    Event.all.select{ |r| self.date_string_to_date(r.date) < Date.today }.sort_by{ |e| e[:date] }.reverse
  end
end
