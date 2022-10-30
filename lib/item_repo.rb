require_relative './item'

class ItemRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    sql = 'SELECT id, item_name, item_price, item_quantity FROM items;'
    result_set = DatabaseConnection.exec_params(sql,[])

    items = []

    result_set.each do |record|
      item = Item.new
      item.id = record['id'].to_i
      item.item_name = record['item_name']
      item.item_price = record['item_price'].to_i
      item.item_quantity = record['item_quantity'].to_i

      items << item
    end

    # returns an array of Item objects
    return items
  end

  def create(item)
    # Executes the SQL query:
    sql = 'INSERT INTO items (item_name, item_price, item_quantity) VALUES ($1, $2, $3);'
    sql_params = [item.item_name, item.item_price, item.item_quantity]

    DatabaseConnection.exec_params(sql, sql_params)

    # Returns nothing
  end

end