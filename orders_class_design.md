# ORDERS Model and Repository Classes Design Recipe

## 1. Design and create the Table

## 2. Create Test SQL seeds

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)
class Order
end

# Repository class
# (in lib/student_repository.rb)
class OrderRepository
end


## 4. Implement the Model class

class Order
  attr_accessor :id, :order_name, :order_date, :order_time
end

```
## 5. Define the Repository Class interface


```ruby

class OrderRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    sql = 'SELECT id, order_name, order_date, order_time FROM orders;'

    # Returns an array of Item objects.
  end

  def create(order)
    # Executes the SQL query:
    sql = 'INSERT INTO orders (order_name, order_date, order_time) VALUES ($1, $2, $3);'

    # Returns nothing
  end

end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1 All Method
# Get all items

repo = OrderRepository.new

items = repo.all
expect(items.length).to eq 5
expect(items.first.order_name).to eq 'alastair'
expect(items.first.order_date).to eq 1985-05-01
expect(items.last.order_time).to eq 12:15:00
expect(items.last.order_date).to eq 1948-08-01
expect(items.last.order_name).to eq 'dad'

# 2 Create Method
# Add an entry to the items table

# 1. Set up what the new item will be...
repo = OrderRepository.new
order = Order.new
order.order_name = 'Mickey Mouse'
order.order_date = 2023-01-01
order.order_time = 13:15:00

# 2. Create the new item...
repo.create(order)

# 3. Verify that the new item appears
orders = repo.all
last_order = orders.last
expect(last_order.order_name).to eq('Mickey Mouse')
expect(last_order.order_date).to eq(2023-01-01)
expect(last_order.order_time).to eq(13:15:00)


```

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_orders_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
