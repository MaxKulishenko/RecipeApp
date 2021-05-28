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
    @IBOutlet weak var recipeEnergyLabel: UILabel!
    @IBOutlet weak var recipeUnitLabel: UILabel!
    @IBOutlet weak var recipeProteinLabel: UILabel!
    @IBOutlet weak var recipeFatLabel: UILabel!
    @IBOutlet weak var recipeCarbsLabel: UILabel!
    
    //MARK: - Vars
    
    var results: [Hit] = []
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    //MARK: - Functions
    
    func fetchRecipes(query: String) {
        let urlString = "https://api.edamam.com/search?q=\(query)&app_id=\(Constants.app_id)&app_key=\(Constants.app_key)"
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }

            do {
                let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.results = jsonResult.hits
//                    self?.searchTableView?.reloadData()
                    dump(self?.results)
                }
            } catch {
                print(error)
            }
        }

        task.resume()
    }

    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true) {
    
        }
    }
    
    @IBAction func likeButtonPressed(_ sender: Any) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
