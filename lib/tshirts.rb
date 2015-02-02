require 'active_record'

class Tshirt < ActiveRecord::Base
  def purchase
    Purchase.where({tshirt_id: self.id})
  end
end
