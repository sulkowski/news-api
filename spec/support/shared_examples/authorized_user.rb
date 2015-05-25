RSpec.shared_examples 'authorized user' do
  it 'has `WWW-Authenticate` header' do
    expect(last_response.header).to include('WWW-Authenticate')
  end
end
