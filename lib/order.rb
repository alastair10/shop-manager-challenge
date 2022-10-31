class Order
  attr_accessor :id, :order_name, :order_date, :order_items

  def initialize
    @order_items = []
  end
end