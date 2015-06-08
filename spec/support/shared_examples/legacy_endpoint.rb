RSpec.shared_examples 'legacy endpoint' do
  it 'returns correct status code and contains location header to the new endpoint' do
    expect(last_response.status).to eq(301)
    expect(last_response.headers['Location']).to eq "#{last_request.base_url}/v1#{last_request.path}"
  end
end
