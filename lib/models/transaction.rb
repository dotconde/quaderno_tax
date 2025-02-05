class Transaction
    attr_reader :type, :buyer, :amount, :service_location
  
    def initialize(type:, buyer:, amount:, service_location: nil)
      @type = validate_type(type)
      @buyer = buyer
      @amount = amount
      @service_location = service_location
    end
  
    private
  
    def validate_type(type)
      valid_types = ['good', 'service']
      raise ArgumentError, "Invalid transaction type: #{type}" unless valid_types.include?(type)
      type
    end
  end