class Elevator
  
  attr_reader :floors, :current_floor
  
  def initialize(floor_range)
    @floors = floor_range
    @current_floor = @floors.first
    @current_direction = 0
    @queue = []
  end
  
  def call(origin,direction,destination,&block)
    if visits_floor? origin
      add_pickup origin,direction,destination,block
      process_queue()
      return true
    end
    false
  end
  
  def request(destination,callback)
    if visits_floor?(destination)
      add_destination destination,callback
    end
    false
  end
  
  def visits_floor?(floor)
    @floors.include? floor
  end
  
  private
  
  def add_destination floor,callback
    @queue.push([floor,callback])
  end
  
  def add_pickup floor,direction,destination,callback
    @queue.push([floor,direction,destination,callback])
  end
  
  def move_to floor
    @current_floor = floor
  end
  
  def process_queue
    while !@queue.empty? do
      action = @queue.shift
      move_to(action[0])
      if action.size > 2
        request action[2],action[3]
      else
        action[1].call()
      end
    end
  end
  
end