class AddStuffToProblem < ActiveRecord::Migration[5.1]
  def change
    change_table :problems do |p|
      p.integer :timeout
      p.boolean :has_input

      # This might start to smell like a 1-1 to a validation class, but at this point,
      # for the size of this application, we'd never need one without the other.
      p.boolean :auto_judge
      p.boolean :ignore_case
      p.string :whitespace_rule, default: "plain diff"
    end
  end
end
