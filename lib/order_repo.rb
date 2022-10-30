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
end