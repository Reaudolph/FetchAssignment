//
//  ImageLoader.swift
//  MealDBStuff
//
//  Created by Hrishikesh Vikram on 10/26/23.
//

import Foundation
import SwiftUI
struct ImageLoader: View {
    @StateObject private var loader: Loader
    var loading: Image
    var failure: Image
    
    init(url: String, loading: Image = Image(systemName: "photo"), failure: Image = Image(systemName: "multiply.circle")) {
        _loader = StateObject(wrappedValue: Loader(url: url))
        self.loading = loading
        self.failure = failure
    }
    
    var body: some View {
        selectImage().resizable()
    }
    
    private func selectImage() -> Image {
        switch loader.state {
        case .loading:
            return loading
        case .failure:
            return failure
        default:
            return Image(uiImage: UIImage(data: loader.data) ?? UIImage())
        }
    }
}

private class Loader: ObservableObject {
    var data = Data()
    var state = LoadState.loading
    
    init(url: String) {
        guard let parsedURL = URL(string: url) else {
            fatalError("Invalid URL: \(url)")
        }
        
        URLSession.shared.dataTask(with: parsedURL) { data, _, _ in
            if let data = data, data.count > 0 {
                self.data = data
                self.state = .success
            } else {
                self.state = .failure
            }
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }.resume()
    }
}

private enum LoadState {
    case loading, success, failure
}
