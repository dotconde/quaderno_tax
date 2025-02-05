require 'spec_helper'
require_relative '../../lib/models/buyer'

RSpec.describe Buyer do
  describe '#initialize' do
    it 'creates a buyer with required attributes' do
      buyer = Buyer.new(country: 'ES')
      expect(buyer.country).to eq('ES')
      expect(buyer.is_company).to be false
    end

    it 'handles lowercase country codes' do
      buyer = Buyer.new(country: 'es')
      expect(buyer.country).to eq('ES')
    end
  end

  describe '#in_eu?' do
    it 'returns true for EU countries' do
      buyer = Buyer.new(country: 'ES')
      expect(buyer.in_eu?).to be true
    end

    it 'returns false for non-EU countries' do
      buyer = Buyer.new(country: 'US')
      expect(buyer.in_eu?).to be false
    end
  end

  describe '#in_spain?' do
    it 'returns true for Spanish buyers' do
      buyer = Buyer.new(country: 'ES')
      expect(buyer.in_spain?).to be true
    end

    it 'returns false for non-Spanish buyers' do
      buyer = Buyer.new(country: 'FR')
      expect(buyer.in_spain?).to be false
    end
  end
end