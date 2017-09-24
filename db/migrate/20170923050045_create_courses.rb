class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.integer :teacher_id
      t.integer :student_id
      t.boolean :status,    default: false

      t.timestamps
    end
    add_index :courses, :teacher_id
    add_index :courses, :student_id
    
  end
end
