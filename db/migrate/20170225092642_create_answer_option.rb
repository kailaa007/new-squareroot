class CreateAnswerOption < ActiveRecord::Migration
  def change
    create_table :answer_options do |t|  
      t.integer :birth_plan_answer_id
      t.integer :option_id
    end
  end
end
