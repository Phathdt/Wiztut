class AddGradesAndSubjectsToProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles,:grades,  :text, array:true, default: []
    add_column :profiles,:subjects, :text, array:true, default: []
  end
end
