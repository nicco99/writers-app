class WritersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

     skip_before_action :authorize, only: [:create]
     
    def index
     writers = Writer.all
     render json: writers, status: :ok
    end

    def create
     writer = Writer.create!(writer_params)
     render json: writer, status: :created
    end 

    def show
    writer = Writer.find(params[:id])
      render json: writer, status: :ok
    end


    private

    def writer_params
    params.permit(:username, :email, :gender, :p_number, :first_name, :last_name, :password)
    end

    def record_not_found
        render json: {message: "Patient not found"}, status: :not_found
    end

    def record_invalid invalid
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end
end
