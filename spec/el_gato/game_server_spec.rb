require 'spec_helper'

describe ElGato::GameServer do
  it 'should allow only 1 game per player' do
    expect(subject.play('P1')).to eq({ status: :queued })
    expect(subject.games('P1')).to eq []

    expect(subject.play('P1')).to eq({ status: :queued })
    expect(subject.games('P1')).to eq []
  end

  it 'should allow a player returning to the active game' do
    expect(subject.play('P1')).to eq({ status: :queued })
    expect(subject.play('P2')[:status]).to eq :ready
    expect(subject.play('P1')).to eq subject.play 'P2'
    expect(subject.play('P2')[:id]).to_not be_nil
  end
end


