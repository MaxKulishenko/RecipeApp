//
//  SearchPageViewController.swift
//  RecipeApp
//
//  Created by Maksym on 26.05.2021.
//

import UIKit
import NVActivityIndicatorView


class SearchPageViewController: UIViewController {
    // MARK: - IBOutlets

    @IBOutlet var searchTableView: UITableView!
    @IBOutlet var searchOptionView: UIView!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButtonOutlet: UIButton!
    
    // MARK: - Vars

    let urlString = "https://api.edamam.com/search?q=chicken&app_id=\(Constants.app_id)&app_key=\(Constants.app_key)"
    
   

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRecipes()
        searchTableView.tableFooterView = UIView()

        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_textField:)), for: UIControl.Event.editingChanged)
    }

    
    
    // MARK: - IBActions

    @IBAction func showSearchBarButtonPressed(_ sender: Any) {
        dismissKeyboard()
        showSearchField()
    }

    @IBAction func searchButtonPressed(_ sender: Any) {
    }

    // MARK: - Functions
    
    
    func fetchRecipes() {
        
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
                dump(jsonResult.hits)
            }
            catch {
                print(error)
            }
            
            
        }
    
        task.resume()
    }
    
    // MARK: - Helpers

    
    
    
    private func emptyTextField() {
        searchTextField.text = " "
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
        emptyTextField()
        animateSearchOptionsIn()
    }

    // MARK: - Animations

    private func animateSearchOptionsIn() {
        UIView.animate(withDuration: 0.5) {
            self.searchOptionView.isHidden = !self.searchOptionView.isHidden
        }
    }
}

// MARK: - Extensions

extension SearchPageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
