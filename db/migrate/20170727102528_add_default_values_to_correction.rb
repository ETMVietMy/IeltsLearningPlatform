class AddDefaultValuesToCorrection < ActiveRecord::Migration[5.1]
  def change
    change_column_default :corrections, :task_achievement, 0
    change_column_default :corrections, :coherence_cohesion, 0
    change_column_default :corrections, :lexical_resource, 0
    change_column_default :corrections, :grammar, 0
    change_column_null :corrections, :task_achievement, 0
    change_column_null :corrections, :coherence_cohesion, 0
    change_column_null :corrections, :lexical_resource, 0
    change_column_null :corrections, :grammar, 0
  end
end
