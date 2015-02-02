require 'active_record'

class Customer < ActiveRecord::Base
  def purchase
    Purchase.find_by({customer_id: self.id})
  end
end
