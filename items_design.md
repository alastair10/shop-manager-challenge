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
  attr_accessor :id, :item_name, :item_price, :item_quantity
end

```
## 5. Define the Repository Class interface


```ruby

class ItemRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    sql = 'SELECT id, item_name, item_price, item_quantity FROM items;'

    # Returns an array of Item objects.
  end

  def create(item)
    # Executes the SQL query:
    sql = 'INSERT INTO items (item_name, item_price, item_quantity) VALUES ($1, $2, $3);'

    # Returns nothing
  end

end
```

## 6. Write Test Examples


repo = ItemRepository.new

items = repo.all
expect(items.length).to eq 5
expect(items.first.item_name).to eq 'milk'
expect(items.first.item_quantity).to eq 6
expect(items.last.item_price).to eq 7

# 2 Create Method
# Add an entry to the items table

# 1. Set up what the new item will be...
repo = ItemRepository.new
item = Item.new
item.item_name = 'tea'
item.item_price = 3
item.item_quantity = 10

# 2. Create the new item...
repo.create(item)

# 3. Verify that the new item appears
items = repo.all
last_item = items.last
expect(last_item.item_name).to eq('tea')
expect(last_item.item_price).to eq(3)
expect(last_item.item_quantity).to eq(10)


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
