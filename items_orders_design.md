# JOIN Model and Repository Classes Design Recipe

## 1. Design and create the Table

## 2. Create Test SQL seeds

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)
class ItemOrder
end

# Repository class
# (in lib/student_repository.rb)
class ItemOrderRepository
end


## 4. Implement the Model class

class ItemOrder
  attr_accessor :item_id, :order_id
end

```
## 5. Define the Repository Class interface


```ruby

class ItemOrderRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    sql = SELECT item_id, order_id FROM items_orders;

    # Returns an array of ItemOrder objects.
  end

  def create(itemorder)
    # Executes the SQL query:
    sql = INSERT INTO items_orders (item_id, order_id) VALUES ($1, $2);

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

repo = ItemOrderRepository.new

joins = repo.all
expect(joins.length).to eq 9
expect(joins.first.item_id).to eq 5
expect(joins.first.order_id).to eq 1
expect(joins.last.item_id).to eq 3
expect(joins.last.order_id).to eq 5

# 2 Create Method
# Add an entry to the joins table

# 1. Set up what the new join will be...
repo = ItemOrderRepository.new
join = ItemOrder.new
join.item_id = 6
join.order_id = 1

# 2. Create the new ...
repo.create(join)

# 3. Verify that the new join appears
join = repo.all
last_item = join.last
expect(last_item.item_id).to eq 6
expect(last_item.order_id).to eq 1

```

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_joins_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemOrderRepository do
  before(:each) do 
    reset_joins_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
