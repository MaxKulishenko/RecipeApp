//
//  DetailsViewController.swift
//  RecipeApp
//
//  Created by Maksym on 28.05.2021.
//

import UIKit
import SDWebImage

class DetailsViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    @IBOutlet weak var recipeCaloriesLabel: UILabel!
    @IBOutlet weak var recipeTotalWeight: UILabel!
    
    @IBOutlet weak var recipeDescLabel: UILabel!
    @IBOutlet weak var favoritesButton: UIBarButtonItem!
    
    //MARK: - Vars
    
    static public var result: Hit?
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        setUpViews()
        guard let result = DetailsViewController.result else {return}
        if isRecipeInFavourites(recipe: result).isInFav {
            favoritesButton.image = UIImage(systemName: "heart.fill")
        }
        else {
            favoritesButton.image = UIImage(systemName: "heart")
        }
    }
    
    //MARK: - Methods
    
    public func isRecipeInFavourites(recipe: Hit) -> (isInFav: Bool, index: Int?) {
        
        var index = 0
        for favRecipe in FavoritesViewController.favouriteRecipes {
            if favRecipe?.recipe.label == recipe.recipe.label {
                return (true, index)
            }
            else {
                index += 1
            }
        }
        return (false, nil)
    }
    
    private func setUpViews() {
        guard let recipe = DetailsViewController.result,
              let imageURL = URL(string: recipe.recipe.image)
        else {
            return
        }
        recipeImage.sd_setImage(with: imageURL, completed: nil)
        recipeCaloriesLabel.text = "\(recipe.recipe.calories.rounded()) kcal"
        recipeTotalWeight.text = "\(recipe.recipe.totalWeight.rounded()) g"
        recipeNameLabel.text = "\(recipe.recipe.label)"
        recipeDescLabel.text = recipe.recipe.ingredientLines.joined(separator: "\n")
    }
    
    // MARK: - IBActions
    
    @IBAction func likeButtonPressed(_ sender: Any) {
        guard let result = DetailsViewController.result else {return}
        if isRecipeInFavourites(recipe: result).isInFav {
            guard let index = isRecipeInFavourites(recipe: result).index
            else {return}
            FavoritesViewController.favouriteRecipes.remove(at: index)
            favoritesButton.image = UIImage(systemName: "heart")
        }
        else {
            FavoritesViewController.favouriteRecipes.append(result)
            favoritesButton.image = UIImage(systemName: "heart.fill")
            print(FavoritesViewController.favouriteRecipes)
        }
    }
}
