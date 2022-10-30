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
    else
      @io.puts "Do this next!"
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