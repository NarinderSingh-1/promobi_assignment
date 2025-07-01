class CreateCourses < ActiveRecord::Migration[7.1]
  DURATIONS = %w[3_months 6_months 12_months 18_months 2_years 3_years]

  def change
    create_enum :course_durations, DURATIONS

    create_table :courses do |t|
      t.string :name
      t.text   :description
      t.enum   :duration, enum_type: :course_durations, null: false, default: '6_months'

      t.timestamps
    end
  end
end
