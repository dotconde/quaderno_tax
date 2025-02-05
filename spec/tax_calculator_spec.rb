require 'spec_helper'
require_relative '../../lib/services/tax_calculator'

RSpec.describe TaxCalculator do
  let(:calculator) { TaxCalculator.new }
  
  let(:spanish_individual) { double('Buyer', country: 'ES', is_company: false, in_spain?: true, in_eu?: true) }
  let(:eu_individual) { double('Buyer', country: 'FR', is_company: false, in_spain?: false, in_eu?: true) }
  let(:eu_company) { double('Buyer', country: 'DE', is_company: true, in_spain?: false, in_eu?: true) }
  let(:non_eu_buyer) { double('Buyer', country: 'US', is_company: false, in_spain?: false, in_eu?: false) }

  describe '#calculate for goods' do
    context 'when buyer is in Spain' do
      it 'applies Spanish VAT' do
        transaction = double('Transaction', type: 'good', buyer: spanish_individual)
        result = calculator.calculate(transaction)
        expect(result).to eq({ rate: 21.0, type: 'vat' })
      end
    end

    context 'when buyer is EU individual' do
      it 'applies local VAT rate' do
        transaction = double('Transaction', type: 'good', buyer: eu_individual)
        result = calculator.calculate(transaction)
        expect(result).to eq({ rate: 20.0, type: 'vat' })
      end
    end

    context 'when buyer is EU company' do
      it 'applies reverse charge' do
        transaction = double('Transaction', type: 'good', buyer: eu_company)
        result = calculator.calculate(transaction)
        expect(result).to eq({ rate: 0, type: 'reverse_charge' })
      end
    end

    context 'when buyer is outside EU' do
      it 'marks as export' do
        transaction = double('Transaction', type: 'good', buyer: non_eu_buyer)
        result = calculator.calculate(transaction)
        expect(result).to eq({ rate: 0, type: 'export' })
      end
    end
  end

  describe '#calculate for digital services' do
    context 'when buyer is in Spain' do
      it 'applies Spanish VAT' do
        transaction = double('Transaction', 
          type: 'service', 
          service_type: 'digital', 
          buyer: spanish_individual
        )
        result = calculator.calculate(transaction)
        expect(result).to eq({ rate: 21.0, type: 'vat' })
      end
    end

    context 'when buyer is EU individual' do
      it 'applies local VAT rate' do
        transaction = double('Transaction', 
          type: 'service', 
          service_type: 'digital', 
          buyer: eu_individual
        )
        result = calculator.calculate(transaction)
        expect(result).to eq({ rate: 20.0, type: 'vat' })
      end
    end

    context 'when buyer is EU company' do
      it 'applies reverse charge' do
        transaction = double('Transaction', 
          type: 'service', 
          service_type: 'digital', 
          buyer: eu_company
        )
        result = calculator.calculate(transaction)
        expect(result).to eq({ rate: 0, type: 'reverse_charge' })
      end
    end

    context 'when buyer is outside EU' do
      it 'applies no tax' do
        transaction = double('Transaction', 
          type: 'service', 
          service_type: 'digital', 
          buyer: non_eu_buyer
        )
        result = calculator.calculate(transaction)
        expect(result).to eq({ rate: 0, type: 'no_tax' })
      end
    end
  end

  describe '#calculate for onsite services' do
    context 'when service is provided in Spain' do
      it 'applies Spanish VAT regardless of buyer location or type' do
        transaction = double('Transaction', 
          type: 'service', 
          service_type: 'onsite', 
          service_location: 'ES',
          buyer: spanish_individual
        )
        result = calculator.calculate(transaction)
        expect(result).to eq({ rate: 21.0, type: 'vat' })

        transaction = double('Transaction', 
          type: 'service', 
          service_type: 'onsite', 
          service_location: 'ES',
          buyer: eu_individual
        )
        result = calculator.calculate(transaction)
        expect(result).to eq({ rate: 21.0, type: 'vat' })

        transaction = double('Transaction', 
          type: 'service', 
          service_type: 'onsite', 
          service_location: 'ES',
          buyer: non_eu_buyer
        )
        result = calculator.calculate(transaction)
        expect(result).to eq({ rate: 21.0, type: 'vat' })
      end
    end

    context 'when service is provided outside Spain' do
      it 'applies no tax' do
        transaction = double('Transaction', 
          type: 'service', 
          service_type: 'onsite', 
          service_location: 'FR',
          buyer: spanish_individual
        )
        result = calculator.calculate(transaction)
        expect(result).to eq({ rate: 0, type: 'no_tax' })
      end
    end
  end
end