RSpec.shared_examples 'json response' do
  it 'has `application/json` content-type' do
    expect(last_response.header['Content-Type']).to eq('application/json')
  end
end
