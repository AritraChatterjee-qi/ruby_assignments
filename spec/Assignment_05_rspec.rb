require_relative '../Assignment_05.rb'

RSpec.describe Task do 
  describe "#total_time_in_minute" do
    it "Calculate the total time for a particular class" do 
      task = Task.new( 10, "task10", [["2023-01-01 17:30:00", "2023-01-01 18:30:00"]] )
      output = task.total_time_in_minute
      expect(output).to eq 60
    end
  end

  describe "#occupation_percecntage_day_wise" do
    it "Calculate the total time for a particular class as percentage of a day" do 
      task = Task.new( 10, "task10", [["2023-01-01 17:30:00", "2023-01-01 18:30:00"]] )
      output = task.occupation_percecntage_day_wise(task.total_time_in_minute)
      expect(output).to eq 4.17
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
        it "Tests the input and checks if it is a valid input for not" do
           task = Task.new( 10, "task10", [["2023-01-01 19:30:00", "2023-01-01 18:30:00"]] )
           output = task.valid?
           expect(output).to be false
        end
     end
  end
end

RSpec.describe TaskHandler do 
  describe "#process_input" do
     context "When the input is valid" do
        it "proccess the input and generates the empty output" do
           task_handler = TaskHandler.new
           task_handler.add_one_task({ id: 9, name: "task9", time_logs: [["2023-01-01 18:30:00", "2023-01-01 18:30:00"]] })
           output = task_handler.process_input
           desired_output = { categories: [], total_time_in_min: [], occupation_percecntage: [] }
           expect(output).to eq desired_output
        end
     end

     context "When the input is invalid" do
        it "proccess the input and generates the output report" do
           task_handler = TaskHandler.new
           task_handler.add_one_task({ id: 10, name: "task10", time_logs: [["2023-01-01 17:30:00", "2023-01-01 18:30:00"]] })
           output = task_handler.process_input
           desired_output = { categories: ["task10"], total_time_in_min: [60], occupation_percecntage: [4.17] }
           expect(output).to eq desired_output
        end
     end
  end
end