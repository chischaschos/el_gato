require 'spec_helper'

describe ElGato::GameServer do
  it 'should handle multiple games' do
    subject.add_player 'P1'
    subject.add_player 'P2'
    subject.add_player 'P3'

    expect(subject.games).to have(2).items
  end
end


