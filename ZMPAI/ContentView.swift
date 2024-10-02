//
//  ContentView.swift
//  ZMPAI
//
//  Created by Jakub Radzik on 02/10/2024.
//

import SwiftUI

struct ContentView: View {
    var image: String
    
    var body: some View {
        Image(image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 300, height: 300)
    }
}

#Preview {
    ContentView(image: "air_pods")
}
