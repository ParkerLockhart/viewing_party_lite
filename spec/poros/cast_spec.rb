require 'rails_helper'

RSpec.describe Cast do
  it 'exists' do
    data = { name: "Zendaya", character: "Chani"}
    zendaya = Cast.new(data)

    expect(zendaya).to be_instance_of(Cast)
    expect(zendaya.name).to eq("Zendaya")
    expect(zendaya.character).to eq("Chani")
  end
end
