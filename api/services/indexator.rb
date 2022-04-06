require 'open-uri'
require 'json' #TK: For test running file separately..
require 'byebug'

class Indexator
  BASES = [1988, 1996, 2004, 2013]

  # TK: Consistency: use attributes and instance variables like in the validator for consistency? (And to avoid remembering to give 4 args in specific order 😅)
  def compute_new_rent(base_rent, region, signed_on, start_date)
    # TK: This code perhaps smells?
    base_month_date = signed_on.prev_month
    base_month_strftimed = base_month_date.strftime('%Y-%m')

    current_month_date = find_last_birthday(start_date)
    current_month_strftimed = current_month_date.strftime('%Y-%m')

    base_year = set_base_year(base_month_date)
    base_index = call_index_endpoint(base_year, base_month_strftimed)
    current_index = call_index_endpoint(base_year, current_month_strftimed)

    return {
      'new_rent' => ((base_rent * current_index) / base_index).round(2), # TK: Convert to cents and round after converting back to euro? 🤔
      'current_index' => current_index,
      'base_index' => base_index
    }
  end

  private

  def call_index_endpoint(base_year, date_strftimed)
    base_url = 'https://fi7661d6o4.execute-api.eu-central-1.amazonaws.com/prod/indexes'
    full_url = base_url + "/#{base_year}/#{date_strftimed}"
    return JSON.parse(URI.open(full_url).read)['index']['MS_HLTH_IDX']
  end

  def set_base_year(base_month_date)
    BASES.reverse.find { |year| year <= base_month_date.year }
  end

  def find_last_birthday(start_date)
    last_birthday = Date.new(Date.today.year, start_date.month, start_date.day)
    last_birthday > Date.today ? last_birthday.prev_year : last_birthday
  end
end
