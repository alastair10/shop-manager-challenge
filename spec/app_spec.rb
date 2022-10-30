require_relative '../app'

def reset_tables
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'shop_manager_test' })
  connection.exec(seed_sql)
end

describe Application do
  before(:each) do 
    reset_tables
  end

  it "returns a list of items in the shop" do
    io = double :io
    expect(io).to receive(:puts).with('Welcome to the shop management program!')
    expect(io).to receive(:puts).with('What do you want to do?')
    expect(io).to receive(:puts).with('1 = list all shop items')
    expect(io).to receive(:puts).with('2 = create a new item')
    expect(io).to receive(:puts).with('3 = list all orders')
    expect(io).to receive(:puts).with('4 = create a new order')
    expect(io).to receive(:gets).and_return('1')
    expect(io).to receive(:puts).with("Here's a list of all shop items:")
    expect(io).to receive(:puts).with('#1 milk - Unit price: 1 - Quantity: 6')
    expect(io).to receive(:puts).with('#2 feta - Unit price: 2 - Quantity: 3')
    expect(io).to receive(:puts).with('#3 broccoli - Unit price: 1 - Quantity: 2')
    expect(io).to receive(:puts).with('#4 chicken - Unit price: 5 - Quantity: 5')
    expect(io).to receive(:puts).with('#5 coffee - Unit price: 7 - Quantity: 4')

    database_name = 'shop_manager_test'
    item_repository = ItemRepository.new
    order_repository = OrderRepository.new

    application = Application.new(database_name, io, item_repository, order_repository)
    application.run
  end
end