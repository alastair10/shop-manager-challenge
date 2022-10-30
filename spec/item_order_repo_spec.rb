require 'item_order_repo'

def reset_joins_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemOrderRepository do
  before(:each) do 
    reset_joins_table
  end

  context "All method test" do
    it "returns all items on join table" do
      repo = ItemOrderRepository.new

      joins = repo.all
      expect(joins.length).to eq 9
      expect(joins.first.item_id).to eq 5
      expect(joins.first.order_id).to eq 1
      expect(joins.last.item_id).to eq 3
      expect(joins.last.order_id).to eq 5
    end
  end
  
  context "Create method test" do
    xit "creates a new join record" do

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
    end
  end    
end