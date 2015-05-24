RSpec.shared_examples 'not authorized user' do
  it 'returns `401` status code' do
    expect(last_response.status).to eq(401)
  end

  it 'has `application/json` content-type' do
    expect(last_response.header['Content-Type']).to include('application/json')
  end

  it 'does not have `WWW-Authenticate` header' do
    expect(last_response.header).to_not include('WWW-Authenticate')
  end

  it 'contains error message' do
    expect(last_response.body).to include_json(
      error: {
        code: 401,
        message: 'Not authorized'
      }
    )
  end
end
