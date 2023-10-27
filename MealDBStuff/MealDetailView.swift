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
                        .font(Font.custom("Helvetica Bold", size: 28))
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Ingredients:")
                            .font(Font.custom("Helvetica Bold", size: 18))
                            .padding(.leading)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                if let mealDetail = mealDetail {
                                    ForEach(formattedIngredients(mealDetail), id: \.self) { ingredient in
                                        Text(ingredient)
                                            .font(.body)
                                            .padding(.vertical, 5)
                                            .padding(.horizontal, 10)
                                            .background(Color.gray)
                                            .cornerRadius(10)
                                    }
                                } else {
                                    Text("Meal details not available")
                                }
                            }
                            .padding(.leading)
                            .padding(.trailing)
                        }
                    }
                    .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Instructions:")
                            .font(Font.custom("Helvetica Bold", size: 18))
                            .padding(.leading)
                        
                        ForEach(numberedInstructions(meal.strInstructions), id: \.self) { instruction in
                            Text(instruction)
                                .font(.body)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.horizontal) 
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
