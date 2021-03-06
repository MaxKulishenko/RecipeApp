//
//  SearchPageViewController.swift
//  RecipeApp
//
//  Created by Maksym on 26.05.2021.
//


import SDWebImage
import UIKit

class SearchPageViewController: UIViewController {
    // MARK: - IBOutlets
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchOptionView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButtonOutlet: UIButton!
    
    // MARK: - Vars
     
    var results: [Hit] = []
    var searchResults: [Hit] = []
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        searchTableView.tableFooterView = UIView()
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_textField:)), for: UIControl.Event.editingChanged)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isHidden = true
        
    }
    
    //MARK: - Methods
    
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
                    self?.searchTableView?.reloadData()
                    dump(self?.results)
                }
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
    
    private func dismissKeyboard() {
        view.endEditing(false)
    }
    
    @objc func textFieldDidChange(_textField: UITextField) {
        searchButtonOutlet.isEnabled = searchTextField.text != ""
        
        if searchButtonOutlet.isEnabled {
            searchButtonOutlet.backgroundColor = #colorLiteral(red: 0.6100037694, green: 0.7654177547, blue: 0.9525356889, alpha: 1)
        } else {
            disableSearchButton()
        }
    }
    
    private func disableSearchButton() {
        searchButtonOutlet.isEnabled = false
        searchButtonOutlet.backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
    }
    
    private func showSearchField() {
        disableSearchButton()
        // emptyTextField()
        animateSearchOptionsIn()
    }
    
    // MARK: - Animations
    
    private func animateSearchOptionsIn() {
        UIView.animate(withDuration: 0.5) {
            self.searchOptionView.isHidden = !self.searchOptionView.isHidden
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func showSearchBarButtonPressed(_ sender: Any) {
        dismissKeyboard()
        showSearchField()
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        dismissKeyboard()
        if let text = searchTextField.text {
            results = []
            searchTableView?.reloadData()
            fetchRecipes(query: text)
        }
    }
}

// MARK: - Extensions

extension SearchPageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SearchResultTableViewCell
        let imageUrl = results[indexPath.row].recipe.image
        if let url = URL(string: imageUrl) {
            cell.recipeImage.sd_setImage(with: url, completed: nil)
        }
        cell.recipeEnergy.text = "Energy: \(results[indexPath.row].recipe.calories.rounded()) kcal"
        cell.recipeName.text = results[indexPath.row].recipe.label
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRecipe = results[indexPath.row]
        DetailsViewController.result = selectedRecipe
    }
}
