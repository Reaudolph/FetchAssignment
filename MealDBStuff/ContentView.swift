//
//  ContentView.swift
//  MealDBStuff
//
//  Created by Hrishikesh Vikram on 10/26/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showSplash = true
    
    var body: some View {
        Group {
            if showSplash {
                SplashScreenView()
            } else {
                NavigationView {
                    MealListView()
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { 
                withAnimation {
                    showSplash = false
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
