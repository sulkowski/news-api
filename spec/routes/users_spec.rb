require 'spec_helper'

describe News::Routes::Users do
  describe '#POST `/users`' do
    context 'when params are valid' do
      before { post '/users', email: '007@mi6.co.uk', password: 'vesper' }

      it_should_behave_like 'json response'

      it 'returns correct status code and response' do
        expect(last_response.status).to eq(201)
        expect(last_response.body).to include_json(
          email: '007@mi6.co.uk'
        )
      end
    end

    describe 'password validations' do
      let(:empty_password_error) do
        {
          error: {
            code: 422,
            message: 'Validation failed: Password can\'t be blank',
            errors: {
              password: ['can\'t be blank']
            }
          }
        }
      end

      context 'when is not given' do
        before { post '/users', email: '007@mi6.co.uk' }

        it_should_behave_like 'json response'

        it 'returns correct status code and response' do
          expect(last_response.status).to eq(422)
          expect(last_response.body).to include_json(empty_password_error)
        end
      end

      context 'when is an empty string' do
        before { post '/users', email: '007@mi6.co.uk', password: '' }

        it_should_behave_like 'json response'

        it 'returns correct status code and response' do
          expect(last_response.status).to eq(422)
          expect(last_response.body).to include_json(empty_password_error)
        end
      end
    end

    describe 'email validations' do
      context 'when is not given' do
        before { post '/users', password: 'secret' }

        it_should_behave_like 'json response'

        it 'returns correct status code and response' do
          expect(last_response.status).to eq(422)
          expect(last_response.body).to include_json(
            error: {
              code: 422,
              message: 'Validation failed: Email can\'t be blank',
              errors: {
                email: ['can\'t be blank']
              }
            }
          )
        end
      end

      context 'when already exists in the database' do
        let(:user_params) { { email: '007@mi6.co.uk', password: 'versper' } }

        before do
          User.create(user_params)
          post '/users', user_params
        end

        it_should_behave_like 'json response'

        it 'returns correct status code and response' do
          expect(last_response.status).to eq(422)
          expect(last_response.body).to include_json(
            error: {
              code: 422,
              message: 'Validation failed: Email has already been taken',
              errors: {
                email: ['has already been taken']
              }
            }
          )
        end
      end
    end
  end
end
