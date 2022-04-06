require 'open-uri'
require 'json'

class Indexator
  BASES = [1988, 1996, 2004, 2013]

  def get_new_rent_data(base_rent, region, signed_on, start_date)
    base_month_date = signed_on.prev_month
    base_month_strftimed = base_month_date.strftime('%Y-%m')

    current_month_date = find_month_before_last_birthday(start_date)
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
    url = "https://fi7661d6o4.execute-api.eu-central-1.amazonaws.com/prod/indexes/#{base_year}/#{date_strftimed}"
    p url
    return JSON.parse(URI.open(url).read)['index']['MS_HLTH_IDX']
  end

  def set_base_year(base_month_date)
    BASES.reverse.find { |year| year <= base_month_date.year }
  end

  def find_month_before_last_birthday(start_date)
    month_before_last_birthday = Date.new(Date.today.year, start_date.month, start_date.day).prev_month
    month_before_last_birthday > Date.today ? month_before_last_birthday.prev_year : month_before_last_birthday
  end
end
