class Buyer
    attr_reader :country, :is_company
  
    EU_COUNTRIES = %w[
      AT BE BG HR CY CZ DK EE FI FR DE GR HU IE IT
      LV LT LU MT NL PL PT RO SK SI ES SE
    ].freeze
  
    def initialize(country:, is_company: false)
      @country = country.to_s.upcase
      @is_company = is_company
    end
  
    def in_eu?
      EU_COUNTRIES.include?(@country)
    end
  
    def in_spain?
      @country == 'ES'
    end
  end