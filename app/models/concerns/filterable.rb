module Filterable
  private
  def parse_filter_params(filtering)
    filter.map do
    results = ""
    filtering_params.each do |key, value|
      results += " " + key.to_s + " " +value.to_s
    end
    p results
  end

   def parse_filter_params(filter)
    filter.map do |table, col_with_val|
      col_with_val.map do |col, val|
        value_helper(table, col, val)
      end
    end.join(' AND ')
  end

  def value_helper(table, col, val)
    byebug
    col = "#{table}.#{col}"
    if (['true', 'false'] && val).length
      case
      when ['true'] then "#{col} IS NOT NULL"
      when ['false'] then "#{col} IS NULL"
      when ['true', 'false'] then "(#{col} IS NOT NULL OR #{col} IS NULL)"
      end
    else
      "#{col} IN #{val.to_s.tr('[]"', '()\'')}"
    end
  end

end
