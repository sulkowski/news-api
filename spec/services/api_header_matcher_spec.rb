require 'spec_helper'

describe News::Services::ApiHeaderMatcher do
  context 'valid accept header' do
    let(:accept_header) { 'application/vnd.news-app.v2.1+json' }

    context 'when all attributes are present and are valid' do
      it 'returns true' do
        expect(described_class[accept_header: accept_header,
                               vendor: 'news-app',
                               version: '2.1',
                               media_range: 'application/json']).to eq(true)
      end
    end

    context 'when version is not relevant' do
      it 'returns true' do
        expect(described_class[accept_header: accept_header,
                               vendor: 'news-app',
                               media_range: 'application/json']).to eq(true)
      end
    end

    context 'when vendor is not relevant' do
      it 'returns true' do
        expect(described_class[accept_header: accept_header,
                               version: '2.1',
                               media_range: 'application/json']).to eq(true)
      end
    end

    context 'when media range is not relevant' do
      it 'returns true' do
        expect(described_class[accept_header: accept_header,
                               vendor: 'news-app',
                               version: '2.1']).to eq(true)
      end
    end

    context 'when `vendor` does not match' do
      it 'returns false' do
        expect(described_class[accept_header: accept_header,
                               vendor: 'video-app']).to eq(false)
      end
    end

    context 'when `version` does not match' do
      it 'returns false' do
        expect(described_class[accept_header: accept_header,
                               version: '2.2']).to eq(false)
      end
    end

    context 'when media-range `type` does not match' do
      it 'returns false' do
        expect(described_class[accept_header: accept_header,
                               media_range: 'text/json']).to eq(false)
      end
    end

    context 'when media-range `subtype` does not match' do
      it 'returns false' do
        expect(described_class[accept_header: accept_header,
                               media_range: 'application/xml']).to eq(false)
      end
    end
  end

  context 'invalid accept header' do
    it 'returns false' do
      expect(described_class[accept_header: 'application/json',
                             media_range: 'application/json']).to eq(false)
    end
  end
end
