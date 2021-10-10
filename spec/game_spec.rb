# frozen_string_literal: true

require 'stringio'
require_relative '../lib/game.rb'

describe Game do
  subject(:game) { described_class.new }

  describe '#fetch_mode' do
    context 'valid mode' do
      it 'Select a valid mode' do
        allow(game).to receive(:gets).and_return('1')
        expect(game.fetch_game_mode).to equal 1
      end
    end
  end
end
