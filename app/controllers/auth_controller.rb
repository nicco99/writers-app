class AuthController < ApplicationController
    skip_before_action :authorize, only:[:create]
    def create
        writer = Writer.find_by(email: params[:email])
        if writer&.authenticate(params[:password])
            token = encode_token(writer_id: writer.id)
            render json: { writer: WriterSerializer.new(writer), jwt: token }, status: :ok
        else
            render json: { errors: "Invalid email or password" }, status: :unauthorized
        end
    end
end
