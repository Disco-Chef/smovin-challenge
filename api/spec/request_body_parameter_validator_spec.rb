require_relative '../services/request_body_parameter_validator.rb'
describe 'RequestBodyParameterValidator' do
  context '#errors?' do
    it 'returns a true if there are any errors in the parameters' do
      bad_params = {
        'base_rent' => -500,
        'region' => 'wonderland',
        'start_date' => '2010-09-30',
        'signed_on' => '2010-07-32'
      }
      example_validator = RequestBodyParameterValidator.new(bad_params)

      expect(example_validator.errors?).to eq(true)
    end
  end
end

describe 'RequestBodyParameterValidator' do
  context '#errors' do
    it 'returns a hash of parameters that were invalid, along with the errors associated with each' do
      bad_params = {
        'base_rent' => -500,
        'region' => 'wonderland',
        'start_date' => '2024-09-30',
        'signed_on' => '2019-07-32'
      }
      validator = RequestBodyParameterValidator.new(bad_params)

      expected_errors_object_from_bad_params = {
        'region' => ['must_be_one_of_brussels_or_wallonia_or_flanders'],
        'base_rent' => ['must_be_positive'],
        'signed_on' => ['invalid_date'],
        'start_date' => ['cannot_be_in_the_future']
      }

      expect(validator.errors).to eq(expected_errors_object_from_bad_params)
    end

    it 'returns a hash with an start_date_and_signed_on_conflict key if the signed_on and start_date are valid but not sequential in that order' do
      bad_params = {
        'base_rent' => 500,
        'region' => 'brussels',
        'start_date' => '2010-09-01',
        'signed_on' => '2015-07-25'
      }
      validator = RequestBodyParameterValidator.new(bad_params)

      expected_errors_object_from_bad_params = {
        'start_date_and_signed_on_conflict' => ['start_date_must_be_in_the_future_of_signed_on_date']
      }

      expect(validator.errors).to eq(expected_errors_object_from_bad_params)
    end
  end
end
