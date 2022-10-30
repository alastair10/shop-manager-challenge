require 'item_order'

class ItemOrderRepository

  def all
    # Executes the SQL query:
    sql = 'SELECT item_id, order_id FROM items_orders;'
    result_set = DatabaseConnection.exec_params(sql,[])

    itemorders = []

    result_set.each {|record|
      itemorder = ItemOrder.new
      itemorder.item_id = record['item_id'].to_i
      itemorder.order_id = record['order_id'].to_i

      itemorders << itemorder
    }
    # Returns an array of ItemOrder objects.
    return itemorders
  end

  def create(itemorder)
    # Executes the SQL query:
    sql = 'INSERT INTO items_orders (item_id, order_id) VALUES ($1, $2);'
    sql_params = [itemorder.item_id, itemorder.order_id]

    DatabaseConnection.exec_params(sql, sql_params)

    # Returns nothing
  end

end