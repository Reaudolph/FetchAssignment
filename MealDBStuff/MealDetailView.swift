//
//  MealDetailView.swift
//  MealDBStuff
//
//  Created by Hrishikesh Vikram on 10/26/23.
//

import Foundation
import SwiftUI
struct MealDetailView: View {
    let mealID: String
    @State private var mealDetail: MealDetail?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if let meal = mealDetail {
                    Text(meal.strMeal)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(numberedInstructions(meal.strInstructions), id: \.self) { instruction in
                            Text(instruction)
                                .font(.body)
                        }
                    }
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Ingredients:")
                            .font(.headline)
                        if let mealDetail = mealDetail {
                            ForEach(formattedIngredients(mealDetail), id: \.self) { ingredient in
                                Text(ingredient)
                            }
                        } else {
                            Text("Meal details not available")
                        }
                        
                    }
                    .padding()
                    
                } else {
                    ProgressView()
                }
            }
        }
        .onAppear {
            NetworkManager.shared.fetchMealDetail(id: mealID) { detail in
                self.mealDetail = detail
            }
        }
    }
    
    func numberedInstructions(_ instructions: String) -> [String] {
        let splitInstructions = instructions.split(separator: ".")
        return splitInstructions.enumerated().map { "\($0.offset + 1). \($0.element.trimmingCharacters(in: .whitespacesAndNewlines))" }
    }
    
    func formattedIngredients(_ mealDetail: MealDetail) -> [String] {
        return mealDetail.ingredients
    }
}
