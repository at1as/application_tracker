class Company < ActiveRecord::Base

  MAX_POSTGRES_INT = 2147483647
  
  belongs_to :user

  has_many :contacts, dependent: :destroy
  has_many :positions, dependent: :destroy
  
  has_attached_file :attachment
  validates_attachment_file_name :attachment, :matches => [/png\Z/, /jpe?g\Z/, /gif\Z/, /pdf\Z/]

  default_scope -> { order(created_at: :desc) }

  validates :name, presence: true, uniqueness: { case_sensitive: false, scope: :user_id }
  validates :status, presence: true


  def self.filter(attributes)
    puts "A #{attributes}"    
    attributes.reduce(all) do |scope, (key, value)|

      if !value.blank? and !value.nil?
        case key.to_sym
          when :filter_name, :filter_status, :filter_location
            current_key = key.gsub('filter_', '')
            scope.where(["#{current_key} ILIKE ?", "%#{value}%"])
          when :filter_size_min
            value = valid_int_range(value)
            scope.where("size >= ?", value)
          when :filter_size_max
            value = valid_int_range(value)
            scope.where("size <= ?", value)
          when :date
            scope.where("updated_at >= ?", value)
          else
            scope
          end
      else
        scope
      end
    end
  end

  def self.valid_int_range(num)
    return 0 if num.to_i < 0
    return MAX_POSTGRES_INT if num.to_i > MAX_POSTGRES_INT
    num
  end
end
