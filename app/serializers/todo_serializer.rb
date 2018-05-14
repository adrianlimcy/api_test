# app/serializer/todo_serializer.rb
class TodoSerializer < ActiveModel::Serializer
  # attributes to be serialized
  attributes :id, :title, :created_by, :updated_at
  # model assocation
  has_many :items
end
