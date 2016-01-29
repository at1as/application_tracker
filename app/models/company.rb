class Company < ActiveRecord::Base

  MAX_POSTGRES_INT = 2147483647
  
  belongs_to :user

  has_many :contacts, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :positions, dependent: :destroy
  
  has_attached_file :attachment
  validates_attachment_file_name :attachment, :matches => [/png\Z/, /jpe?g\Z/, /gif\Z/, /pdf\Z/]

  default_scope -> { order(created_at: :desc) }

  validates :name, presence: true, uniqueness: { case_sensitive: false, scope: :user_id }
  validates :status, presence: true


  def self.filter(attributes)
    attributes.reduce(all) do |scope, (key, value)|

      if !value.blank? && !value.nil?
        case key.to_sym
          when :filter_name, :filter_status, :filter_location
            current_key = key.gsub('filter_', '')
            db_query = "#{current_key} ILIKE ?"
            active_record_query = [db_query]

            # Break into multiple queries with OR logic separated by '||'
            queries = value.split("||").map{ |x| x.strip.chomp('|').strip }.reject{ |x| x.empty? }

            queries.each_with_index do |query, idx|
              active_record_query.first << " OR #{db_query}" if idx != 0
              active_record_query << "%#{query}%"
            end
            scope.where(active_record_query)
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

  def self.to_csv
    attributes = %w(name location size status website details created_at updated_at)

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |company|
        csv << attributes.map{ |attr| company.send(attr) }
      end
    end
  end
  
  def self.to_nested_csv(nested_model)
    case nested_model
    when :events
      attributes = %w(company date event_type text)
    when :positions
      attributes = %w(company name url description)
    when :contacts
      attributes = %w(company name location position details email phone)
    else
      render :status => 404
    end

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |company|
        company.send(nested_model).each do |event|
          csv << attributes.map do |attr| 
            attr == "company" ? company.name : event.send(attr)
          end
        end
      end
    end
  end

  def self.valid_int_range(num)
    return 0 if num.to_i < 0
    return MAX_POSTGRES_INT if num.to_i > MAX_POSTGRES_INT
    num
  end
end
