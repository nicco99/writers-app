class WriterSerializer < ActiveModel::Serializer
  attributes :username, :email, :gender, :p_number, :first_name, :last_name
end
