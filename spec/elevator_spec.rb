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
        @elevator.call(origin_floor,direction,@floors.first).should be_false
      end
    end
        
    context "with valid origin floor" do 
      it "visits origin floor" do
        origin_floor = 35
        requested_direction = -1
        floor_was_visited = false
        @elevator.call(origin_floor,requested_direction,@floors.first) do
          floor_was_visited = true
        end
        floor_was_visited.should be_true
      end
    end
    
  end
  
  # describe "#request" do
  #   
  #   before :each do
  #     @origin_floor = 35
  #     @direction = -1
  #     @elevator.call(@origin_floor,@direction)
  #   end
  #   
  #   context "with invalid destination" do
  #     it "denies request by returning false" do
  #       @elevator.request(@floors.first - 1).should be_false
  #     end
  #   end
  #   
  #   context "with valid destination" do
  #     it "visits destination" do
  #       destination = 1
  #       @elevator.request(destination)
  #       @elevator.current_floor.should eq(destination)
  #     end
  #   end
  #   
  # end
    
end