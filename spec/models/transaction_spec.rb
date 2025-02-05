require 'spec_helper'
require_relative '../../lib/models/transaction'

RSpec.describe Transaction do
  let(:buyer) { double('buyer', country: 'ES', is_company: false) }
  
  describe '#initialize' do
    it 'creates a valid transaction with type good' do
      transaction = Transaction.new(type: 'good', buyer: buyer, amount: 100)
      expect(transaction.type).to eq('good')
    end

    it 'creates a valid transaction with type service' do
      transaction = Transaction.new(type: 'service', buyer: buyer, amount: 100)
      expect(transaction.type).to eq('service')
    end

    it 'raises error for invalid transaction type' do
      expect {
        Transaction.new(type: 'invalid', buyer: buyer, amount: 100)
      }.to raise_error(ArgumentError, "Invalid transaction type: invalid")
    end
  end
end