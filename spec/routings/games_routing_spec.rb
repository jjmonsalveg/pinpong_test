require 'rails_helper'

RSpec.describe 'routes for Games', type: :routing do
  it 'routes GET games' do
    expect(get: '/games').to route_to(controller: 'games', action: 'index')
  end

  it 'routes GET games' do
    expect(get: '/games/1').to route_to(controller: 'games', action: 'show',
                                        id: '1')
  end

  it 'routes POST games' do
    expect(post: '/games').to route_to(controller: 'games', action: 'create')
  end
end
