require_relative './order'

class OrderRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    sql = 'SELECT id, order_name, order_date FROM orders;'
    result_set = DatabaseConnection.exec_params(sql,[])

    orders = []

    result_set.each {|record|
      order = Order.new
      order.id = record['id']
      order.order_name = record['order_name']
      order.order_date = record['order_date']

      orders << order
    }

    # Returns an array of Order objects.
    return orders
  end

  def create(order)
    # Executes the SQL query:
    sql = 'INSERT INTO orders (order_name, order_date) VALUES ($1, $2);'
    sql_params = [order.order_name, order.order_date]

    DatabaseConnection.exec_params(sql, sql_params)

    # Returns nothing
  end

  def find_by_item(item)
    sql = 'SELECT orders.order_name, orders.order_date
      FROM orders
      JOIN items_orders ON items_orders.order_id = orders.id
      JOIN items ON items_orders.item_id = items.id
      WHERE items.id = $1;'
      sql_params = [item]

      result_set = DatabaseConnection.exec_params(sql, sql_params).values 
      
      first_record = result_set[0]

      order = get_order_info(first_record)

      result_set.each do |record|
        order.order_items << get_order_info(record)
      end

      return order
  end

  private
  
  def get_order_info(record)
    order = Order.new
    order.id = ['order_id']
    order.order_name = ['order_name']
    order.order_date = ['order_date']

    return order

  end

  # def get_item_info(record)
  #   item = Item.new
  #   item.id = record['id'].to_i
  #   item.item_name = record['item_name']
  #   item.item_price = record['item_price'].to_i
  #   item.item_quantity = record['item_quantity'].to_i

  #   return item

  # end


end