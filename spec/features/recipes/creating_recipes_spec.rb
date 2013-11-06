require 'spec_helper'

describe "creating recipes" do
  context "on the new recipe page" do

    # Is there a form with the given HTML ID?
    it "should have a form to create the recipes" do
      visit new_recipe_path

      expect(page).to have_css("form#new_recipe")
    end

    # Does the recipe get created?
    # Is the user redirected to a page that displays the recipe name?
    it "should create a recipe when the form is submitted" do
      visit new_recipe_path

      fill_in 'recipe_name', with: 'Candy Corn Dumplings'
      click_button('Create Recipe')

      Recipe.first.name.should == "Candy Corn Dumplings"
      expect(page).to have_content("Candy Corn Dumplings")
    end

    # Does the recipe get successfully created with 1 ingredient?
    # HINT: You need to use checkboxes. Each checkbox should have a CORRECTLY
    #       implemented HTML label
    #       (i.e. clicking on the <label> checks/unchecks the box).
    it "should create a recipe with one ingredient" do
      Ingredient.create(name: 'Spam')

      visit new_recipe_path

      fill_in 'recipe_name', with: 'Spam Cakes'

      check('Spam')
      click_button('Create Recipe')

      Recipe.first.ingredients.where(name: 'Spam').count.should == 1
    end


    # Does the recipe get successfully created with many ingredients?
    # HINT: You need to use checkboxes. Each checkbox should have a CORRECTLY
    #       implemented HTML label
    #       (i.e. clicking on the <label> checks/unchecks the box).
    it "should create a recipe with many ingredients" do
      Ingredient.create(name: 'Paprika')
      Ingredient.create(name: 'Clove')
      Ingredient.create(name: 'Ginger')
      Ingredient.create(name: 'Cider')

      visit new_recipe_path

      fill_in 'recipe_name', with: 'Holiday Spice Cider'

      check('Paprika')
      check('Clove')
      check('Ginger')
      check('Cider')

      click_button('Create Recipe')

      Recipe.first.ingredients.count.should == 4
    end


    # Does the recipe get successfully created with 0 ingredients?
    # HINT: You need to use checkboxes. Each checkbox should have a CORRECTLY
    #       implemented HTML label
    #       (i.e. clicking on the <label> checks/unchecks the box).
    it "should create a recipe with 0 ingredients" do
      visit new_recipe_path

      fill_in 'recipe_name', with: 'Recipe in Progress'

      click_button('Create Recipe')

      Recipe.first.ingredients.count.should == 0
    end
  end
end
