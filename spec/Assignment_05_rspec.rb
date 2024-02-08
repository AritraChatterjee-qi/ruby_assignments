require_relative '../Assignment_05.rb'

RSpec.describe Task do 
  describe "#total_time_in_minute" do
    it "Calculate the total time for a particular class" do 
      task = Task.new( 10, "task10", [["2023-01-01 17:30:00", "2023-01-01 18:30:00"]] )
      output = task.total_time_in_minute
      expect(output).to eq 60
    end
  end

  describe "#occupancy_percentage" do

    context "When the occupancy:period is daily" do
      it "Calculate the total time for a particular class as percentage of a day" do 
         task = Task.new( 10, "task10", [["2023-01-01 17:30:00", "2023-01-02 17:30:00"]] )
         output = task.occupancy_percentage(task.total_time_in_minute, "daily")
         expect(output).to eq 100
      end
    end
    
    context "When the occupancy:period is weekly" do
      it "Calculate the total time for a particular class as percentage of a week" do 
         task = Task.new( 10, "task10", [["2023-01-01 17:30:00", "2023-01-08 17:30:00"]] )
         output = task.occupancy_percentage(task.total_time_in_minute, "weekly")
         expect(output).to eq 100
      end
    end

    context "When the occupancy:period is monthly" do
      it "Calculate the total time for a particular class as percentage of a monthly (30 days)" do 
         task = Task.new( 10, "task10", [["2023-01-01 17:30:00", "2023-01-31 17:30:00"]] )
         output = task.occupancy_percentage(task.total_time_in_minute, "monthly")
         expect(output).to eq 100
      end
    end

    context "When the occupancy:period is quartly" do
      it "Calculate the total time for a particular class as percentage of a quarterly (30*3 days)" do 
         task = Task.new( 10, "task10", [["2023-01-01 17:30:00", "2023-04-01 17:30:00"]] )
         output = task.occupancy_percentage(task.total_time_in_minute, "quarterly")
         expect(output).to eq 100
      end
    end

    context "When the occupancy:period is yearly" do
      it "Calculate the total time for a particular class as percentage of a yearly" do 
         task = Task.new( 10, "task10", [["2023-01-01 17:30:00", "2024-01-01 17:30:00"]] )
         output = task.occupancy_percentage(task.total_time_in_minute, "yearly")
         expect(output).to eq 100
      end
    end
   
  end

  describe "#valid?" do
     context "When the input is valid" do
        it "Tests the input and checks if it is a valid input for not" do
          task = Task.new( 10, "task10", [["2023-01-01 17:30:00", "2023-01-01 18:30:00"]] )
          output = task.valid?
          expect(output).to be true
        end
     end

     context "When the input is invalid" do
        context "When the id is invalid" do
         it "Tests the input and checks if the id is nil return false" do
            task = Task.new( nil, "task10", [["2023-01-01 19:30:00", "2023-01-01 18:30:00"]] )
            output = task.valid?
            expect(output).to be false
         end

         it "Tests the input and checks if the id is not Integer return false" do
            task = Task.new( "10", "task10", [["2023-01-01 19:30:00", "2023-01-01 18:30:00"]] )
            output = task.valid?
            expect(output).to be false
         end
        end

        context "When the name is invalid" do
         it "Tests the input and checks if the name is nil return false" do
            task = Task.new( 10, nil, [["2023-01-01 19:30:00", "2023-01-01 18:30:00"]] )
            output = task.valid?
            expect(output).to be false
         end

         it "Tests the input and checks if the name is not String return false" do
            task = Task.new( 10, 10, [["2023-01-01 19:30:00", "2023-01-01 18:30:00"]] )
            output = task.valid?
            expect(output).to be false
         end
        end

        context "When the time_logs is invalid" do
         it "Tests the input and checks if the time_logs is nil return false" do
            task = Task.new( 10, "task10", nil )
            output = task.valid?
            expect(output).to be false
         end

         it "Tests the input and checks if the time_logs is not Array return false" do
            task = Task.new( 10, "task10", "10" )
            output = task.valid?
            expect(output).to be false
         end
        end

        context "When the time_log is invalid" do
         it "Tests the input and checks if the time_log is not Array return false" do
            task = Task.new( 10, "task10", ["10"] )
            output = task.valid?
            expect(output).to be false
         end

         it "Tests the input and checks if the time_log length is not 2 return false" do
            task = Task.new( 10, "task10", [["10"]] )
            output = task.valid?
            expect(output).to be false
         end

         it "Tests the input and checks if both the start_tiime and end_time are not strings return false" do
            task = Task.new( 10, "task10", [[10, 10]] )
            output = task.valid?
            expect(output).to be false
         end

         it "Tests the input and checks if both the start_tiime and end_time are valid format not" do
            task = Task.new( 10, "task10", [["2023-01-01  19:30:00", "2023-01-01 25:30:00"]] )
            output = task.valid?
            expect(output).to be false
         end

         it "Tests the input and checks if both the start_tiime and end_time are valid input for not" do
            task = Task.new( 10, "task10", [["2023-01-01 19:30:00", "2023-01-01 18:30:00"]] )
            output = task.valid?
            expect(output).to be false
         end
        end
     end
  end
end

RSpec.describe TaskHandler do 
  describe "#add_task" do
    context "When the ids are duplicate" do
      it "if the add_task gets duplicate ids raise error" do
         task_handler = TaskHandler.new
         task_handler.add_task({ id: 9, name: "task9", time_logs: [["2023-01-01 17:30:00", "2023-01-01 18:30:00"]] })
         expect { task_handler.add_task({ id: 9, name: "task9", time_logs: [["2023-01-01 17:30:00", "2023-01-01 18:30:00"]] }) }.to raise_error("Task with id: 9 alredy present") 
      end
    end
  end
  
  describe "#add_tasks" do
    context "When the ids are duplicate" do
      it "if the add_tasks gets duplicate ids raise error" do
         task_handler = TaskHandler.new
         expect { task_handler.add_tasks([{ id: 9, name: "task9", time_logs: [["2023-01-01 17:30:00", "2023-01-01 18:30:00"]] }, { id: 9, name: "task9", time_logs: [["2023-01-01 17:30:00", "2023-01-01 18:30:00"]] }]) }.to raise_error("Task with id: 9 alredy present")
      end
    end
  end

  describe "#process_input" do
     context "When the input is valid" do
        it "proccess the input and generates the empty output" do
           task_handler = TaskHandler.new
           task_handler.add_task({ id: 9, name: "task9", time_logs: [["2023-01-01 18:30:00", "2023-01-01 18:30:00"]] })
           output = task_handler.process_input({period: "daily"})
           desired_output = { categories: [], total_time_in_min: [], period: "daily", occupancy_percentage: [] }
           expect(output).to eq desired_output
        end
     end

     context "When the input is invalid" do
        it "proccess the input and generates the output report" do
           task_handler = TaskHandler.new
           task_handler.add_task({ id: 10, name: "task10", time_logs: [["2023-01-01 17:30:00", "2023-01-01 18:30:00"]] })
           output = task_handler.process_input({period: "daily"})
           desired_output = { categories: ["task10"], total_time_in_min: [60], period: "daily", occupancy_percentage: [4.17] }
           expect(output).to eq desired_output
        end
     end
  end
end