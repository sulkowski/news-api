require 'spec_helper'
require 'news_api'

describe NewsApi do
  let(:app) { NewsApi.new }

  it 'returns a successful response' do
    get '/'

    expect(last_response).to be_ok
    expect(last_response.body).to eq('')
  end
end
