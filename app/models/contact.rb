class Contact < ActiveRecord::Base
  belongs_to :company
  default_scope -> { order(created_at: :desc) }

  VALID_EMAIL_ADD = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i 

  validates :name, presence: true, uniqueness: { case_sensitive: false }

end
