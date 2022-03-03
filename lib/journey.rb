class Journey
  attr_reader :entry_station, :exit_station

  FARE = 1
  PENALTY_FARE = 6

  def initialize(entry_station)
    @entry_station = entry_station
    @exit_station = nil
  end

  def in_journey?
    @exit_station.nil?
  end

  def exit_station(exit_station)
    @exit_station = exit_station
  end

  def is_journey_complete?
    !@exit_station.nil?
  end

  def calculate_fare
    is_journey_complete? ? FARE : PENALTY_FARE
  end

end
