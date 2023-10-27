//
//  MealModel.swift
//  MealDBStuff
//
//  Created by Hrishikesh Vikram on 10/26/23.
//

import Foundation
struct Meal: Identifiable, Codable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    
    var id: String {
        idMeal
    }
}

struct MealDetail: Codable {
    let idMeal: String
    let strMeal: String
    let strInstructions: String
    let strMealThumb: String
    let ingredients: [String]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKey.self)
        
        idMeal = try container.decode(String.self, forKey: .init(stringValue: "idMeal")!)
        strMeal = try container.decode(String.self, forKey: .init(stringValue: "strMeal")!)
        strInstructions = try container.decode(String.self, forKey: .init(stringValue: "strInstructions")!)
        strMealThumb = try container.decode(String.self, forKey: .init(stringValue: "strMealThumb")!)
        
        var ingredientsArray: [String] = []
        for index in 1...20 {
            let ingredientKey = DynamicCodingKey(stringValue: "strIngredient\(index)")
            let measureKey = DynamicCodingKey(stringValue: "strMeasure\(index)")
            
            if let ingredientKey = ingredientKey, let ingredient = try? container.decode(String.self, forKey: ingredientKey),
               let measureKey = measureKey, let measure = try? container.decode(String.self, forKey: measureKey),
               !ingredient.isEmpty && !measure.isEmpty {
                ingredientsArray.append("\(measure) \(ingredient)")
            }
            
        }
        
        ingredients = ingredientsArray
    }
}
struct DynamicCodingKey: CodingKey {
    var stringValue: String
    var intValue: Int?
    
    init?(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = nil
    }
    
    init?(intValue: Int) {
        self.stringValue = String(intValue)
        self.intValue = intValue
    }
}
