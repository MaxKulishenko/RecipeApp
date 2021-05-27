//
//  SearchPageViewController.swift
//  RecipeApp
//
//  Created by Maksym on 26.05.2021.
//

import UIKit

class SearchPageViewController: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchOptionView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButtonOutlet: UIButton!
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchTextField.addTarget(self, action: #selector(self.textFieldDidChange(_textField:)), for: UIControl.Event.editingChanged)
    }
    
    //MARK: - IBActions
    
    @IBAction func showSearchBarButtonPressed(_ sender: Any) {
    }
    @IBAction func searchButtonPressed(_ sender: Any) {
    }
    
    //MARK: - Helpers
    
    private func emptyTextField() {
        searchTextField.text = " "
    }
    
    private func dismissKeyboard() {
        self.view.endEditing(false)
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
    
}

    //MARK: - Extensions

extension SearchPageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
