require_relative '../lib/app_2'

describe 'the fonction create_human method' do
  it 'should not be nil' do
    expect(create_human).not_to be_nil
  end  
end