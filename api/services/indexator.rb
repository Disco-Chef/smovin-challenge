class Indexator
  def call(region, base_rent, signed_date, start_date)
    # TK: Make the calls
    current_index = call_index_endpoint(base_year, current_month_strftimed)
    base_index = call_index_endpoint(base_year, base_month_strftimed)

    # TK: return hash with base_index, current_index, new_rent
  end

  def call_index_endpoint(base_year, date_strftimed)
    return JSON.parse(open("https://fi7661d6o4.execute-api.eu-central-1.amazonaws.com/prod/indexes/#{base_year}/#{date_strftimed}").read)["index"]["MS_HLTH_IDX"]
  end
end
