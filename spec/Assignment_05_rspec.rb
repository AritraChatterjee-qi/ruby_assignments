require_relative '../Assignment_05.rb'

RSpec.describe Task do 
    context "When testing the Task class" do 
      
      it "Testing total_time_in_minute method of the class" do 
         task = Task.new( 10, "task10", [["2023-01-01 17:30:00", "2023-01-01 18:30:00"]] )
         output = task.total_time_in_minute
         expect(output).to eq 60
      end
      it "Testing occupation_percecntage_day_wise method of the class" do 
         task = Task.new( 10, "task10", [["2023-01-01 17:30:00", "2023-01-01 18:30:00"]] )
         output = task.occupation_percecntage_day_wise(task.total_time_in_minute)
         expect(output).to eq 4.17
      end
      it "Testing valid? - test_01 of the class" do 
         task = Task.new( 10, "task10", [["2023-01-01 17:30:00", "2023-01-01 18:30:00"]] )
         output = task.valid?
         expect(output).to be true
      end
      it "Testing valid? - test_01 of the class" do 
         task = Task.new( 10, "task10", [["2023-01-01 19:30:00", "2023-01-01 18:30:00"]] )
         output = task.valid?
         expect(output).to be false
      end
      
   end
end

RSpec.describe TaskHandler do 
  context "When testing the Task Handler class" do 
     
     it "Testing process_input -- 01 method of the class" do 
        task_handler = TaskHandler.new
        task_handler.add_one_task({ id: 9, name: "task9", time_logs: [["2023-01-01 18:30:00", "2023-01-01 18:30:00"]] })
        output = task_handler.process_input
        desired_output = { categories: [], total_time_in_min: [], occupation_percecntage: [] }
        expect(output).to eq desired_output
     end
     it "Testing process_input -- =2 method of the class" do 
        task_handler = TaskHandler.new
        task_handler.add_one_task({ id: 10, name: "task10", time_logs: [["2023-01-01 17:30:00", "2023-01-01 18:30:00"]] })
        output = task_handler.process_input
        desired_output = { categories: ["task10"], total_time_in_min: [60], occupation_percecntage: [4.17] }
        expect(output).to eq desired_output
     end
  end
end