class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find_by_id(params[:id])
  end

  def new
    @recipe = Recipe.new
  end

  def edit
    @recipe = Recipe.find_by_id(params[:id])
  end

  def create
    @recipe = Recipe.create(recipe_params)
    redirect_to recipe_path(@recipe)
  end

  def update
    @recipe = Recipe.find_by_id(params[:id])
    @recipe.update(recipe_params)
    redirect_to recipe_path(@recipe)
  end

  def destroy
    @recipe = Recipe.find_by_id(params[:id])
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :ingredient_ids => [])
  end

end
