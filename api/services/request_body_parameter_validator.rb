class RequestBodyParameterValidator
  attr_reader :errors

  def initialize(user_input)
    @base_rent = user_input['base_rent']
    @signed_on = user_input['signed_on']
    @start_date = user_input['start_date']
    @region = user_input['region']
    @errors = {}
    run
  end

  def errors?
    return !errors.empty?
  end

  private

  def run
    validate_region
    validate_rent
    validate_dates
    validate_start_date_after_signed_on unless @errors['signed_on'] || @errors['start_date']
  end

  def validate_region
    unless @region.nil? || @region.empty?
      @errors['region'] = ['must_be_one_of_brussels_or_wallonia_or_flanders'] unless ['brussels', 'wallonia', 'flanders'].include?(@region)
    else
      @errors['region'] = ['missing']
    end
  end

  def validate_rent
    unless @base_rent.nil?
      @errors['base_rent'] = ['must_be_positive'] if @base_rent.zero? || @base_rent.negative?
    else
      @errors['base_rent'] = ['missing']
    end
  end

  def validate_dates
    {'signed_on' => @signed_on, 'start_date' => @start_date}.each do |attr_name, date_string|
      unless date_string.nil? || date_string.empty?
        begin
          date_object = Date.parse(date_string)
        rescue
          @errors[attr_name] = ['invalid_date']
        else
          @errors[attr_name] = ['cannot_be_in_the_future'] if date_object > Date.today
        end
      else
        @errors[attr_name] = ['missing']
      end
    end
  end

  def validate_start_date_after_signed_on
    @errors['start_date_and_signed_on_conflict'] = ['start_date_must_be_in_the_future_of_signed_on_date'] if Date.parse(@signed_on) > Date.parse(@start_date)
  end
end
