require 'item'

class ItemRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    sql = 'SELECT id, name, price, quantity FROM items;'
    result_set = DatabaseConnection.exec_params(sql,[])

    items = []

    result_set.each do |record|
      item = Item.new
      item.name = record['name']
      item.price = record['price'].to_i
      item.quantity = record['quantity'].to_i

      items << item
    end

    # returns an array of Item objects
    return items
  end

  def create(item)
    # Executes the SQL query:
    sql = 'INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3);'
    sql_params = [item.name, item.price, item.quantity]

    DatabaseConnection.exec_params(sql, sql_params)

    # Returns nothing
  end

end