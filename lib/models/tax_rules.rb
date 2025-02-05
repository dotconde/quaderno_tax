class TaxRules
    VAT_RATES = {
      # Standard VAT rates for all EU member states (as of 2024)
      'AT' => 20.0, # Austria
      'BE' => 21.0, # Belgium
      'BG' => 20.0, # Bulgaria
      'HR' => 25.0, # Croatia
      'CY' => 19.0, # Cyprus
      'CZ' => 21.0, # Czech Republic
      'DK' => 25.0, # Denmark
      'EE' => 20.0, # Estonia
      'FI' => 24.0, # Finland
      'FR' => 20.0, # France
      'DE' => 19.0, # Germany
      'GR' => 24.0, # Greece
      'HU' => 27.0, # Hungary
      'IE' => 23.0, # Ireland
      'IT' => 22.0, # Italy
      'LV' => 21.0, # Latvia
      'LT' => 21.0, # Lithuania
      'LU' => 17.0, # Luxembourg
      'MT' => 18.0, # Malta
      'NL' => 21.0, # Netherlands
      'PL' => 23.0, # Poland
      'PT' => 23.0, # Portugal
      'RO' => 19.0, # Romania
      'SK' => 20.0, # Slovakia
      'SI' => 22.0, # Slovenia
      'ES' => 21.0, # Spain (Main VAT)
      'SE' => 25.0  # Sweden
    }.freeze
  
    def self.get_vat_rate(country_code)
      VAT_RATES[country_code.to_s.upcase] || 0.0
    end
  end