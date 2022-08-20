# app/controllers/concerns/response.rb
# A helper method that returns any json response
module Response
  def json_response(object, serializer: ApplicationSerializer, status: :ok)
    render json: object, status: status, each_serializer: serializer
  end
end