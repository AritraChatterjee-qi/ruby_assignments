#require './Assignment_05.rb'
#include './Assignment_05.rb'

require_relative '../Assignment_05.rb'
require 'spec_helper.rb'

RSpec.describe Task do 
    context “When testing the Task class” do 
       
       it "Testing total_time_in_minute method of the class" do 
          task = Task.new( 10, "task10", [["2023-01-01 17:30:00", "2023-01-01 18:30:00"]] )
          output = task.total_time_in_minute
          expect(output).to eq 60
       end

       it "Testing occupation_percecntage_day_wise method of the class" do 
          task = Task.new( 10, "task10", [["2023-01-01 17:30:00", "2023-01-01 18:30:00"]] )
          output = task.occupation_percecntage_day_wise
          expect(output).to eq 1.47
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
    