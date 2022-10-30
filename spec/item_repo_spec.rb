require 'item_repo'


def reset_items_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe ItemRepository do
  before(:each) do 
    reset_items_table
  end

  context "all Method" do
    it "returns a list of all items in the shop" do
      repo = ItemRepository.new
      items = repo.all
      expect(items.length).to eq 5
      expect(items.first.name).to eq 'milk'
      expect(items.first.quantity).to eq 6
      expect(items.last.price).to eq 7
    end
  end

  context "Create Method" do
    xit "creates a new item in the shop" do
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
    end
  end
end