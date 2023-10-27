//
//  NetworkManager.swift
//  MealDBStuff
//
//  Created by Hrishikesh Vikram on 10/26/23.
//

import Foundation
import SwiftUI

class NetworkManager {
    static let shared = NetworkManager()
    let dessertURL = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    
    func fetchDessertMeals(completion: @escaping ([Meal]) -> Void) {
        guard let url = URL(string: dessertURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let mealsList = try JSONDecoder().decode(MealListResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(mealsList.meals)
                }
            } catch {
                print("Error: \(error)")
            }
        }.resume()
    }
    func fetchMealDetail(id: String, completion: @escaping (MealDetail) -> Void) {
        let detailURL = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)"
        guard let url = URL(string: detailURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let detailResponse = try JSONDecoder().decode(MealDetailResponse.self, from: data)
                if let detail = detailResponse.meals.first {
                    DispatchQueue.main.async {
                        completion(detail)
                    }
                }
            } catch {
                print("Error: \(error)")
            }
        }.resume()
    }
    
    
}


struct MealListResponse: Codable {
    let meals: [Meal]
}
struct MealDetailResponse: Codable {
    let meals: [MealDetail]
}

