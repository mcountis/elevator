class Elevator
  
  attr_reader :floors, :current_floor
  
  def initialize(floor_range)
    @floors = floor_range
    @current_floor = @floors.first
    @current_direction = 0
    @queue = []
  end
  
  def call(origin,direction,&block)
    if visits_floor? origin
      add_pickup origin,direction,block
      return true
    end
    false
  end
  
  def request(destination,&block)
    if visits_floor?(destination)
      add_destination destination,block
      return true
    end
    false
  end
  
  def visits_floor?(floor)
    @floors.include? floor
  end
  
  def run
    process_queue
  end
  
  private
  
  def add_destination floor,callback
    @queue.push([floor,callback])
  end
  
  def add_pickup floor,direction,callback
    @queue.push([floor,callback])
  end
  
  def move_to floor
    @current_floor = floor
  end
  
  def process_queue
    
    while !@queue.empty? do
      stop = @queue.shift
      
      move_to(stop[0])
      
      if stop[1]
        stop[1].call(self)
      end
      
    end
  end
  
end
