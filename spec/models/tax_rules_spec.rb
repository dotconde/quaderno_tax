require 'spec_helper'
require_relative '../../lib/models/tax_rules'

RSpec.describe TaxRules do
  describe '.get_vat_rate' do
    it 'returns Spanish VAT rate for ES' do
      expect(TaxRules.get_vat_rate('ES')).to eq(21.0)
    end

    it 'returns correct VAT rates for EU countries' do
      expect(TaxRules.get_vat_rate('DE')).to eq(19.0)  # Germany
      expect(TaxRules.get_vat_rate('FR')).to eq(20.0)  # France
      expect(TaxRules.get_vat_rate('IT')).to eq(22.0)  # Italy
    end

    it 'returns 0 for non-EU countries' do
      expect(TaxRules.get_vat_rate('US')).to eq(0.0)
      expect(TaxRules.get_vat_rate('JP')).to eq(0.0)
      expect(TaxRules.get_vat_rate('PER')).to eq(0.0)
    end

    it 'handles lowercase country codes' do
      expect(TaxRules.get_vat_rate('es')).to eq(21.0)
      expect(TaxRules.get_vat_rate('de')).to eq(19.0)
    end
  end
end