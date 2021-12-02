class ListsController < ApplicationController
  before_action :find_list, only: %i[show edit destroy update]

  def index
    list_scope = List.all
    @pagy, @lists = pagy(list_scope)
  end

  def new
    @list = List.new
  end

  def show
    @solutions = Solution.where(list_id: params[:id])
    @products = []
    @solutions.each do |solution|
      @products << Product.find(solution.product_id)
    end
  end

  def create
    @list = List.create(list_params)
    redirect_to new_list_solution_path(@list)
  end

  def edit
  end

  def update
    @list.update(list_params)
    redirect_to list_path(@list)
  end

  def destroy
    @list.destroy
    redirect_to lists_path
  end

  private

  def find_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :description)
  end
end
