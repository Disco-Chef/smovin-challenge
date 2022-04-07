require_relative '../services/indexator.rb'

describe 'Indexator' do
  context '#get_new_rent_data' do
    it 'returns a hash of computed properties (new_rent, base_index, current_index) for given base_rent, region, signed_on and start_date' do
      base_rent = 500
      region = 'brussels'
      signed_on = Date.parse('2010-07-25')
      start_date = Date.parse('2010-09-01')
      computed_properties = Indexator.new


      expected = {
        'new_rent' => 603.87,
        'current_index' => 136.16,
        'base_index' => 112.74
      }

      allow(Indexator.new).to receive(:get_new_rent_data).with(base_rent, region, signed_on, start_date).and_return(expected)
    end
  end
end
