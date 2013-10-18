require 'spec_helper'

describe ElGato::Game do
  it 'adds a player to the game' do
    expect(subject.add_player('p1')).to be_true
    expect(subject.add_player('p1')).to be_false
    expect(subject.add_player('p2')).to be_true
    expect(subject.add_player('p3')).to be_false
  end
end
