//
//  SearchResultTableViewCell.swift
//  RecipeApp
//
//  Created by Maksym on 27.05.2021.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeImage: UIImageView!
    
    @IBOutlet weak var recipeName: UILabel!
    
    @IBOutlet weak var recipeEnergy: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        recipeImage.layer.cornerRadius = recipeImage.bounds.width / 2
        recipeImage.layer.masksToBounds = true
    }
    
}
