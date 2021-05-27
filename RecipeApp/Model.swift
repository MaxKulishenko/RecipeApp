//
//  Model.swift
//  RecipeApp
//
//  Created by Maksym on 27.05.2021.
//

import Foundation

struct APIResponse: Codable {
    let q: String
    let from: Int
    let to: Int
    let more: Bool
    let count: Int
    let hits: [Hit]
}
struct Hit: Codable {
    var recipe: Recipe
}

struct Recipe: Codable {
    let uri: String
    let label: String
    let image: String
    let calories: Double
    let totalWeight: Double
    var ingredientLines: [String] = []
}

