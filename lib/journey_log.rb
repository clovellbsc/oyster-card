require_relative 'journey'

class JourneyLog
  attr_reader :journey_list, :journey

  def initialize(journey_class)
    @journey = journey_class
    @journey_list = []
  end

  def start_journey(station)
    @journey_list << @journey if current_journey.in_journey?
    @journey = Journey.new
    @journey.entry_station(station)
  end

  def end_journey(station)

  end

  private

  def current_journey
    return @journey if @journey.in_journey?
    Journey.new
  end

end


# @journey = Journey.new(station) #journey_log
# @journey_list << @journey #journeyLog

# @journey.exit_station(station) #JourneyLog