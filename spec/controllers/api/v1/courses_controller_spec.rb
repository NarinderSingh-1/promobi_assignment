require 'rails_helper'

RSpec.describe Api::V1::CoursesController, type: :request do
  subject { post '/api/v1/courses', params: params }

  let(:params) do
    {
      course: {
        name:              'Ruby on Rails',
        description:       'Backend web development',
        duration:          '6_months',
        tutors_attributes: tutors_attributes
      }
    }
  end
  let(:tutors_attributes) do
    [
      { name: 'Narinder Singh', email: 'narinder@example.com', phone: '1234567890' },
      { name: 'Tutor 2',        email: 'tutor2@example.com',   phone: '1234567890' }
    ]
  end
  let(:success_response) do
    {
      'id'          => Course.last.id,
      'name'        => Course.last.name,
      'description' => Course.last.description,
      'duration'    => Course.last.duration,
      'tutors' => [
        { 
          'id'    => Tutor.first.id,
          'name'  => Tutor.first.name,
          'email' => Tutor.first.email,
          'phone' => Tutor.first.phone
        },
        {
          'id'    => Tutor.last.id,
          'name'  => Tutor.last.name,
          'email' => Tutor.last.email,
          'phone' => Tutor.last.phone
        }
      ]
    }
  end

  before do
    Course.destroy_all
    Tutor.destroy_all
  end

  describe 'Create Course API' do
    context 'with valid params' do
      it 'creates a course with tutors' do
        expect{subject}.to change(Course, :count).by(1)
          .and change(Tutor, :count).by(2)

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to eq(success_response)
      end
    end

    context 'with invalid params' do
      let(:params) { { course: { name: '' } } }

      it 'returns error for invalid data' do

        expect{subject}.not_to change(Course, :count)
        expect{subject}.not_to change(Tutor, :count)
        expect(response).to have_http_status(422)

        json = JSON.parse(response.body)
        expect(json['errors']).to include("Name can't be blank")
      end
    end

    context 'when invalid enum duration' do
      let(:params) { { course: { name: 'ROR', duration: '5_weeks' } } }

      it 'returns error for invalid data' do

        expect{subject}.not_to change(Course, :count)
        expect{subject}.not_to change(Tutor, :count)
        expect(response).to have_http_status(422)

        json = JSON.parse(response.body)
        expect(json['errors']).to include('Duration is not included in the list')
      end
    end

    context 'when tutor is duplicate' do
      let(:tutors_attributes) do
        [
          { name: 'Tutor 1', email: 'tutor1@example.com', phone: '1234567890' },
          { name: 'Tutor 1', email: 'tutor1@example.com', phone: '1234567890' }
        ]
      end
          
      it 'returns error for invalid data' do

        expect{subject}.not_to change(Course, :count)
        expect{subject}.not_to change(Tutor, :count)
        expect(response).to have_http_status(422)

        json = JSON.parse(response.body)
        expect(json['errors']).to include('Email has already been taken')
      end
    end

  end

  describe 'Get List of Courses' do
    before do
      create(:course, :with_tutors)
    end

    let(:courses_list) do
      [
        {
          'id'          => Course.last.id,
          'name'        => Course.last.name,
          'description' => Course.last.description,
          'duration'    => Course.last.duration,
          'tutors' => [
            { 
              'id'    => Tutor.first.id,
              'name'  => Tutor.first.name,
              'email' => Tutor.first.email,
              'phone' => Tutor.first.phone
            },
            {
              'id'    => Tutor.last.id,
              'name'  => Tutor.last.name,
              'email' => Tutor.last.email,
              'phone' => Tutor.last.phone
            }
          ]
        }
      ]
    end


    it 'lists all courses with tutors' do
      get '/api/v1/courses'
      expect(response).to have_http_status(:ok)

      result = JSON.parse(response.body)

      expect(result).to be_an(Array)
      expect(result).to eq(courses_list)
    end
  end
end
