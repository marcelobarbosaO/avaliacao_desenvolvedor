require 'rails_helper'

describe Sale do
  describe '#save' do
    before do
      @customer = Customer.create!(customer_params)
      @address = Address.create!(address_params)
      @vendor = Vendor.create!(vendor_params)
      @sale = Sale.new(sale_params.merge({ 
        customer: @customer, address: @address, vendor: @vendor
      }))
    end

    context 'validates' do
      context 'with customer and address and vendor' do
        it 'create sale' do
          expect{
            @sale.save!
          }.to change { Sale.count }.by(1)
        end

        it 'sale is valid' do 
          expect(@sale.valid?).to be_truthy
        end
      end

      context 'without customer' do
        before do
          @sale_without_customer = Sale.new(sale_params.merge({ 
            address: @address, vendor: @vendor
          }))
        end

        it 'does not creates sale' do 
          expect {
            @sale_without_customer.save
          }.to change { Sale.count }.by(0)
        end

        it 'sale is invalid' do 
          expect(@sale_without_customer.valid?).to be_falsey
        end
      end

      context 'without address' do
        before do
          @sale_without_address = Sale.new(sale_params.merge({ 
            customer: @customer, vendor: @vendor
          }))
        end
        
        it 'does not creates sale' do 
          expect {
            @sale_without_address.save
          }.to change { Sale.count }.by(0)
        end

        it 'sale is invalid' do 
          expect(@sale_without_address.valid?).to be_falsey
        end
      end

      context 'without vendor' do
        before do
          @sale_without_vendor = Sale.new(sale_params.merge({ 
            customer: @customer, address: @address
          }))
        end
        
        it 'does not creates sale' do 
          expect {
            @sale_without_vendor.save
          }.to change { Sale.count }.by(0)
        end

        it 'sale is invalid' do 
          expect(@sale_without_vendor.valid?).to be_falsey
        end
      end
    end
  end

  def sale_params
    { description: 'Oferta nova de Cereal', quantity: 6, unit_price: 10.0}
  end

  def customer_params
    { name: "João Pedro" }
  end

  def address_params
    { name: "Rua Almirante Saboia" }
  end

  def vendor_params
    { name: "Bob's" }
  end
end
