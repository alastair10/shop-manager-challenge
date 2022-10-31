require 'order_repo'

def reset_orders_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe OrderRepository do
  before(:each) do 
    reset_orders_table
  end

  context "All Method" do 
    it "returns all orders" do
      repo = OrderRepository.new

      items = repo.all
      expect(items.length).to eq 5
      expect(items.first.order_name).to eq 'alastair'
      expect(items.first.order_date).to eq '2022-05-01'
      expect(items.last.order_date).to eq '2022-08-01'
      expect(items.last.order_name).to eq 'dad'
    end
  end

  context "Create Method" do 
    it "creates a new orders" do
     
      # 1. Set up what the new item will be...
      repo = OrderRepository.new
      order = Order.new
      order.order_name = 'Mickey Mouse'
      order.order_date = '2023-01-01'

      # 2. Create the new item...
      repo.create(order)

      # 3. Verify that the new item appears
      orders = repo.all
      last_order = orders.last
      expect(last_order.order_name).to eq('Mickey Mouse')
      expect(last_order.order_date).to eq('2023-01-01')
    end
  end

  context "finds related orders" do
    it "finds all orders containing coffee" do
      repo = OrderRepository.new
      
      order = repo.find_by_item(5)

      expect(order.order_items.length).to eq 2
    
    end
  end

end