//
//  TabNavigator.swift
//  ZMPAI
//
//  Created by Jakub Radzik on 02/10/2024.
//

import SwiftUI

struct TabNavigator: View {
    var body: some View {
        TabView {
            ContentView(image: "air_pods")
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
            }
            ContentView(image: "apple_watch")
                .tabItem {
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    TabNavigator()
}
