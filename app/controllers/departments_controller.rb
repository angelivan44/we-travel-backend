class DepartmentsController < ApplicationController
  before_action :current_departmen , only: %i[show , update , destroy] 
  skip_before_action :require_login, only: %i[index , show]
  include Pundit
  
  def index
    departems = Department.all
    render json: departems.map{ |department| department.as_json(include: :posts, methods: :service_url)}
  end
  
  def show
    render json: current_departmen.as_json(include: [:posts] , methods: :service_url)
  end

  def create

    department = Department.new(department_params)
    authorize department
    if department.save
      render json: department.as_json(include: [:posts] , methods: :service_url)
    else
      render json: department.errors
    end
  end

  def update
    authorize current_departmen
    if current_departmen.update(department_params)
      render json: current_departmen.as_json(include: [:posts] , methods: :service_url)
    else
      render json: current_departmen.errors
    end
  end

  def destroy
    authorize current_departmen
    if current_departmen.destroy
      render json: {message: "ok"}
    else
      render json: current_departmen.errors
    end
  end

  def current_departmen
    department = Department.find(params[:id])
  end

  def department_params
    params.permit(:name, :description, :cover)
  end
end
