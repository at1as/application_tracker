class Position < ActiveRecord::Base
  belongs_to :company

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
