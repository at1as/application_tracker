class Event < ActiveRecord::Base
  belongs_to :company
  
  default_scope    -> { order(date: :desc) }

  validates :date, presence: true

  def start_time
    # Used for simple calendar gem
    DateTime.parse(date)
  end

  def self.date_string_to_date(date_str)
    Date.parse(date_str)
  end

  def self.future
    today = Date.today
    Event.all.select{ |r| self.date_string_to_date(r.date) >= Date.today }
  end

  def self.past
    today = Date.today
    Event.all.select{ |r| self.date_string_to_date(r.date) < Date.today }
  end
end
