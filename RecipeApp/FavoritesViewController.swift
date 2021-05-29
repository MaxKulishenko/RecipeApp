//
//  FavoritesViewController.swift
//  RecipeApp
//
//  Created by Maksym on 29.05.2021.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var favouriteRecipesTableView: UITableView!
    
    //MARK: - Vars
    
    static var favouriteRecipes: [Hit?] = []
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        favouriteRecipesTableView.tableFooterView = UIView()
        favouriteRecipesTableView.delegate = self
        favouriteRecipesTableView.dataSource = self
        print("FAVORITES")
        print(FavoritesViewController.favouriteRecipes)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isHidden = true
        favouriteRecipesTableView.reloadData()
        
    }
    
    
    
    
}

// MARK: - Extensions

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoritesViewController.favouriteRecipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SearchResultTableViewCell
        if let imageUrl = FavoritesViewController.favouriteRecipes[indexPath.row]?.recipe.image,
           let url = URL(string: imageUrl) {
            cell.recipeImage.sd_setImage(with: url, completed: nil)
        }
        cell.recipeEnergy.text = "Energy: \(FavoritesViewController.favouriteRecipes[indexPath.row]?.recipe.calories.rounded()) kcal"
        cell.recipeName.text = FavoritesViewController.favouriteRecipes[indexPath.row]?.recipe.label
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRecipe = FavoritesViewController.favouriteRecipes[indexPath.row]
        let detailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailsVC") as! DetailsViewController
        DetailsViewController.result = selectedRecipe
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}
