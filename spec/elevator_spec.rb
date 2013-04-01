require 'elevator'

describe Elevator do
  
  before :each do
    @floors = 1..100
    @elevator = Elevator.new @floors
  end
  
  describe "#new" do
    
    context "with no parameters" do
      it "raises an exception" do
        expect { Elevator.new }.to raise_exception
      end
    end
    
    context "with invalid floor range" do
      it "raises an exception" do
        expect { Elevator.new 100 }.to raise_exception
      end
    end
    
    context "with valid floor range" do
      it "creates an elevator" do
        @elevator.floors.should eq(@floors)
      end
    end
    
  end
  
  describe "#call" do
    
    context "with no parameters" do
      it "raises an exception" do
        expect { @elevator.call }.to raise_exception
      end
    end
    
    context "with invalid origin" do
      it "denies attempt to call floor" do
        origin_floor = @floors.last + 1
        direction = -1
        @elevator.call(origin_floor,direction).should be_false
      end
    end
        
    context "with valid origin floor" do 
      it "visits origin floor" do
        origin_floor = 35
        requested_direction = -1
        
        floor_was_visited = false
        
        @elevator.call(origin_floor,requested_direction) do |e|
          floor_was_visited = true
        end
        
        @elevator.run
        
        floor_was_visited.should be_true
        
      end
    end
    
  end
  
  describe "#request" do
    
    context "with invalid destination" do
      it "denies request by returning false" do
        @elevator.request(@floors.first - 1).should be_false
      end
    end
    
    context "with valid destination" do
      it "visits destination" do
        destination = @floors.first
        destination_reached = false
        @elevator.request(destination) do |e|
          destination_reached = true
        end
        
        @elevator.run
        
        destination_reached.should be_true
      end
      
    end
    
  end
  
  describe "#call then #request" do
    
    it "visits both call floor and destination floor" do
      origin = Random.rand(@floors)
      destination = Random.rand(@floors)
      direction = destination - origin
      direction = direction / direction.abs
      
      origin_was_visited = false
      destination_was_visited = false
      
      @elevator.call(origin,direction) do |e|
        origin_was_visited = e.current_floor == origin
        e.request(destination) do |e|
          destination_was_visited = e.current_floor == destination
        end
      end
      
      @elevator.run
      
      origin_was_visited.should be_true
      destination_was_visited.should be_true
    end
    
  end
    
end