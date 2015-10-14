module CompaniesHelper

  def clip(filename, digits)
    
    if filename.length > digits
      if filename[-5..-1].include? "."

        truncation = "...."
        extension = filename[-5..-1].split('.')[1]
        digits_used = extension.length + truncation.length
        base = filename[0..(digits - digits_used - 1)]
      
        return "#{base}#{truncation}#{extension}"
      else
        return "#{base[0..(digits - 3)]}..."
      end
    end
    filename
  end

end
