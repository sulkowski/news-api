require 'spec_helper'

describe NewsApi do
  it 'returns a successful response' do
    get '/'

    expect(last_response).to be_ok
    expect(last_response.body).to eq('')
  end
end
