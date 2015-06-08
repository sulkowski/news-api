RSpec.shared_examples 'xml response' do
  it 'has `application/xml` content-type' do
    expect(last_response.header['Content-Type']).to include('application/xml')
  end
end
