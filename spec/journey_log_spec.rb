require 'journey_log'

describe JourneyLog do
  subject(:log) { JourneyLog.new(journey_class) }
  let(:journey_class) { double(:journey_class, :is_journey_complete? => false, entry_station: true, :in_journey? => true) }

  it 'JourneyLog is initialised with an argument' do
    expect { log }.to_not raise_error
  end

  it 'JourneyLog responds to start_journey' do
    expect(log).to respond_to(:start_journey).with(1).argument
  end

  it 'JourneyLog responds to start_journey' do
    expect(log).to respond_to(:end_journey).with(1).argument
  end

  it 'JourneyLog initialises with an journey list array' do
    expect(log.journey_list).to be_a(Array)
  end

  it 'JourneyLog initialises with an empty journey list array' do
    expect(log.journey_list).to be_empty
  end

  context 'Start Journey' do
    let(:new_journey) { double(:new_journey, entry_station: true, :in_journey? => true) }
    let(:station) { double :station }
    before do
      allow(log).to receive(:current_journey).and_return(journey_class)
      allow(Journey).to receive(:new).and_return(new_journey)
      log.start_journey(station)      
    end

    it 'pushes previous incomplete journey into journey list' do
      expect(log.journey_list).to eq([journey_class])
    end

    it 'creates new journey instance' do
      expect(log.journey).to eq(new_journey)
    end   

  end

end
