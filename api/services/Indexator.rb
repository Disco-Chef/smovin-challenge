class Indexator
  def call(region, rent, signed_date, start_date)
    # TK: Calculate everything necessary to make the 2 calls to the given endpoint:
    # https://fi7661d6o4.execute-api.eu-central-1.amazonaws.com/prod/indexes/:BASE/:YEAR-:MONTH

    # TK: Make the calls
    # call_index_endpoint(base_year, current_month_strftimed) # _strftimed => "/2009-02"
    # call_index_endpoint(base_year, base_month_strftimed)

    # TK: return hash with base_rent, base_index, current_index, new_rent
  end

  def call_index_endpoint(year, date_strftimed)

  end
end
