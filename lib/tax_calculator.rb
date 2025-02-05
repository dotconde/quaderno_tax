# lib/services/tax_calculator.rb
class TaxCalculator
    def calculate(transaction)
      case transaction.type
      when 'good'
        calculate_goods_tax(transaction)
      when 'service'
        case transaction.service_type
        when 'digital'
          calculate_digital_service_tax(transaction)
        when 'onsite'
          calculate_onsite_service_tax(transaction)
        end
      end
    end
  
    private
  
    def calculate_goods_tax(transaction)
      if transaction.buyer.in_spain?
        { rate: TaxRules.get_vat_rate('ES'), type: 'vat' }
      elsif transaction.buyer.in_eu?
        if transaction.buyer.is_company
          { rate: 0, type: 'reverse_charge' }
        else
          { rate: TaxRules.get_vat_rate(transaction.buyer.country), type: 'vat' }
        end
      else
        { rate: 0, type: 'export' }
      end
    end
  
    def calculate_digital_service_tax(transaction)
      if transaction.buyer.in_spain?
        { rate: TaxRules.get_vat_rate('ES'), type: 'vat' }
      elsif transaction.buyer.in_eu?
        if transaction.buyer.is_company
          { rate: 0, type: 'reverse_charge' }
        else
          { rate: TaxRules.get_vat_rate(transaction.buyer.country), type: 'vat' }
        end
      else
        { rate: 0, type: 'no_tax' }
      end
    end
  
    def calculate_onsite_service_tax(transaction)
      if transaction.service_location == 'ES'
        { rate: TaxRules.get_vat_rate('ES'), type: 'vat' }
      else
        { rate: 0, type: 'no_tax' }
      end
    end
  end