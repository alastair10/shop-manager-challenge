# file: app.rb

require_relative 'lib/database_connection'
require_relative 'lib/item_repo'
require_relative 'lib/order_repo'

class Application
  # We need to give the database name to the method `connect`.

  def initialize(database_name, io, item_repo, order_repo)
  #   DatabaseConnection.connect('shop_manager')
    DatabaseConnection.connect(database_name)
    @io = io
    @item_repo = item_repo
    @order_repo = order_repo

  # # Perform a SQL query on the database and get the result set.
  # sql = 'SELECT id, title FROM albums;'
  # result = DatabaseConnection.exec_params(sql, [])

  # # Print out each record from the result set .
  # result.each do |record|
  #   p record
  end

  def run
    # runs the terminal application
    @io.puts 'Welcome to the shop management program!'
    @io.puts 'What do you want to do?'
    @io.puts '1) list all shop items'
    @io.puts '2) create a new item'
    @io.puts '3) list all orders'
    @io.puts '4) create a new order'
    @io.puts '5) find orders by item'
    input = @io.gets.chomp

    if input == '1'
      @io.puts "Here's a list of all shop items:"

      result_set = @item_repo.all

      result_set.each do |item|
        @io.puts "#{item.id}) #{item.item_name} - Unit price: #{item.item_price} - Quantity: #{item.item_quantity}"
      end

    elsif input =='2'
      @io.puts "Do this next!"

    elsif input == '3'
      @io.puts "Here's a list of all shop orders:"

      # orders = @order_repo.all
      # items = @items_repo.all
      # item_order

      result_set =  @order_repo.all

      result_set.each do |order|
        @io.puts "#{order.id}) Date: #{order.order_date} - Name: #{order.order_name}"
      end

    elsif input == '4'
      @io.puts "Do this next!"

    else
      @io.puts 'Which item would you like to search for? (Enter: 1-5)'
      item = @io.gets.chomp
      @io.puts 'These are the orders that contain this item:'

      # sql = 'SELECT orders.order_name, orders.order_date
      # FROM orders
      # JOIN items_orders ON items_orders.order_id = orders.id
      # JOIN items ON items_orders.item_id = items.id
      # WHERE items.id = $1;'
      # result_set = DatabaseConnection.exec_params(sql, [item])
      # result_set.each do |record|
      #   puts record.values.join(" - ")
      result = @order_repo.find_by_item('5')
      puts result.order_name
      #end
    end
  end
end

if __FILE__ == $0
  app = Application.new(
    'shop_manager',
    Kernel,
    ItemRepository.new,
    OrderRepository.new,
  )
  app.run
end