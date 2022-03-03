require_relative 'journey'

class Oystercard
  attr_accessor :balance, :journey_list

  MAX_BALANCE = 90

  def initialize(balance =0)
    @balance = balance
    @journey_list = []
    @journey = nil
  end

  def top_up_card(amount)
    check_top_up_doesnt_exceed_max_balance(amount)
    @balance += amount
  end

  def touch_in(station)
    reject_card_if_insufficient_funds_for_journey
    deduct(@journey.calculate_fare) if @journey != nil && @journey.in_journey?
    @journey = Journey.new(station)
    @journey_list << @journey
  end

  def touch_out(station)
    return deduct(Journey::PENALTY_FARE) if @journey == nil || @journey.is_journey_complete?
    @journey.exit_station(station)
    deduct(@journey.calculate_fare)
  end

  private

  def check_top_up_doesnt_exceed_max_balance(amount)
    raise "Top-up unsuccessful - balance cannot exceed £#{MAX_BALANCE}" if (@balance + amount) > MAX_BALANCE 
  end

  def reject_card_if_insufficient_funds_for_journey
    raise "Insufficient balance for journey" if @balance < Journey::FARE
  end

  def deduct(amount)
    @balance -= amount
  end

end
