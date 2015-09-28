class Contact < ActiveRecord::Base
  belongs_to :company
  default_scope -> { order(created_at: :desc) }

  VALID_EMAIL_ADD = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i 
  VALID_PHONE_NUM = /\D*([2-9]\d{2})(\D*)([2-9]\d{2})(\D*)(\d{4})\D*/i
  
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates_format_of :email, :with => VALID_EMAIL_ADD, :on => :create, :allow_blank => true
  validates_format_of :phone, :with => VALID_PHONE_NUM, :on => :create, :allow_blank => true

end
