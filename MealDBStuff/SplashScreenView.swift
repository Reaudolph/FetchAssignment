//
//  SplashScreenView.swift
//  MealDBStuff
//
//  Created by Hrishikesh Vikram on 10/26/23.
//

import SwiftUI

struct SplashScreenView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image("veryGoodLookingSalad")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("Better Recipies than Martha Stewart")
                .font(Font.custom("Helvetica Bold", size: 18))
                .foregroundColor(.gray)
        }
        .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}
