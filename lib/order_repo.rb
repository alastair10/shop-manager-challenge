require_relative './order'

class OrderRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    sql = 'SELECT id, order_name, order_date, order_time FROM orders;'
    result_set = DatabaseConnection.exec_params(sql,[])

    orders = []

    result_set.each {|record|
      order = Order.new
      order.order_name = record['order_name']
      order.order_date = record['order_date']
      order.order_time = record['order_time']

      orders << order
    }

    # Returns an array of Order objects.
    return orders
  end

  def create(order)
    # Executes the SQL query:
    sql = 'INSERT INTO orders (order_name, order_date, order_time) VALUES ($1, $2, $3);'
    sql_params = [order.order_name, order.order_date, order.order_time]

    DatabaseConnection.exec_params(sql, sql_params)

    # Returns nothing
  end
end