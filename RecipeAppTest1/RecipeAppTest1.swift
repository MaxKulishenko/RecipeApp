//
//  RecipeAppTest1.swift
//  RecipeAppTest1
//
//  Created by Maksym on 29.05.2021.
//

import XCTest
@testable import RecipeApp

class RecipeAppTest1: XCTestCase {

    func testIsRecipeInFavourites() {
        let recipe = Recipe(uri: "http://www.edamam.com/ontologies/edamam.owl#recipe_2283c0cc62744caa729a678f4080bd42", label: "Butter Pecan Ice Cream", image: "https://www.edamam.com/web-img/453/4535cd282d18e5a005c41e2d20dd83be.jpg", calories: 4126.389999999999, totalWeight: 1400.9, ingredientLines: ["6 large egg yolks", "6 Tbsp butter", "1 cup brown sugar", "1/4 teaspoon salt", "2 cups heavy cream", "2 cups whole milk", "1 teaspoon vanilla", "1 cup pecans", "Special equipment needed An ice cream maker, or a KitchenAid mixer with an ice cream attachment"])
        
        let hit = Hit(recipe: recipe)

        let detailsVC = DetailsViewController()
        FavoritesViewController.favouriteRecipes.append(hit)
        
        XCTAssertTrue(detailsVC.isRecipeInFavourites(recipe: hit).isInFav, "")
    }
    
}
