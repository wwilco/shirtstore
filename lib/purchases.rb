require 'active_record'

class Purchases < ActiveRecord::Base
  def customer
    Customer.find_by({customer_id: self.id})
  end

  def tshirt
    Tshirt.find_by({tshirt_id: self.id})
  end

end
