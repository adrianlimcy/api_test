# app/controllers/todos_controller.rb
class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :update, :destroy]

  # Get /todos
  def index
    @todos = Todo.all
    json_response(@todos)
  end

  # Post /todos
  def create
    @todo = Todo.create!(todo_params)
    json_response(@todo, :created)
  end

  # Get /todos/:id
  def show
    json_response(@todo)
  end

  # Put /todos/:id
  def update
    @todo.update(todo_params)
    head :no_content
  end

  # Delete /todos/:id
  def destroy
    @todo.destroy
    head :no_content
  end

  private

  def todo_params
    # whitelist params
    params.permit(:title, :created_by)
  end

  def set_todo
    @todo = Todo.find(params[:id])
  end
end
