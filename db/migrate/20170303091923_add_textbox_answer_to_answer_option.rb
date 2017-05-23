class AddTextboxAnswerToAnswerOption < ActiveRecord::Migration
  def change
    add_column :answer_options, :textbox_answer, :text
  end
end
