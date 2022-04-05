class UserInputValidator
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

  def run
    validate_region
    validate_rent
    validate_signed_on
    validate_start_date
  end

  private

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

  # TK: Make DRY these date validators:
  def validate_signed_on
    unless @signed_on.nil?
      begin
        @signed_on = Date.parse(@signed_on)
      rescue
        @errors['signed_on'] = ['invalid_date']
      else
        @errors['signed_on'] = ['date_cannot_be_in_the_future'] if @signed_on > Date.today

      end
    else
      @errors['signed_on'] = ['missing']
    end
  end

  def validate_start_date
    unless @start_date.nil?
      begin
        @start_date = Date.parse(@start_date)
      rescue
        @errors['start_date'] = ['invalid_date']
      else
        @errors['start_date'] = ['date_cannot_be_in_the_future'] if @start_date > Date.today

      end
    else
      @errors['start_date'] = ['missing']
    end
  end
end
