require_relative '../spec_helper'

RSpec.describe Promotexter::Configuration do
  before do
    Promotexter.configure do |config|
      config.sender_id = ENV['PROMOTEXTER_SENDER_ID']
      config.api_key    = ENV['PROMOTEXTER_API_KEY']
      config.api_secret = ENV['PROMOTEXTER_API_SECRET']
    end
  end

  context 'with configuration block' do
    it 'returns the correct api_key' do
      expect(Promotexter.configuration.api_key).to eq(ENV['PROMOTEXTER_API_KEY'])
    end
    it 'returns the correct api_secret' do
      expect(Promotexter.configuration.api_secret).to eq(ENV['PROMOTEXTER_API_SECRET'])
    end
    it 'returns the correct sender id' do
      expect(Promotexter.configuration.sender_id).to eq(ENV['PROMOTEXTER_SENDER_ID'])
    end
  end

  context 'without configuration block' do
    before { Promotexter.reset }

    it 'raises configuration error for api_key' do
      expect { Promotexter.configuration.api_key }.to raise_error(Promotexter::Errors::Configuration)
    end
    it 'raises configuration error for api_secret' do
      expect { Promotexter.configuration.api_secret }.to raise_error(Promotexter::Errors::Configuration)
    end
    it 'raises configuration error for sender id' do
      expect { Promotexter.configuration.sender_id }.to raise_error(Promotexter::Errors::Configuration)
    end
  end

  context 'with delivery reports set to true' do
    before { Promotexter.configuration.dlr_report = true }

    it 'raises configuration error for dlr_callback' do
      expect { Promotexter.configuration.dlr_callback }.to raise_error(Promotexter::Errors::Configuration)
    end
  end

  context '#reset' do
    it 'resets the configuration values' do
      expect(Promotexter.configuration.api_key).to eq(ENV['PROMOTEXTER_API_KEY'])
      expect(Promotexter.configuration.api_secret).to eq(ENV['PROMOTEXTER_API_SECRET'])
      expect(Promotexter.configuration.sender_id).to eq(ENV['PROMOTEXTER_SENDER_ID'])

      Promotexter.reset

      expect { Promotexter.configuration.api_key }.to raise_error(Promotexter::Errors::Configuration)
      expect { Promotexter.configuration.api_secret }.to raise_error(Promotexter::Errors::Configuration)
      expect { Promotexter.configuration.sender_id }.to raise_error(Promotexter::Errors::Configuration)
    end
  end
end
