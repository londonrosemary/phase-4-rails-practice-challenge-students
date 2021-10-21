class InstructorsController < ApplicationController
    before_action :get_instructor, only: [:show, :update, :destroy]

    def index 
        @instructors = Instructor.all 
        if @instructors
            render json: @instructors, status: 200
        else 
            render json: {errors: "instructors not found"}, status: 404
        end
    end

    def show 
        if @instructor
            render json: @instructor, status: 200
        else 
            render json: {errors: "instructor not found"}, status: 404 
        end
    end

    def create 
        @instructor = Instructor.create(instructor_params)

        if @instructor.valid?
            render json: @instructor, status: 200
        else 
            render json: {errors: "validation errors"}, status: 422
        end
    end

    def update 
        if @instructor
            if @instructor.update(instructor_params)
                render json: @instructor, status: 200
            else 
                render json: {error: "Validation errors"}, status: 422
            end
        else
            render json: {error: "instructor not found"}, status: 404
        end
    end

    def destroy 
        @instructor.destroy
    end

    private

    def get_instructor
        @instructor = Instructor.find_by(id: params[:id])
    end

    def instructor_params
        params.permit(:name)
    end
end
