require 'oystercard'

describe Oystercard do
  let(:station) { double :station }
  let(:exit_station) { double :exit_station }
  let(:partial_journey) { double :partial_journey }
  # let(:complete_journey) { double(:complete_journey, calculate_fare: 1)}
  let(:journey) { {entry_station: station, exit_station: exit_station} }

  it 'New card instance has a balance of 0' do
    expect(subject.balance).to eq 0
  end

  it 'Oystercard to be topped up by £5' do
    subject.top_up_card(5)
    expect(subject.balance).to eq 5
  end
  
  it 'raises an error when top-up takes balance over £90' do
    max_balance = Oystercard::MAX_BALANCE
    subject.top_up_card(max_balance)
    error_message = "Top-up unsuccessful - balance cannot exceed £#{max_balance}"
    expect { subject.top_up_card(1) }.to raise_error error_message
  end

  it 'refuses entry if balance is below min journey balance' do
    expect { subject.touch_in(station) }.to raise_error "Insufficient balance for journey"    
  end
  
  it 'creates an empty journey list upon initializing new oystercard' do
    expect(subject.journey_list).to be_empty
  end

  context 'oystercard balance has sufficient journey funds' do
    before(:each) do
      subject.balance = 5
    end

 
    it 'oystercard touching out reduces the balance of the oystercard by journey fare' do
      new_journey = double(:new_journey)
      allow(new_journey).to receive(:calculate_fare).and_return(1)
      subject.touch_in(station)
      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-1)
    end

    # it 'when we touch out, we add exit station to the current journey' do
    #   subject.touch_in(station)
    #   subject.touch_out(exit_station)
    #   expect(subject.journey_list).to eq [journey]
    # end

    it 'touch in stores new journey instance into journey list' do
      allow(Journey).to receive(:new).and_return(partial_journey)
      new_journey_list = subject.touch_in('station')
      expect(new_journey_list).to eq([partial_journey])
    end
  end 

end
