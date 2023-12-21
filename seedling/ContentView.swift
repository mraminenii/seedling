//
//  ContentView.swift
//  Seedling
//
//  Created by Wai Shuen Wu on 11/16/22.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @State private var selection = 0
    @State private var isLoggedIn : Bool = false
    
    var body: some View {
        if !isLoggedIn {
            LogInView(isLoggedIn: $isLoggedIn)
        } else {
            TabView(selection: $selection) {
                MainView()
                    .tabItem() {
                        Image(systemName: "leaf.fill")
                        Text("Home")
                            
                    }
                    .tag(0)
                StopwatchView()
                    .tabItem() {
                        Image(systemName: "clock.fill")
                        Text("Stopwatch")
                    }
                    .tag(1)
                SettingsView()
                    .tabItem() {
                        Image(systemName: "gearshape.2.fill")
                        Text("Settings")
                    }
                    .tag(2)
            }
            .onAppear {
                            // correct the transparency bug for Tab bars
                            let tabBarAppearance = UITabBarAppearance()
                            tabBarAppearance.configureWithOpaqueBackground()
                            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                            // correct the transparency bug for Navigation bars
                            let navigationBarAppearance = UINavigationBarAppearance()
                            navigationBarAppearance.configureWithOpaqueBackground()
                            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
                        }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
