# ITEMS Model and Repository Classes Design Recipe

## 1. Design and create the Table

## 2. Create Test SQL seeds

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)
class Item
end

# Repository class
# (in lib/student_repository.rb)
class ItemRepository
end


## 4. Implement the Model class

class Item
  attr_accessor :id, :name, :price, :quantity
end

```
## 5. Define the Repository Class interface


```ruby

class ItemRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    sql = SELECT id, name, price, quantity FROM items;

    # Returns an array of Item objects.
  end

  def create(item)
    # Executes the SQL query:
    sql = INSERT INTO items (name, price, quantity) VALUES ($1, $2, $3);

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

repo = ItemRepository.new

items = repo.all
expect(items.length).to eq 5
expect(items.first.name).to eq 'milk'
expect(items.first.quantity).to eq 6
expect(items.last.price).to eq 7

# 2 Create Method
# Add an entry to the items table

# 1. Set up what the new item will be...
repo = ItemRepository.new
item = Item.new
item.name = 'tea'
item.price = 3
item.quantity = 10

# 2. Create the new item...
repo.create(item)

# 3. Verify that the new item appears
items = repo.all
last_item = items.last
expect(last_item.name).to eq('tea')
expect(last_item.price).to eq(3)
expect(last_item.quantity).to eq(10)


```

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_items_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._
