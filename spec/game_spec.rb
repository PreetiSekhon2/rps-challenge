require "game.rb"

describe Game do

  let(:john){double :john, :get_name => "John", :get_score => 10}
  let(:jane){double :jane, :get_name => "Jane", :get_score => 20}
  let(:jack){double :jack, :get_name => "Jack", :get_score => 10}

  let(:round){double :round, :calc_winner => john, :winner => true, :player_plays => true}

  before(:each) do
    # subject(:game){described_class}
    subject.assign_players([john,jane])
  end

  it "player 1 plays" do
    subject.start_round(round)
    expect(round).to receive(:player_plays)
    subject.player_plays(john,"rock")
  end

  it "finishes a round" do
    subject.start_round(round)
    expect(round).to receive(:calc_winner)
    subject.finish_round()
  end

  it "shows rounds played" do
    subject.start_round(round)
    subject.finish_round()
    expect(subject.rounds_played).to eq 1
  end

  it "finishes a game and declares a winner" do
    expect(subject.finish_game).to eq [jane]
  end

  it "finishes a game and declares a tie" do
    subject.assign_players([john,jack])
    expect{subject.finish_game}.to raise_error("Its a Tie")
  end

end
