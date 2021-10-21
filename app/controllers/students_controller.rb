class StudentsController < ApplicationController
    before_action :get_student, only: [:show, :update, :destroy]
    def index 
        @students = Student.all 
        if @students
            render json: @students, status: 200
        else 
            render json: {errors: "students not found"}, status: 404
        end
    end

    def show
        if @student
            render json: @student, status: 200
        else 
            render json: {errors: "student not found"}, status: 404
        end
    end

    def create 
        @student = Student.create(student_params)

        if @student.valid?
            render json: @student, status: 200
        else 
            render json: {errors: "validation errors"}, status: 422
        end
    end
    
    def update 
        if @student
            if @student.update(student_params)
                render json: @student, status: 200
            else 
                render json: {error: "Validation errors"}, status: 422
            end
        else
            render json: {error: "student not found"}, status: 404
        end
    end

    def destroy 
        @student.destroy
    end

        private

    def get_student
        @student = Student.find_by(id: params[:id])
    end

    def student_params
        params.permit(:name, :major, :age, :instructor_id)
    end

end
