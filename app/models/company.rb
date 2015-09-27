class Company < ActiveRecord::Base
  belongs_to :user
  has_many :contacts, dependent: :destroy
  
  default_scope -> { order(created_at: :desc) }

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :status, presence: true
end
