require 'spec_helper'

describe ElGato::GameServer do
  it 'should handle multiple games' do
    subject.add_player 'P1'
    subject.add_player 'P2'
    subject.add_player 'P3'

    expect(subject.waiting_players).to have(1).item

    expect(subject.games 'P1').to eq subject.games('P2')
    expect(subject.games 'P3').to_not eq subject.games('P2')
    expect(subject.games 'P3').to_not eq subject.games('P1')

    expect(subject.games 'P1').to have(1).items
    expect(subject.games 'P2').to have(1).items
    expect(subject.games 'P3').to have(0).items
  end
end


