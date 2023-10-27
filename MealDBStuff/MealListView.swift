//
//  MealListView.swift
//  MealDBStuff
//
//  Created by Hrishikesh Vikram on 10/26/23.
//

import Foundation
import SwiftUI

struct MealListView: View {
    @State private var meals: [Meal] = []
    
    var gridLayout: [GridItem] = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var sortedMeals: [Meal] {
        meals.sorted(by: { $0.strMeal < $1.strMeal })
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridLayout, spacing: 15) {
                ForEach(sortedMeals) { meal in
                    NavigationLink(destination: MealDetailView(mealID: meal.idMeal)) {
                        VStack {
                            ImageLoader(url: meal.strMealThumb)
                                .frame(width: 150, height: 150)
                                .clipped()
                                .cornerRadius(8)
                            Text(meal.strMeal)
                                .font(Font.custom("Helvetica Bold", size: 12))
                                .foregroundColor(Color.black)
                                .multilineTextAlignment(.center)
                                .padding(.top, 5)
                        }
                    }
                }
            }
            .padding()
            
        }
        .padding(.top)
        .padding(.bottom, 2)
        .onAppear {
            NetworkManager.shared.fetchDessertMeals { fetchedMeals in
                self.meals = fetchedMeals
            }
        }
    }
}
