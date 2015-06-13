require 'spec_helper'

describe News::Services::ApiVersionExtracter do
  context 'valid API header' do
    it 'it retuns api version' do
      expect(described_class['application/vnd.news-app.v1+json']).to eq(1.0)
      expect(described_class['application/vnd.news-app.v2.1+json']).to eq(2.1)
    end

    it 'returns nil if the version is not provided' do
      expect(described_class['application/vnd.news-app+json']).to be_nil
      expect(described_class['application/vnd.news-app.v+json']).to be_nil
    end
  end

  context 'invalid API header' do
    it 'returns nil when header does not exists' do
      expect(described_class[]).to be_nil
      expect(described_class['']).to be_nil
    end

    it 'retuns nil if vendor is not provided' do
      expect(described_class['application/vnd.v1+json']).to be_nil
    end
  end
end
