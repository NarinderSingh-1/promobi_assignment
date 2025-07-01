module Api
  module V1
    class CoursesController < ApplicationController
      def create
        course_attrs = course_params.except(:tutors_attributes)
        tutor_attrs  = course_params[:tutors_attributes]

        ActiveRecord::Base.transaction do
          course = Course.create!(course_attrs)

          tutor_attrs.each do |tutor_param|
            course.tutors.create!(tutor_param)
          end

          render json: course, status: :created
        end
      rescue ActiveRecord::RecordInvalid => e
        render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
      end

      def index
        render json: Course.includes(:tutors), status: :ok
      end

      private

      def course_params
        params.require(:course).permit(:name, :description, :duration, tutors_attributes: [:name, :email, :phone])
      end
    end
  end
end
