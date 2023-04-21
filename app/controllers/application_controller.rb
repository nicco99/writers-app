class ApplicationController < ActionController::Base

    before_action :authorize
    def encode_token(payload)
      # should store secret in env variable
      JWT.encode(payload, 'my_s3cr3t')
    end
  

    #getting token from auth header 
    def auth_header
      # { Authorization: 'Bearer <token>' }
      request.headers['Authorization']
    end
  
    def decoded_token
      if auth_header
        token = auth_header.split(' ')[1]
        # header: { 'Authorization': 'Bearer <token>' }
        begin
          JWT.decode(token, 'my_s3cr3t', true, algorithm: 'HS256')
        rescue JWT::DecodeError
          nil
        end
      end
    end
  
    def current_writer
      if decoded_token
        writer_id = decoded_token[0]['writer_id']
        @writer = Writer.find(writer_id)
      end
    end
    

    def logged_in?
     !!current_writer
    end
  
    def authorize
      render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
    end
end
