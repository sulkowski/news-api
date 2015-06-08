require 'spec_helper'

describe News::Routes::Legacy::Users do
  describe '#POST /users' do
    before { post '/users' }

    it_should_behave_like 'legacy endpoint'
  end
end
