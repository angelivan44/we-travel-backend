class DepartmentsController < ApplicationController
  before_action :current_departmen , only: %i[show , edit , destroy] 

  def index
    departems = Department.all
    render json: departems
  end
  
  def show
    render json: current_departmen
  end

  def create
    department = Department.new(department_params)
    if department.save
      render json: department
    else
      render json: department.errors
    end
  end

  def edit
    if current_departmen.update(department_params)
      render json: current_departmen
    else
      render json: current_departmen.errors
    end
  end

  def destroy
    if current_departmen.destroy
      render json: {message: "ok"}
    else
      render json: current_departmen.errors
    end
  end

  def current_departmen
    Department.find(params[:id])
  end

  def department_params
    params.permit(:name, :description, :cover)
  end
end
