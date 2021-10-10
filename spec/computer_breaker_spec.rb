# frozen_string_literal: true

require_relative '../lib/computer_breaker.rb'

describe ComputerBreaker  do
  subject(:computer_breaker) { described_class.new }

  describe '#fetch_code_from_player' do
    it 'valid code' do
      allow(computer_breaker).to receive(:gets).and_return('1234')
      expected_result = %w[1 2 3 4]
      expect(computer_breaker.fetch_code_from_player).to eq(expected_result)
    end
  end
end
