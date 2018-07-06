class CreateSaleService
    attr_reader :sale
  
    def initialize(params:)
      @params = params
      @sale = Sale.new(sale_params)
      @customer = Customer.find_or_create_by(name: params[:customer_name])
      @address = Address.find_or_create_by(name: params[:address])
      @vendor = Vendor.find_or_create_by(name: params[:vendor_name])
    end
  
    def call!
      ActiveRecord::Base.transaction do
        @sale.customer = @customer
        @sale.address = @address
        @sale.vendor = @vendor
        @sale.save!
      end
      @sale
    rescue ActiveRecord::RecordInvalid
      false
    end
  
    private
  
      attr_reader :params

      def sale_params
        @params.except(:customer_name, :vendor_name, :address)
      end
  end
  