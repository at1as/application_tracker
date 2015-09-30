class Company < ActiveRecord::Base
  belongs_to :user

  has_many :contacts, dependent: :destroy
  has_many :positions, dependent: :destroy
  
  has_attached_file :attachment
  validates_attachment_file_name :attachment, :matches => [/png\Z/, /jpe?g\Z/, /gif\Z/, /pdf\Z/]

  default_scope -> { order(created_at: :desc) }

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :status, presence: true

end
