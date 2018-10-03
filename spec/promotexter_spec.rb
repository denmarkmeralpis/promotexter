require 'spec_helper'

RSpec.describe Promotexter do
  context 'gem version' do
    it 'has a version number' do
      expect(Promotexter::VERSION).not_to be nil
    end
  end
end